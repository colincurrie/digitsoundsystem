class Contact
  include ActiveModel::Model

  attr_accessor :name, :email, :date, :venue, :details

  validates_presence_of :name, :email, :date, :venue, :details
end