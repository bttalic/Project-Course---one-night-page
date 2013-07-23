class CoursesController < ApplicationController

	before_filter :correct_user,   only: [:edit, :update]
	before_filter  :professor_user,    only: [:create, :destroy]     
	def new
		@course=Course.new
	end

	def show
		@course=Course.find(params[:id])
		@user=User.find(@course.user_id)
		@notification  = @course.notifications.build(course_id: @course.id)
		 @notifications = @course.notifications.paginate(page: params[:page])
		 @coursefile=@course.coursefiles.build(course_id:@course.id)
		 @coursefiles=@course.coursefiles.paginate(page: params[:page])
	end

	def create
		@course = current_user.courses.build(params[:course])

		if @course.save
			flash[:success] = "Course created"
			redirect_to @course
		else
			render 'new'
		end
	end

	def destroy
		flash[:success] = "course deleted!"
		@course=course.find(params[:id]).destroy
		redirect_to current_user
	end

	def listeners
    @title = "Students"
    @course = Course.find(params[:course_id])
    @users = @course.listeners.paginate(page: params[:page])
    render 'courses/show_listen'
	end

	private
	def correct_user
		@course=course.find(params[:id])
		redirect_to(root_url) unless current_user?(@course.user)
	end

	def professor_user
		redirect_to(root_url) unless current_user.professor?
	end

	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
	


end