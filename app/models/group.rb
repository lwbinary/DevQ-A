class Group < ActiveRecord::Base
 
  #scope :popular, -> { order("posts_count desc") } # using scope managing queries

	validates :title, presence: true
	#this doesn't work => validates :title, presence: { message: 'cannot be blank' }

	has_many :posts, dependent: :destroy

	has_many :group_users
  has_many :members, through: :group_users, source: :user

	belongs_to :owner, class_name: "User", foreign_key: :user_id

	# test if current user is the owner/author which has the same user id
	def editable_by?(user)
    user && user == owner
  end

end
