# frozen_string_literal: true

module Api
  # version 1
  module V1
    # questions controller
    class QuestionsController < ApiV1Controller
      before_action :authenticate, only: %i[create update destroy]
      # before_action :set_question, only: %i[show update destroy]

      # GET /polls/:poll_id/questions
      def index
        set_poll
        @questions = @poll.questions
      end

      # GET /polls/1/questions/2
      def show
        set_question
      end

      # POST /polls/1/questions
      def create
        set_poll

        create_question unless authenticate_owner('user')
      end

      # PATCH/PUT /polls/1/questions/1
      def update
        set_question
        set_poll
      end

      # DELETE /polls/1/questions/1
      def destroy
        set_question
        set_poll
      end

      private

      def question_params
        params.require(:question).permit(:description)
      end

      def set_poll
        @poll = MyPoll.find_by_id(params[:poll_id])
      end

      def set_question
        @question = Question.find_by_id(params[:id])
      end

      def authenticate_owner(type)
        @poll.user != @current_user ? error_message(type, :unauthorized) : false
      end

      def create_question
        @question = @poll.questions.new(question_params)
        return render 'api/v1/questions/show' if @question.save

        error_message('error', :unprocessable_entity, @question)
      end
    end
  end
end
