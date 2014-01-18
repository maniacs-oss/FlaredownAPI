# reload!;e=Entry.create(date: Date.today, catalogs:["cdai"])
module CdaiCatalog
  extend ActiveSupport::Concern
  
  CDAI_QUESTIONS    = %i( complication_arthritis complication_iritis complication_erythema complication_fever complication_fistula complication_other_fistula opiates stools ab_pain general mass hematocrit weight_current weight_typical )
  # BOOLEAN_QUESTIONS = %i( complication_arthritis complication_iritis complication_erythema complication_fever complication_fistula complication_other_fistula opiates )
  # INTEGER_QUESTIONS = %i( stools ab_pain general mass hematocrit weight_current )
  
  included do |base_class|
    base_class.question_names = base_class.question_names.push(*CDAI_QUESTIONS).uniq
    
    before_save :score_cdai_entry
    
    class ::Response
      validates_inclusion_of :value, in: [*0..30],   message: "not within allowed values", if: Proc.new{|r| r.id == "stools"}
      validates_inclusion_of :value, in: [*0..3],    message: "not within allowed values", if: Proc.new{|r| r.id == "ab_pain"}
      validates_inclusion_of :value, in: [*0..4],    message: "not within allowed values", if: Proc.new{|r| r.id == "general"}
      validates_inclusion_of :value, in: [0,3,5],    message: "not within allowed values", if: Proc.new{|r| r.id == "mass"}
      validates_inclusion_of :value, in: [*0..100],  message: "not within allowed values", if: Proc.new{|r| r.id == "hematocrit"}
      validates_inclusion_of :value, in: [*25..500], message: "not within allowed values", if: Proc.new{|r| r.id == "weight_current"}
      validates_inclusion_of :value, in: [*25..500], message: "not within allowed values", if: Proc.new{|r| r.id == "weight_typical"}
    
      validates_inclusion_of :value, in: [true,false],  message: "not within allowed values",
        if: Proc.new {|r| %w( complication_arthritis complication_iritis complication_erythema complication_erythema complication_fever complication_other_fistula opiates ).include?(r.id) }
    end
  end
  
  def valid_cdai_entry?
    return false if responses.empty?
    (CDAI_QUESTIONS - responses.reduce([]) {|accu, response| (accu << response.id.to_sym) if response.id}) == []
  end
  
  # def date
  #   created_at.beginning_of_day.to_datetime.to_i#*1000
  # end
  
  def score_cdai_entry
    self.scores << {id: "cdai", value: nil} unless cdai_score.present?
    cdai_score.value = self.calculate_cdai_score if valid_cdai_entry?
    # Resque.enqueue(Entry, self.id)
    # REDIS.hset("charts:cdai_score:#{self.user_id}", self.date.to_i, self.score)
  end
    
  # TODO enable Redis/Resque on Heroku to use this code
  # def self.perform(entry_id)
  #   entry = Entry.find_by_id(entry_id)
  #   entry.update_column :score, entry.calculate_cdai_score
  #   REDIS.hset("charts:cdai_score:#{entry.user_id}", entry.date.to_i, entry.score) if entry
  # end
  
  def cdai_score
    self.scores.select{|s| s.id == "cdai"}.first
  end
  def calculate_cdai_score
		tally = 0
    
		start_range = date - 7.days
		end_range = date
		past_entries = Entry.by_date.startkey(start_range).endkey(end_range).to_a

    if past_entries.present?
  		# past
      tally += cdai_stool_score(past_entries)
      tally += cdai_ab_pain_score(past_entries)
      tally += cdai_general_score(past_entries)
            
      tally += 20 if past_entries.select {|e| e.complication_fever}.length > 0
            
      # current
      [:complication_arthritis, :complication_erythema, :complication_fistula, :complication_other_fistula, :complication_iritis].each do |question_name|
        tally += 20 if self.send(question_name)
      end
            
      tally += 30 if opiates
      tally += mass * 10
      tally += (46 - hematocrit) * 6
      tally += cdai_weight_score
    end

		tally
	end

	def cdai_stool_score(past_entries)
		past_entries.
			map {|e| e.stools}.
			inject(:+) * 2
	end	

	def cdai_ab_pain_score(past_entries)
		past_entries.
			map {|e| e.ab_pain}.
			inject(:+) * 5
	end	

	def cdai_general_score(past_entries)
		past_entries.
			map {|e| e.general}.
			inject(:+) * 7
	end	

	def cdai_weight_score
		factor = ((weight_current - User.find(user_id).weight) / weight_current) * 100
		[factor, -10].max
	end
  
end