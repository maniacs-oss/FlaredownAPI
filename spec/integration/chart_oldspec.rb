require "spec_helper"

# feature "Chart Functions" do
#
#   let(:user) { create :user }
#   before(:each) do
#     3.times{|i| with_resque{ create :hbi_entry, user: user, date: Date.today-i.days}}
#   end
#
#   scenario "see recent entries charted" do
#     login
#     expect(all("circle.score")).to have(3).items
#   end
#
#   # scenario "open modal by clicking a circle" do
#   #   Capybara.current_driver = :selenium # for clicking canvas stuff
#   #   login
#   #   # sleep(2)
#   #   all("circle.score").first.click()
#   #   expect(find(".modal")).to be_visible
#   # end
#
# end