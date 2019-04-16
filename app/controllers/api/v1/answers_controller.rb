# frozen_string_literal: true

module Api
  module V1
    # answers controller
    class AnswersController < ApiV1Controller
      # create update destroy

      # POST /polls/1/answers
      def create
        create_answer unless authenticate_owner('user')
      end

      # PATCH/PUT /polls/1/answers/1
      def update
        set_answer
        update_answer unless authenticate_owner('user')
      end

      # DELETE /polls/1/answers/1
      def destroy
        set_answer
        destroy_answer unless authenticate_owner('destroy')
      end

      private

      def answer_params
        params.require(:answer).permit(:description, :question_id)
      end

      def set_poll
        @poll = MyPoll.find_by_id(params[:poll_id])
      end

      def set_answer
        @answer = Answer.find_by_id(params[:id])
      end

      def authenticate_owner(type)
        return unless authenticate

        set_poll
        @poll.user != @current_user ? error_message(type, :unauthorized) : false
      end

      def create_answer
        @answer = Answer.new(answer_params)
        return render 'api/v1/answers/show' if @answer.save

        error_message('error', :unprocessable_entity, @answer)
      end

      def update_answer
        return render('api/v1/answers/show') if @answer.update(answer_params)

        error_message('error', :unprocessable_entity, @answer)
      end

      def destroy_answer
        return render json: { message: 'the indicated question was eliminated' } if @answer.destroy

        error_message('error', :unprocessable_entity, @answer)
      end
    end
  end
end
