module Calculate
  class ShortestJobfirst
    def self.perform(processes)

      processes.sort! { |a,b| a.burst_time <=> b.burst_time }

      processes.each do |process|
        if process == processes[0]
          process.wait_time = 0
          process.turnaround_time = process.burst_time
        else
          process.wait_time = processes[(processes.index(process))-1].turnaround_time
          process.turnaround_time = process.wait_time.to_i + process.burst_time.to_i
        end

      end
      processes
    end
  end


  class FirstComeFirstServe
    def self.perform(processes)

    end


  end
end