# frozen_string_literal: true

# user
class User < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------
  has_many :tokens

  # -- Validations ----------------------------------------------------------
  validates :email, presence: true, email: true
  validates :uid, presence: true
  validates :provider, presence: true
  
  # -- Scopes ---------------------------------------------------------------

  # -- Callbacks ------------------------------------------------------------

  # -- Class Methods --------------------------------------------------------

  # -- Instance Methods -----------------------------------------------------
end
