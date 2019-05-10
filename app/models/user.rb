# frozen_string_literal: true

# users model
class User < ActiveRecord::Base
  include Utility

  # -- Relationships --------------------------------------------------------
  has_many :tokens
  has_many :my_polls
  has_many :my_apps
  has_many :user_polls

  # -- Validations ----------------------------------------------------------
  validates :uid, presence: true
  validates :provider, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                      on: :create }

  # -- Scopes ---------------------------------------------------------------

  # -- Callbacks ------------------------------------------------------------

  # -- Class Methods --------------------------------------------------------
  def self.from_omniauth(data)
    # receive hash
    # { provider: 'facebook', uid: '12345',
    #   info: { email: 'liss...', name: 'Liss' } }

    where(provider: data.fetch(:provider),
          uid: data.fetch(:uid)).first_or_create do |user|
            info = data.fetch(:info)
            if info
              user.email = info.fetch(:email)
              # user.name = data.fetch(:info).fetch(:name)
            end
          end
  end

  # -- Instance Methods -----------------------------------------------------
end
