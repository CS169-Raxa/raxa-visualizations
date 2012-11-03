class RegistrarsController < ApplicationController
  def index
    render :show
  end

  def show
    # set up @registrations_and_divs for registrations table in view
    # @registrations_and_divs is a list of
    #    two-element-lists where the first element is a registration
    #    and the second element indicates whether or not to place a divider
    #        before the next registration in the table
    #        using false for no divider, and the divider text otherwise
    @registrations = Registration.all(:order => "time_end", :conditions => {:registrar_id => params[:id]})
    @registrations_and_divs = []
    last_reg = Chronic::parse('today')
    @registrations.each do |reg|
      div = false
      reg_date = reg.time_end.strftime('%^B %e, %Y')
      if last_reg.strftime('%^B %e, %Y') != reg_date
        if Chronic::parse('yesterday').strftime('%^B %e, %Y') == reg_date
          div = 'YESTERDAY'
        else
          div = reg_date
        end
      end
      @registrations_and_divs << [reg, div]
    end
  end

end
