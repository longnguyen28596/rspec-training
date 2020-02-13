module ApplicationHelper
  def conver_money_string_to_integer value
    value.to_s.delete(",").to_i
  end
end
