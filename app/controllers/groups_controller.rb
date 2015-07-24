class GroupsController < ApplicationController
	
	#before_action: find_group, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy] 

	def index
		@groups = Group.all
	end

	def show
		@group = Group.find(params[:id])
		@posts = @group.posts
	end

	def new
		@group = Group.new
	end

	def edit
		@group = current_user.groups.find(params[:id])
	end

	def create
		@group = current_user.groups.create(group_params)

		if @group.save
			current_user.join!(@group) # auto join the group after creating it
			redirect_to groups_path, notice: 'Successfully Added the group. And you are in the group now.' # may need to add meetup name later
		else
			render :new
		end
	end

	def update
		@group = current_user.groups.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path, notice: "Successfully updated."
		else
			render :edit
		end
	end

	def destroy
		@group = current_user.groups.find(params[:id])
		@group.destroy
		redirect_to groups_path, alert: "The Meetup has been deleted."
	end

	# join and quit the group
	def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "Successfully joined the group！"
    else
      flash[:warning] = "You are a member of this group！"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "Successfully quit the group！"
    else
      flash[:warning] = "Not a member yet, can't quit."
    end

    redirect_to group_path(@group)
  end

	private

	def group_params
		params.require(:group).permit(:title, :description)
	end

	#def find_group
		#@group = Group.find(params[:id])
	#end

end
