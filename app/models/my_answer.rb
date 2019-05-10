class MyAnswer < ActiveRecord::Base
  belongs_to :user_poll
  belongs_to :answer
  belongs_to :question

  validates :answer, presence: true
  validates :user_poll, presence: true

  def self.custom_update_or_create(user_poll, answer)
    # validating that two records are not created for the same question and the same user
    my_answer = where(user_poll: user_poll, question: answer.question).first_or_create
    # updates the chosen response that was sent by parameters
    my_answer.update(answer: answer)
    # return the record
    my_answer
  end
end
