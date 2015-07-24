class PostsController < ApplicationController
	# no need for index, show -> displayed in the 'group' page

	before_action :authenticate_user!  

	before_action :find_group

	before_action :member_required, only: [:new, :create ]


	#commonly used controller technique: 
	#before_action: find_group, only/except: [:edit, :update] 


	def new
		@post = @group.posts.new
	end

	def create
    @post = @group.posts.build(post_params) # .build: not saved yet
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group), notice: "Successfully added new Post."
    else
      render :new
    end
	end

	def edit
    @post = current_user.posts.find(params[:id])
	end

	def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Successfully updated the Post."
    else
      render :edit
    end
	end

	def destroy
    @post = current_user.posts.find(params[:id])

    @post.destroy
    redirect_to group_path(@group), alert: "The Post has been deleted."
	end

	private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_group
  	@group = Group.find(params[:group_id])
	end

	def member_required
		# !
    return if current_user.is_member_of?(@group)
    flash[:warning] = "You can't post now since you are not in this group."
    redirect_to group_path(@group)
  end

end
