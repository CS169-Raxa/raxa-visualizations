class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.for_day(Time.now).count
    @average_time = average_time(Registration.all)

    @registrations_and_divs = get_regs_by_date(Registration.all(:order => "time_end DESC"))

    render :show
    @registration_history = Hash.new {|hash, key| 0}
    Registrar.all.each do |registrar|
      registrar.registration_history(Date.today - 1.week, Date.today).each do |date, count|
        @registration_history[date] += count
      end
    end
  end

  def show
    registrar = Registrar.find(params[:id])
    @num_today = registrar.registrations_for_day(Time.now).count
    @average_time = average_time(registrar.registrations)
    @registrations_and_divs = get_regs_by_date(Registration.all(:order => "time_end DESC", :conditions => {:registrar_id => params[:id]}))
  end

  protected
  def average_time(registrations)
    total_time = registrations.map {|r| r.elapsed_time}.reduce(:+)
    if total_time
      return ChronicDuration.output((total_time/registrations.length).to_i, :format => :chrono)
    else
      return 0
    end
  end

  def get_regs_by_date(registrations)
    # set up @registrations_and_divs for registrations table in view
    # @registrations_and_divs is a list of
    #    hash tables where the keys are
    #      :date => a string to show in the dividers in the view (nil if today)
    #      :regs => registrations that took place on that date
    curr_regs = {:regs => []}
    regs_and_divs = [curr_regs]
    last_reg = Chronic.parse('today').localtime.strftime('%^B %e, %Y')
    registrations.each do |reg|
      reg_date = reg.time_end.localtime.strftime('%^B %e, %Y')
      if last_reg != reg_date
        curr_regs = {:regs => []}
        regs_and_divs << curr_regs
        if Chronic.parse('yesterday').localtime.strftime('%^B %e, %Y') == reg_date
          curr_regs[:date] = 'YESTERDAY'
        else
          curr_regs[:date] = reg_date
        end
        last_reg = reg_date
      end
      curr_regs[:regs] << reg
    end
    if registrations.empty?
      regs_and_divs = [{:date => "there are no registrations to show", :regs => []}]
    end
    return regs_and_divs
  end

end
