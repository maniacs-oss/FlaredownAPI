class Entry < CouchRest::Model::Base
  include ActiveModel::SerializerSupport
  include CatalogScore
  AVAILABLE_CATALOGS = %w( hbi )

  @queue = :entries
  cattr_accessor(:question_names) {[]}

  def initialize(attributes={}, options={})
    super(attributes, options)
    include_catalogs
  end

  before_save :include_catalogs
  after_save :enqueue

  belongs_to :user

  property :date,       Date
  property :catalogs,   [String]

  property :responses,  Response,  :array => true
  property :treatments, Treatment, :array => true
  property :scores,     Score,     :array => true

  timestamps!

  design do
    view :by_date
    view :by_user_id
  end

  def catalog_definitions
    self.catalogs.map{|c| "#{c.capitalize}Catalog".constantize.const_get("#{c.upcase}_DEFINITION") }
  end

  def questions
    Question.where(catalog: self.catalogs)
  end

  def enqueue
    Resque.enqueue(Entry, self.id)
  end

  def chart_data
    chart = CatalogChart.new(self.user_id, self.catalogs, self.date, self.date)
    chart.data
  end

  def complete?
    catalogs.each{|catalog| return false unless self.send("complete_#{catalog}_entry?")}
    true
  end

  def self.perform(entry_id)
    entry = Entry.find(entry_id)

    entry.catalogs.each do |catalog|
      # entry.update_upcoming_catalog(catalog)
      entry.send("save_score", catalog)
      Entry.skip_callback(:save, :after, :enqueue)
      entry.save
      # Pusher.trigger("entries_for_#{entry.user_id}", "updates", {entry_date: entry.date, data: entry.chart_data}) if entry.complete?
      Entry.set_callback(:save, :after, :enqueue)
    end

    true
  end

  private
  def include_catalogs
    if catalogs.present?
      loadable_catalogs = catalogs.select{|catalog| AVAILABLE_CATALOGS.include?(catalog)}
      loadable_catalogs.each{|catalog| self.class_eval { include "#{catalog}_catalog".classify.constantize }}
    end
  end
  def method_missing(name, *args)
    if self.question_names.include?(name)
      response = responses.select{|r| r.name.to_sym == name}.first
      return response.value if response
    elsif match = name.to_s.match(/(\w+)_score\Z/)
      self.scores.select{|s| s[:name] == match[1] }.first.value
    else
      super(name, *args)
    end
  end


end