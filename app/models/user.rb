class User < ApplicationRecord
  has_one :address, dependent: :destroy
    
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true,
                    format: {
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
                    },
                    uniqueness: true
    
  accepts_nested_attributes_for :address, allow_destroy: true
end
