#require 'datamapper'

module DataMapper
  module FixerUpper
		module Properties
			
			# TODO fails on camel-case classes like this_thing ThisThing
		  
		  def self.get_associations(model_name)
		    assoc = Array.new
		    current_model = Kernel.const_get(model_name)
		    current_model.relationships.each do |rarr|
          # belongs_to relationship
          if rarr.child_model.to_s == model_name
            assoc << rarr.parent_model_name
          end
        end
        assoc
		  end
		  
		  def self.get_properties(model_name)
		    property_strings = Array.new
		    puts   "Processing #{model_name}"
		    current_model = Kernel.const_get(model_name)
  
		    current_model.properties.each do |prop|
    
		      if prop.serial?
		        next
		      end
    
		      if prop.required?
		        puts "Required property, creating regex"
		        value = self.guess(prop)
		        property_strings.push "\n\t:#{prop.name} => #{value},"
      
		        puts "Name\t" + prop.name.to_s
		        puts "Type\t" + prop.primitive.to_s
		        puts "Options\t" + prop.options.inspect.to_s
		      end
    
		    end
  
		    property_strings  
		  end

		  def self.guess(property)
  
		    case property.primitive.to_s
		      when "String" then self.make_string(property)
		      when "TrueClass" then self.make_boolean()
		      when "Integer" then self.make_integer(property)
		      when "Date" then self.make_date(property)
		      when "DateTime" then self.make_date(property)
		      else "Unknown primitive"
		    end
		  end

		  def self.make_boolean
		    "rand(10)%3 == 0"
		  end

      def self.make_date(property)
        
        case property.name.to_s
          
		      when 'created_at' then self.created_at
		      when 'created_on' then self.created_at
		      when 'updated_at' then "Date.today"
		      when 'updated_on' then "Date.today"
		      when 'date_of_birth' then "\"\#\{(1900..2000).to_a[rand(100)]\}-\#\{(1..12).to_a[rand(12)]\}-\#\{(1..31).to_a[rand(31)]\}\""
		      when 'dob' then "\"\#\{(1900..2000).to_a[rand(100)]\}-\#\{(1..12).to_a[rand(12)]\}-\#\{(1..31).to_a[rand(31)]\}\""
		      when 'birthday' then "\"\#\{(1900..2000).to_a[rand(100)]\}-\#\{(1..12).to_a[rand(12)]\}-\#\{(1..31).to_a[rand(31)]\}\""
		      when 'birthdate' then "\"\#\{(1900..2000).to_a[rand(100)]\}-\#\{(1..12).to_a[rand(12)]\}-\#\{(1..31).to_a[rand(31)]\}\""
          else "Date.today"
    
		    end
		    
      end
      
      def self.created_at
        "(span = DateTime.now << 6..DateTime.now; span.to_a[rand(span.to_a.size)])"
      end
      
		  def self.make_integer(property)

		    if property.options and property.options[:length]
		      num_times = property.options[:length]
		    else
		      num_times = 9
		    end
  
		    "rand(#{num_times**9})"
		  end

		  def self.make_string(property)
  
        length = property.options[:length] ? property.options[:length] : 100

		    if length > 150
		      return "Proc.new{str = ''; 2.times{ str << /[:sentence:]\. /.gen}; str}"
		    end
  
		    case property.name.to_s
		      
		      when 'url' then "/http:\\/\\/\\w+.com\\/\\w+/.gen"
		      when 'fb_user_id' then "/\\d{8,15}/.gen"
		      when 'uid' then "/\\d{8,15}/.gen"
		      when 'body' then "/[:sentence:]/.gen"
		      when 'description' then "/[:sentence:]/.gen"
		      when 'title' then "/[:sentence:]/.gen[0..#{length-1}]"
		      when 'name' then "/[:sentence:]/.gen[0..#{length-1}]"
		      when 'first_name' then "Randgen.first_name"
		      when 'firstname' then "Randgen.first_name"
		      when 'fname' then "Randgen.first_name"
		      when 'last_name' then "Randgen.last_name"
		      when 'lastname' then "Randgen.last_name"
		      when 'lname' then "Randgen.last_name"
		      when 'email' then "Randgen.email"
		      when 'phone' then "/\\d{3}-\\d{3}-\\d{4}/.gen"
		      when 'date_of_birth' then "\"\#\{(1900..2000).to_a[rand(100)]\}-\#\{(1..12).to_a[rand(12)]\}-\#\{(1..31).to_a[rand(31)]\}\""
		      when 'dob' then "#{(1900..2000).to_a[rand(100)]}-#{(1..12).to_a[rand(12)]}-#{(1..31).to_a[rand(31)]}"
		      when 'address' then "/\\d{3,5}/.gen+\" \"+/\\w{5,10}/.gen.capitalize+\" \"+%w{St. Ct. Rd. Ave. Dr. Blvd. Street Court Road Avenue Drive Boulevard}.pick"
		      when 'city' then "/\\w{5,15}/.gen.capitalize"
		      when 'state' then "%w{AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY}.pick"
		      when 'zip' then "/\\d{5}/.gen"
		      when 'zipcode' then "/\\d{5}/.gen"
		      when 'zip_code' then "/\\d{5}/.gen"
		      else "/\\w{3,#{length}}/.gen"

		    end

		  end
	
		end
	end	
end