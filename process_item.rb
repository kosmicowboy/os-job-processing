class ProcessItem
  attr_accessor :number, :arrival_time, :burst_time, :wait_time, :turnaround_time

  def initialize(number, arrival_time, burst_time)
    @number = number
    @arrival_time = arrival_time
    @burst_time = burst_time
  end

end