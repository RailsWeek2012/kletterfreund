class CommentsController < ApplicationController
  def create
    @route = Route.find_by_id(params[:comment][:route_id])
    params[:comment].delete(:route_id)
    @comment = Comment.new(params[:comment])
    if @comment.save
      @route.comments << @comment
      flash.now[:notice] = "Ihr Kommentar wurde abgegeben"
    else
      flash.now[:alert] = "Fehler beim abgeben des Kommentars"
    end

    redirect_to routes_show_path(@route.id)
  end
end
