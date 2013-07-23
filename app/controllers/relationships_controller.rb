class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @course = Course.find(params[:relationship][:listened_id])
    if(params[:code]==@course.code || @course.lock==false)
    current_user.listen!( @course)
  else
    flash[:error]="Wrong code!"
     redirect_to request.referer
     return
  end

    respond_with  @course
  end

  def destroy
     @course = Relationship.find(params[:id]).listened
    current_user.unlisten!( @course)
    respond_with  @course
  end
end