module PostsHelper
  def conver_money_string_to_integer_post value
    value.to_s.delete(",").to_i if value.present?
  end
end
