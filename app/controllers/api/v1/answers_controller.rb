# frozen_string_literal: true

module Api
  module V1
    # answers controller
    class AnswersController < ApiV1Controller
      before_action :authenticate, except: %i[index show]
      before_action :set_answer, only: %i[update destroy]
      before_action :set_poll
      before_action(only: %i[update destroy create]) do |controller|
        controller.authenticate_owner(@poll.user)
      end

      # POST /polls/1/answers
      def create
        @answer = Answer.new(answer_params)
        return render('api/v1/answers/show') if @answer.save

        render_message
      end

      # PATCH/PUT /polls/1/answers/1
      def update
        return render('api/v1/answers/show') if @answer.update(answer_params)

        render_message
      end

      # DELETE /polls/1/answers/1
      def destroy
        return error_message('delete', :ok) if @answer.destroy

        render_message
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

      def render_message
        error_message('error', :unprocessable_entity, @answer)
      end
    end
  end
end
