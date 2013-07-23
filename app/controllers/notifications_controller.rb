class NotificationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    course=Course.find(params[:notification][:course_id])
    @notification = course.notifications.build(params[:notification])
    if @notification.save
      flash[:success] = "Notification created!"
      redirect_to request.referer
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @notification.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @notification = current_user.notifications.find_by_id(params[:id])
      redirect_to root_url if @notification.nil?
    end
end