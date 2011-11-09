class AverageRate
  include Mongoid::Document

  field :date, :type => Date
  field :value, :type => Float

  embedded_in :currency

  validates_uniqueness_of :date
  validates_presence_of :date
  validates_presence_of :value

  def self.find_last_available(date)
    ordered = where(:date.lte => date).order_by(:date, :desc).all
    ordered.first
  end

end
