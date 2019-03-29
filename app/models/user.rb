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

  # -- Instance Methods -----------------------------------------------------
end
