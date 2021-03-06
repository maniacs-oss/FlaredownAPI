require 'spec_helper'

describe Rapid3Catalog do
  describe "#score" do
    let(:user) { create :user }
    let!(:entry) { create :rapid3_entry }
    describe "General" do
      it "should have a score queue in resque" do
        expect(Entry).to have_queue_size_of(1)
      end

      it "should validate responses" do
        range_response = entry.responses.detect{|q| q.name == "dress_yourself"}
        range_response.value = nil
        expect(entry).to be_valid

        range_response.value = 999
        expect(entry).to be_invalid

        range_response.value = 1
        expect(entry).to be_valid
      end

      it "isn't complete if nils responses are present" do
        response = entry.responses.detect{|q| q.name == "dress_yourself"}
        response.value = nil
        expect(entry.complete_rapid3_entry?).to be_false
      end

    end

    describe "Scoring" do
      let(:entry) { create :rapid3_entry, user: user }
      it "has a score if all responses are present" do
        expect(entry.responses.count).to eq Rapid3Catalog::QUESTIONS.count
        expect(entry.rapid3_score).to be > 0
      end
      it "reverts to -1 (incomplete) if any responses are removed", :disabled => true do
        # TODO Apparently Mongo has some issues deleting embedded docs...
        # https://jira.mongodb.org/browse/MONGOID-3966?jql=text%20~%20%22delete%20embedded%22

        entry.responses.first.delete
        with_resque{ entry.save }; entry.reload

        expect(entry.responses.count).to be < Rapid3Catalog::QUESTIONS.count
        expect(entry.reload.rapid3_score).to eql -1.0
      end

      describe "Calculations" do
        let(:entry) { build :rapid3_entry, user: user }
        it "sample entry scores match calculated scores" do
          entry.responses << build(:response, {catalog: "rapid3", name: :dress_yourself        , value: 0})
          entry.responses << build(:response, {catalog: "rapid3", name: :get_in_out_of_bed     , value: 1})
          entry.responses << build(:response, {catalog: "rapid3", name: :lift_full_glass       , value: 3})
          entry.responses << build(:response, {catalog: "rapid3", name: :walk_outdoors         , value: 0})
          entry.responses << build(:response, {catalog: "rapid3", name: :wash_and_dry_yourself , value: 0})
          entry.responses << build(:response, {catalog: "rapid3", name: :bend_down             , value: 1})
          entry.responses << build(:response, {catalog: "rapid3", name: :turn_faucet           , value: 2})
          entry.responses << build(:response, {catalog: "rapid3", name: :enter_exit_vehicles   , value: 2})
          entry.responses << build(:response, {catalog: "rapid3", name: :walk_two_miles        , value: 1})
          entry.responses << build(:response, {catalog: "rapid3", name: :play_sports           , value: 1})

          entry.responses << build(:response, {catalog: "rapid3", name: :pain_tolerance        , value: 2.5})
          entry.responses << build(:response, {catalog: "rapid3", name: :global_estimate       , value: 1.0})

          entry.save
          Entry.perform entry.id
          entry.reload

          expect(entry.rapid3_functional_status_score).to eql 3.7
          expect(entry.rapid3_pain_tolerance_score).to eql    2.5
          expect(entry.rapid3_global_estimate_score).to eql   1.0
          expect(entry.rapid3_score).to eql                   7.2
        end
      end
    end

  end
end
