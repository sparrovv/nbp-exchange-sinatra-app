class Currency
  include Mongoid::Document

  field :symbol, :type => String
  field :name, :type => String

  embeds_many :average_rates

  validates_presence_of :symbol
  validates_uniqueness_of :symbol
  validates_presence_of :name

  def self.find_by_symbol(symbol)
    where(:symbol => symbol.downcase).first
  end
end
