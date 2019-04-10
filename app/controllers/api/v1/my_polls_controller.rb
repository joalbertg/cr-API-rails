# frozen_string_literal: true

module Api
  module V1
    # poll controller
    class MyPollsController < ApiV1Controller
      before_action :authenticate, only: %i[create update destroy]
      before_action :set_poll, only: %i[show update]

      def index
        @polls = MyPoll.all
      end

      def show; end

      def create
        @poll = @current_user.my_polls.new(my_polls_params)
        # poll = MyPoll.create(my_polls_params)
        # poll.user = @curren_user
        return render 'api/v1/my_polls/show' if @poll.save

        render json: { errors: @poll.errors.full_messages }, status: :unprocessable_entity
      end

      def update; end

      def destroy; end

      private

      def set_poll
        @poll = MyPoll.find_by_id(params[:id])
      end

      def my_polls_params
        params.require(:poll).permit(:title, :description, :expires_at)
      end
    end
  end
end
