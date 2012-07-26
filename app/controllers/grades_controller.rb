class GradesController < ApplicationController
  def show_table
    @grade = Integer(params[:id])
    render :layout => false
    
  end

  private
end
