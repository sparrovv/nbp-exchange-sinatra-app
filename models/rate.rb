class AverageRate
  include Mongoid::Document

  field :date, :type => Date
  field :value, :type => Float

  embedded_in :currency

  validates_uniqueness_of :date
  validates_presence_of :date
  validates_presence_of :value

  def self.find_last_available(date)
    # Had problems on heroku cause doesn't worked well when orddered by DESC - this is the safest way
    where(:date.lte => date).order_by(:date).last
  end

end
