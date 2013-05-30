class ScheduleController < ApplicationController
  def create
    message = false
    
      if params[:schedule][:event_type] == "pto"
        sched = Schedule.new(params[:schedule])
        sched.date_begin, sched.date_end = format_schedule_date(params[:date_range1])
        sched.user_id = current_user.user_id
        a = sched.date_end
        if sched.save
          message = true
        end
      end
      
    respond_to do |format|
      format.json {render :json => {:msg => message ? "success" : "failure" }}
    end
  end
  
  private
  
  # Returns a two part array consisting of dates
  # First value is the begin date and the second is the end date
  def format_schedule_date(date_array)
   begin
     vals = []
     return vals if date_array.empty?
     date_array.split('-').each do |s|
       date = Date.strptime(s.strip, '%m/%d/%Y')
       vals <<(date)
     end
   rescue ArgumentError  
     return []
   end
     return vals
  end
    
end