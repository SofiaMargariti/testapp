class Vessel < ActiveRecord::Base
  validates :title, :description, :daily_price, :fee_pc, :presence => true
  validates :daily_price, :fee_pc, :numericality => true
end
