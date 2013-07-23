class StaticPagesController < ApplicationController

  def notifications
    if signed_in?
      
      @feed_items = current_user.feed
       @feed2_items = current_user.feed2
    end
  end

  def home
    @profs=User.where(:professor=>true)
    @stud=User.where(:profess=>false, :admin=>false)
  end
  
  def help
  end

  def about
  end

  def contact
  end
end
