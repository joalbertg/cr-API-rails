# frozen_string_literal: true

module Api
  # version 1
  module V1
    # questions controller
    class QuestionsController < ApiV1Controller
      before_action :set_question, only: %i[show update destroy]

      # GET /polls/:poll_id/questions
      def index
        set_poll
        @questions = @poll.questions
      end

      # GET /polls/1/questions/2
      def show; end

      # POST /polls/1/questions
      def create
        set_poll
        @question = @poll.questions.new(question_params)
        return render 'api/v1/questions/show' if @question.save

        error_message('error', :unprocessable_entity, @question)
      end

      # PATCH/PUT /polls/1/questions/1
      def update
        set_poll
      end

      # DELETE /polls/1/questions/1
      def destroy
        set_poll
      end

    end

    private

    def set_poll
      @poll = MyPoll.find_by_id(params[:poll_id])
    end

    def question_params
      params.require(:question).permit(:description)
    end

    def set_question
      @question = Question.find_by_id(params[:id])
    end
  end
end
