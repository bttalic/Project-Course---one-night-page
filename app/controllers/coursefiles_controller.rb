class CoursefilesController < ApplicationController
before_filter :signed_in_user
  before_filter :correct_user,   only: [:create, :update, :destroy]
def new
  Coursefile.new
end

def create
    course=Course.find(params[:coursefile][:course_id])
    @coursefile = course.coursefiles.build(params[:coursefile])
    if @coursefile.save
      flash[:success] = "File added!"
      redirect_to course
    else
      redirect_to course
    end
  end

  private

  def correct_user
    course=Course.find(params[:coursefile][:course_id])
    redirect_to(root_url) unless current_user?(course.user)
  end


end