class MyApp < ActiveRecord::Base
  belongs_to :user
  has_many :tokens

  validates :title, presence: true
  validates :secret_key, uniqueness: true
  validates :app_id, uniqueness: true

  before_create :generate_app_id
  before_create :generate_secret_key

  def your_token?(token)
    tokens.where(tokens: { id: token.id }).any?
  end

  private

  def generate_secret_key
    loop do
      self.secret_key = SecureRandom.hex
      break if MyApp.where(secret_key: secret_key).empty?
    end
  end

  def generate_app_id
    loop do
      self.app_id = SecureRandom.hex
      break if MyApp.where(app_id: app_id).empty?
    end
  end
end
