require "date"

class Member 

	attr_accessor :name, :address, :contact, :age, :validity, :paid, :member_attendance, :days, :date_registered, :first_day, :last_day_attended

	# Create a new member
	def initialize(params)

		@name = params[:name]
		@address = params[:address]
		@contact = params[:contact]
		@age = params[:age].to_i
		@validity = 0 
		@days = 0 
		@paid = false
		time = Time.new
		@date_registered = Date.new(time.year, time.month, time.day) 
		@member_attendance = Hash.new
		@first_day = true
		@last_day_attended = Date.new
		
	end

	# make payment according to the plan selected and update the validity for membership
	def make_payment(plan) 
		
		membership_plans = {"monthly" => 30, "annualy" => 365}
		self.validity = membership_plans[plan]
		self.paid = true

	end

	# this method will check for validity of membership. If it has expired, returns false else true
	def is_membership_valid
		time = Time.new

		self.date_registered.upto(Date.new(time.year, time.month, time.day)) do |date|
			self.days += 1 
		end
		if self.days <= self.validity
			return true
		else
			self.paid = false
			return false
		end
	end

	# mark the attendance of the member for the particular day when this method is called
	def mark_attendance
		time = Time.new		
		
		# day registered is marked as present as it is the first day
		if self.first_day
		
			member_attendance[self.date_registered.to_s] = "Present" unless member_attendance.has_key?(date_registered.to_s)
			self.first_day = false
			self.last_day_attended = self.date_registered
		
		else
			# mark PRESENT for the day attended and the days between last_day_attended to present_day will be marked ABSENT
			today = Date.new(time.year, time.month, time.day)
			(self.last_day_attended + 1).upto(today - 1) do |date|
				member_attendance[date.to_s] = "Absent" unless members_list.has_key?(date.to_s)
			end
			member_attendance[today.to_s] = "Present" unless members_list.has_key?(today.to_s)

		end
		puts "Attendance marked"
	end

	# Show the attendance of a particular member
	def check_attendance

		puts member_attendance
		
	end

end

# validate the params, i.e contact number and age of the member
def is_valid_params(contact,age)
	if age.to_i > 15  
		if (contact =~ /^[789]\d{9}$/) == 0  
			return true
		else
			return false
		end
	else
		return false
	end

end

members_list = Array.new # it is a collection of objects of Member class
members_id = Array.new # it will store the IDs of members

# Puts "------------------------GYM------------------------"
while 1 
	puts "1. Do you want to join this GYM ?"
	puts "2. I am already a member."
	choice = gets.to_i
	choice = choice
	if choice == 1
			puts "Enter your name"
			name = gets()
			puts "Enter your address"
			address = gets()
			puts "Enter your contact number"
			contact = gets()
			puts "Enter your age"
			age = gets()
			if is_valid_params(contact,age)
				member = Member.new({name: name, address: address, contact: contact, age: age}) #
				puts "Please select a membership plan and make payment"
				puts "Monthly / Annualy"
				plan = gets.chomp
				if plan.downcase == "monthly" or plan.downcase == "annualy"
					member.make_payment(plan)
					members_list << member #append member to collection of objects
					puts "Welcome to our GYM, your member_id is #{members_list.size()}"
					members_id << members_list.size() #append member id
				else 
					puts "Please enter correct plan."
				end
			
			else
				puts "Plese enter correct details"
			end	

	elsif choice == 2 
		puts "=========Welcome Back========="
		puts "Please enter your Member ID"
		id = gets.to_i
		if members_id.include?(id) # if member is already regestered ?
			member = members_list[id-1] # gets the member object of that unique ID
			puts "1. Mark your attendance"
			puts "2. Check your attendance"
			opt = gets.chomp.to_i
			if opt == 1
				if member.is_membership_valid and member.paid #if membership is valid ?
					member.mark_attendance # mark the attendance
				else 
					puts "Invalid membership or Membership expired."
				end
			elsif opt == 2
				member.check_attendance # get the attendance record
			end
		else
			puts "Member ID not found. Please contact support"
		end
	end
end