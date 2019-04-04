# frozen_string_literal: true

module Api
  module V1
    # users
    class MyPollsController < ApplicationController
      def index
        @polls = MyPoll.all
      end

      def show
        @poll = MyPoll.find_by_id(params[:id])
      end

      def create; end

      def update; end

      def destroy; end
    end
  end
end
