# frozen_string_literal: true

module Api
  module V1
    # poll controller
    class MyPollsController < ApiV1Controller
      # before_action :authenticate, only: %i[create update destroy]
      # before_action :set_poll, only: %i[show update destroy]

      def index
        @polls = MyPoll.all
      end

      def show
        set_poll
      end

      def create
        authenticate

        create_poll if @current_user
      end

      def update
        # return error_message('user', :unauthorized) unless @current_user == @poll.user

        update_poll unless authenticate_owner('user')
      end

      def destroy
        destroy_poll unless authenticate_owner('destroy')
      end

      private

      def my_polls_params
        params.require(:poll).permit(:title, :description, :expires_at)
      end

      def set_poll
        @poll = MyPoll.find_by_id(params[:id])
      end

      def authenticate_owner(type)
        authenticate
        return unless @current_user

        set_poll
        @poll.user != @current_user ? error_message(type, :unauthorized) : false
      end

      def create_poll
        @poll = @current_user.my_polls.new(my_polls_params)
        # poll = MyPoll.create(my_polls_params)
        # poll.user = @curren_user
        return render 'api/v1/my_polls/show' if @poll.save

        error_message('error', :unprocessable_entity, @poll)
      end

      def update_poll
        set_poll
        return render('api/v1/my_polls/show') if @poll.update(my_polls_params)

        error_message('error', :unprocessable_entity, @poll)
      end

      def destroy_poll
        set_poll
        return render json: { message: 'the indicated poll was eliminated' } if @poll.destroy

        error_message('error', :unprocessable_entity, @poll)
      end
    end
  end
end
