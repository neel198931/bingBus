class Stop < ActiveRecord::Base

	has_many:schedules
	geocoded_by :address
	after_validation :geocode
	acts_as_mappable defaults_units: :miles, lat_column_name: :latitude, lng_column_name: :longitude

end
