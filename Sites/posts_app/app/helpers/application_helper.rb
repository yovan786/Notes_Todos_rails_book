module ApplicationHelper

  #return an title per page basis
  def title
    base_title = "Ruby on Rails Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
  	image_tag("flower_logo.jpg", :alt => "Sample App", :width => 150, :height => 100, :class => "round")
  end

end
