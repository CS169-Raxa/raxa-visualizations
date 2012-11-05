class RegistrarsController < ApplicationController
  def index
    @name = 'all registrars'
    index_or_show Registration.scoped
    render :show
  end

  def show
    registrar = Registrar.find(params[:id])
    @name = registrar.name
    index_or_show registrar.registrations
  end

  protected
  def index_or_show(regs)
    @num_today = regs.for_day(Time.now).count
    @average_time = average_time(regs)
    @full = (params[:full] == 'full')
    regs = regs.order("time_end DESC")
    @num_regs_without_limit = regs.count
    regs = regs.limit(10) unless @full
    @registrations_and_divs = get_regs_by_date(regs)
  end

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
