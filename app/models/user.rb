# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders

  after_create :welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def welcome_email
  	UserMailer.with(user: self).welcome_email.deliver_now
  end
end
