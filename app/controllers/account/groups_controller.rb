class Account::GroupsController < ApplicationController

	before_action :authenticate_user!

  def index
    @groups = current_user.participated_groups.order("posts_count desc") #.polular # order by popularity
  end
end
