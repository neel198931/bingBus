require 'csv'

desc "Import schedule from csv file"
task :import => [:environment] do

  file = "db/schedule.csv"

  CSV.foreach(file, :headers => true) do |row|
    Schedule.create ({
      :bus_id => row[1],
      :stop_id => row[2],
      :arrival => row[3],
      :bustag => row[4]
    })
  end

end
