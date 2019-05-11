class MyApp < ActiveRecord::Base
  belongs_to :user
  has_many :tokens

  validates :title, presence: true
  validates :secret_key, uniqueness: true
  validates :app_id, uniqueness: true

  def your_token?(token)
    tokens.where(tokens: { id: token }).any?
  end

  def valid_origin?(domain)
    javascript_origins.try(:split, ',').include?(domain) unless javascript_origins.empty?
  end
end
