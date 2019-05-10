# frozen_string_literal: true

# service to create token
class MyAppService
  def initialize(params, current_user)
    @user = current_user
    @my_app = @user.my_apps.new(params)
  end

  def create_object
    generate_secret_key
    generate_app_id
    @my_app.save ? true : false
  end

  def errors
    @my_app.errors
  end

  def object
    create_object
    @my_app
  end

  private

  def generate_secret_key
    loop do
      @my_app.secret_key = SecureRandom.hex
      break if MyApp.where(secret_key: @my_app.secret_key).empty?
    end
  end

  def generate_app_id
    loop do
      @my_app.app_id = SecureRandom.hex
      break if MyApp.where(app_id: @my_app.app_id).empty?
    end
  end
end
