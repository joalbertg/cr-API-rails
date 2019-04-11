# frozen_string_literal: true

module Api
  module V1
    # poll controller
    class MyPollsController < ApiV1Controller
      before_action :authenticate, only: %i[create update destroy]
      before_action :set_poll, only: %i[show update destroy]

      def index
        @polls = MyPoll.all
      end

      def show; end

      def create
        @poll = @current_user.my_polls.new(my_polls_params)
        # poll = MyPoll.create(my_polls_params)
        # poll.user = @curren_user
        return render 'api/v1/my_polls/show' if @poll.save

        error_message('error', :unprocessable_entity, @poll)
      end

      def update
        # return error_message('user', :unauthorized) unless @current_user == @poll.user
        update_poll unless authenticate_owner('user')
      end

      def destroy
        destroy_poll unless authenticate_owner('destroy')
      end

      private

      def authenticate_owner(type)
        @poll.user != @current_user ? error_message(type, :unauthorized) : false
      end

      def update_poll
        @poll.update(my_polls_params)
        render('api/v1/my_polls/show')
      end

      def destroy_poll
        @poll.destroy
        render json: { message: 'the indicated poll was eliminated' }
      end

      def set_poll
        @poll = MyPoll.find_by_id(params[:id])
      end

      def my_polls_params
        params.require(:poll).permit(:title, :description, :expires_at)
      end
    end
  end
end
