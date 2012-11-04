class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.for_day(Time.now).count
    @average_time = average_time(Registration.all)
    render :show
  end

  def show
    registrar = Registrar.find(params[:id])
    @num_today = registrar.registrations_for_day(Time.now).count
    @average_time = average_time(registrar.registrations)

    # set up @registrations_and_divs for registrations table in view
    # @registrations_and_divs is a list of
    #    two-element-lists where the first element is a registration
    #    and the second element indicates whether or not to place a divider
    #        before the next registration in the table
    #        using false for no divider, and the divider text otherwise
    @registrations = Registration.all(:order => "time_end", :conditions => {:registrar_id => params[:id]})
    @registrations_and_divs = []
    last_reg = Chronic.parse('today').localtime.strftime('%^B %e, %Y')
    @registrations.reverse.each do |reg|
      div = false
      reg_date = reg.time_end.localtime.strftime('%^B %e, %Y')
      if last_reg != reg_date
        if Chronic.parse('yesterday').localtime.strftime('%^B %e, %Y') == reg_date
          div = 'YESTERDAY'
        else
          div = reg_date
        end
      end
      last_reg = reg_date
      @registrations_and_divs << [reg, div]
    end

  end

  protected
  def average_time(registrations)
    total_time = registrations.map {|r| r.elapsed_time}.reduce(:+)
    return ChronicDuration.output((total_time/registrations.length).to_i, :format => :chrono)
  end

end
