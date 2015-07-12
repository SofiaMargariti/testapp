class Vessel < ActiveRecord::Base
  validates :title, :description, :daily_price, :presence => true
  validates :daily_price, :numericality => true
end
