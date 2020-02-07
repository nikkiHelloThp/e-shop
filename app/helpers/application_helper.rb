# frozen_string_literal: true

module ApplicationHelper
  def current_order
    if !session[:cart].nil?
      Order.find(session[:cart])
    else
      Order.new(user: current_user)
    end
  end
end
