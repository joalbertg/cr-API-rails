# frozen_string_literal: true

module Api
  module V1
    # answers controller
    class MyAnswersController < ApiV1Controller
      before_action :authenticate

      def create
        poll = MyPoll.find(params[:my_poll_id])
        answer = Answer.find(params[:answer_id])
        user_poll = UserPoll.custom_find_or_create(poll, @current_user)
        @my_answer = MyAnswer.custom_update_or_create(user_poll, answer)
        return render('api/v1/my_answers/show') if @my_answer

        error_message('error', :unprocessable_entity, my_answer)
      end
    end
  end
end
