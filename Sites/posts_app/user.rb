class User
	attr_accessor :name, :age

	def initialize(attributes = {})
		@name = attributes[:name]
		@age = attributes[:age]
	end

	def formatted_user_info
		"Name: #{:name}, Age: #{@age}"
	end

end