module ApplicationHelper
	# Return a title on a per-page basis.
	def title
		base_title = "Ruby on Rails Sample App"
		if @title.nil? #By default @title being an instance variable is nil
			base_title #methods return the last line evaluated
		else
			"#{base_title} | #{@title}"
		end
	end

	def logo
		image_tag("/images/flower_logo.jpg", :alt => "Sample App", :width => 150, :height => 100, :class => "round")
	end
end
