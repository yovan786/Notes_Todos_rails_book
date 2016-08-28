class User
	attr_accessor :first_name, :last_name

	def initialize(attributes = {})
		@first_name = attributes[:first_name]
		@last_name = attributes[:last_name]
	end

	def full_name
		"#{@first_name} #{@last_name}"
	end

end