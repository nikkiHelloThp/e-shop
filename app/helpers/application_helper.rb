# frozen_string_literal: true

module ApplicationHelper
  def current_order
    if !!cookies[:cart]
      Order.find(cookies[:cart])
    else
      Order.new(user: current_user)
    end
  end
end
