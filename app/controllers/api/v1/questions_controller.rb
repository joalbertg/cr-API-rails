# frozen_string_literal: true

module Api
  # version 1
  module V1
    # questions controller
    class QuestionsController < ApiV1Controller
      before_action :authenticate, except: %i[index show]
      before_action :set_question, only: %i[show update destroy]
      before_action :set_poll
      before_action(only: %i[update destroy create]) do |controller|
        controller.authenticate_owner(@poll.user)
      end

      # GET /polls/:poll_id/questions
      def index
        @questions = @poll.questions
      end

      # GET /polls/1/questions/2
      def show; end

      # POST /polls/1/questions
      def create
        @question = @poll.questions.new(question_params)
        return render('api/v1/questions/show') if @question.save

        render_message
      end

      # PATCH/PUT /polls/1/questions/1
      def update
        return render('api/v1/questions/show') if @question.update(question_params)

        render_message
      end

      # DELETE /polls/1/questions/1
      def destroy
        return render(error_message('delete', :ok)) if @question.destroy

        render_message
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

      def render_message
        render error_message('error', :unprocessable_entity, @question)
      end
    end
  end
end
