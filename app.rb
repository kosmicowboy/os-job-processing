require 'sinatra'
require_relative 'process_item.rb'
require_relative 'calculate.rb'

get '/' do
  erb :processes_form
end

post '/' do
  @processes = params[:processes].to_i
  erb :burst_time_form
end

post '/compute' do
  params[:process].each do |process|
    ProcessItem.new(
        process[:number],
        process[:arrival_time],
        process[:burst_time]
    )
  end

  all_processes = []

  ObjectSpace.each_object(ProcessItem).each do |process|
    all_processes << process
  end

  if params[:scheduler] == 'SJF'
    @answers = Calculate::ShortestJobfirst.perform(all_processes)
  else
    # @answers = Calculate::FirstComeFirstServe.perform(all_processes)
    @answers = process
  end

  @average_wait_time = 0
  @average_turnaround_time = 0
  @answers.each do |process|
    @average_wait_time += process.wait_time.to_i
    @average_turnaround_time += process.turnaround_time.to_i
  end
  @average_wait_time = @average_wait_time / @answers.count
  @average_turnaround_time = @average_turnaround_time / @answers.count

  erb :answer
end