module ApplicationHelper

  # def flash_class(level)
  #   case level
  #   when :notice then "alert alert-info"
  #   when :success then "alert alert-success"
  #   when :error, :alert then "alert alert-danger"
  #   end
  # end

  def options_for_review_rating(selected=nil)
  	options_for_select((1..5).map {|num| [pluralize(num, "Star"), num]}, selected)
  end
end
