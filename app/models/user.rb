class User < ActiveRecord::Base


	before_save :downcase_names
	after_initialize :titleize_names
	before_create :create_remember_token
	before_save { self.email = email.downcase }
    
    ...

	has_many :courses, through: :enrollments
	has_many :graded_answers, class_name: 'Answer', foreign_key: 'grader_id'


    ...

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    
    ...

	scope :normal_users, proc { where(admin: false)}
	scope :admins, proc { where(admin: true) }

	... 

	has_secure_password

    ...

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
	end

    ...

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

        ...

end
