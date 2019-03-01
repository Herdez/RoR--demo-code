class Challenge < ActiveRecord::Base
	
	before_save :downcase_title
	after_initialize :titleize_title

	has_many :schedules, :dependent => :restrict_with_error
	has_many :weeks, through: :schedules

    ...


	validates :title, presence: true, length: { maximum: 100 }
	validates :content, presence: true

	...

	def self.week_day(week,day)
		self.where(week: week,day: day)
	end

    ...
    
	def user_answers(id)
		answers.where(user_id: id).order(created_at: :desc)
	end

	def answered_correctly?(id)

		if user_answers(id).any? {|answer| answer.correct}
			true
		elsif user_answers(id).any? {|answer| answer.correct == false}
			false
		else
			if user_answers(id).any?
				nil
			else
				:empty
			end 
		end
	end

	def any_commets_on_correct?(id)
		correct_answers = answers.where(user_id: id, correct: true)
		correct_answers.any? {|answer| !answer.comment.nil?}
	end


	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

		def downcase_title
			self.send("#{:title}=", self.send(:title).downcase) if self.send(:title)
		end

		def titleize_title
			self.send("#{:title}=", self.send(:title).titleize) if self.send(:title)
		end

		...

end

