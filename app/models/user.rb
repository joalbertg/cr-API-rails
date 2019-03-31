# frozen_string_literal: true

# user
class User < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------
  has_many :tokens

  # -- Validations ----------------------------------------------------------
  validates :uid, presence: true
  validates :provider, presence: true
  validates :email,
            presence: true,
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
            if data.fetch(:info)
              user.email = data.fetch(:info).fetch(:email)
              # user.name = data.fetch(:info).fetch(:name)
            end
          end
  end

  # -- Instance Methods -----------------------------------------------------
end
