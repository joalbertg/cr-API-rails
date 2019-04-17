# frozen_string_literal: true

module Api
  module V1
    # poll controller
    class MyPollsController < ApiV1Controller
      before_action :authenticate, only: %i[create update destroy]
      before_action :set_poll, only: %i[show update destroy]
      before_action(only: %i[update destroy]) do |controller|
        controller.authenticate_owner(@poll.user)
      end

      def index
        @polls = MyPoll.all
      end

      def show; end

      def create
        @poll = @current_user.my_polls.new(my_polls_params)
        return render 'api/v1/my_polls/show' if @poll.save

        render_message
      end

      def update
        return render('api/v1/my_polls/show') if @poll.update(my_polls_params)

        render_message
      end

      def destroy
        return render(error_message('delete', :ok)) if @poll.destroy

        render_message
      end

      private

      def my_polls_params
        params.require(:poll).permit(:title, :description, :expires_at)
      end

      def set_poll
        @poll = MyPoll.find_by_id(params[:id])
      end

      def render_message
        render error_message('error', :unprocessable_entity, @poll)
      end
    end
  end
end
