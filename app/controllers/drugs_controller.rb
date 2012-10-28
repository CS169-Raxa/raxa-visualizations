class DrugsController < ApplicationController
  def update
    id = params[:id]
    drug = Drug.find(id)

    drug_params = params[:drug]
    drug.user_rate = drug_params[:user_rate]
    drug.alert_level = drug_params[:alert_level]
    drug.save!

    success_message = %Q[#{drug.name} successfully saved]
    if request.xhr?
      render(
        :json => {
          :notice => render_to_string(
            :partial => 'pharmacy/notice',
            :locals => { :notice => success_message }
          ),
          :id => drug.id,
          :data => render_to_string(
            :partial => 'pharmacy/drug_edit',
            :locals => { :drug => drug }
          )
        }
      )
    else
      flash[:notice] = success_message
      redirect_to pharmacy_path
    end
  end

  def time_graph
    @drug = Drug.find(params[:id])
    @data = @drug.time_aggregated_data(params[:time_period].to_i,
                                  params[:group_by_period].to_i)
    respond_to do |format|
      format.json { render :json => { :data => @data, :drug => @drug } }
    end
  end
end
