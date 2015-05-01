class WelcomeController < ApplicationController
  # displays the form, so change the name of the form you have now to new.html.erb
  def new
  end

  # the form will pass to this action to perform logic on longitude and latitude
  def create
    curAddress = params[:address]
    destAddress = params[:destaddress]

    @currentStop = Stop.closest(:origin => curAddress)
    @destinationStop = Stop.closest(:origin => destAddress)

    startStopId = @currentStop.first.id
    endStopId = @destinationStop.first.id
     
    @cStop = Stop.find(startStopId)
    @dStop = Stop.find(endStopId)

     

    @timeNow = Time.now.strftime("%I:%M:%S %z") # "09:33:00 -0400"
   # @timeNow = @timeNow_ + 4.hours



    # Get all the buses at current and destination stop
   #@possible_buses = Schedule.where("arrival >= ?", @timeNow).where(stop_id: [startStopId,endStopId])

@possible_sbuses = Schedule.where("arrival >= ?", @timeNow).where("stop_id = ?", startStopId)

@possible_dbuses = Schedule.where("arrival >= ?", @timeNow).where("stop_id = ?", endStopId)

#@possible_buses = @possible_sbuses.joins(:@possible_dbuses)
@temp = @possible_sbuses


@connection = ActiveRecord::Base.establish_connection(
            :adapter => "postgresql",
            :host => "ec2-184-73-165-195.compute-1.amazonaws.com",
            :database => "d3tjsoqs2ldgks",
            :username => "poglkhpvagspfk",
            :password => "hmuUSorO_T8qyrmk6JoIN5I8_Y",
	    :port => "5432"
)

sql = "
select A.bus_id as busid, A.stop_id as source, A.arrival as atime, B.arrival as dtime from
(SELECT * from schedules as S where S.stop_id = #{startStopId}) A
inner join
(SELECT * from schedules as S where S.stop_id = #{endStopId}) B
on A.bustag = B.bustag
where A.arrival < B.arrival
and A.arrival > CURTIME();"
@temp = @connection.connection.execute(sql);

@busName = Array.new
@arrivalTime = Array.new
@temp.each do |t|
  tempbus = Bus.find(t[0])
  @busName.push(tempbus.name)
  tempTime =  t[2].strftime("%I:%M:%S ") # "09:33:00 -0400"
  @arrivalTime.push(tempTime)
end

@size = @busName.length


   #Get all the buses at the start location and respective timing
  # @startBuses = Array.new
   #@startBusesTime = Array.new
   #@possible_buses.each do |bus|
   # if(bus.stop_id == startStopId)
   #  @startBuses.push(bus.bus_id)
   #  @startBusesTime.push(bus.arrival)
   # end
   # end 

   #Get all the buses at end location and respetive timing
   # @endBuses = Array.new
   # @endBusesTime = Array.new
   # @possible_buses.each do |bus|
   #  if(bus.stop.id == endStopId)
   #    @endBuses.push(bus.bus_id)
   #    @endBusesTime.push(bus.arrival)
   #  end
   # end
   



     
    #@curstops = Stop.where("longitude = ? AND latitude = ?", curlong, curlat)
    #@deststops = Stop.where("longitude = ? AND latitude = ?",destlong,destlat)
    
   # current_Stop = @curstops[0].id
    #destination_Stop = @deststops[0].id

    # Get Schedule id of all buses for the two stop ids
    #@possible_buses = Schedule.where(stop_id: [current_Stop, destination_Stop]).where("stop_id = ?",current_Stop).pluck(:bus_id)
    #@possible_buses_times = Schedule.where(stop_id: [current_Stop, destination_Stop]).where("stop_id = ?",current_Stop).pluck(:id) 
    
    #store bus ids of all the possible buses to take
    #@buses = Array.new
    #@possible_buses.each do |bus|
    #	temp = Bus.find(bus)
    #	@buses.push(temp.name)
    #end
    # store the arrival time of each possible buses to take
    #@times = Array.new
    #@possible_buses_times.each do|sched|
    #	temp = Schedule.find(sched)
    #	@times.push(temp.arrival)
    #end

   
   #@size = @buses.length    


    render :index
  end

  # if it renders from the create action, @stops will be available to use here
  def index
  end
end