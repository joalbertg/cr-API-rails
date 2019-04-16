# frozen_string_literal: true

module Api
  module V1
    # answers controller
    class AnswersController < ApiV1Controller
      # create update destroy

      # POST /polls/1/answers
      def create
        authenticate

        create_answer if @current_user
        # create_answer unless authenticate_owner('user')
      end

      # PATCH/PUT /polls/1/answers/1
      def update
        authenticate
        set_answer

        update_answer if @current_user
      end

      # DELETE /polls/1/answers/1
      def destroy
        authenticate
        set_answer

        destroy_answer if @current_user
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
        set_poll
        @poll.user == @current_user ? true : error_message(type, :unauthorized)
      end

      def create_answer
        return unless authenticate_owner('user')

        @answer = Answer.new(answer_params)
        return render 'api/v1/answers/show' if @answer.save

        error_message('error', :unprocessable_entity, @answer)
      end

      def update_answer
        return unless authenticate_owner('user')

        return render('api/v1/answers/show') if @answer.update(answer_params)

        error_message('error', :unprocessable_entity, @answer)
      end

      def destroy_answer
        return unless authenticate_owner('destroy')

        return render json: { message: 'the indicated question was eliminated' } if @answer.destroy

        error_message('error', :unprocessable_entity, @answer)
      end
    end
  end
end
