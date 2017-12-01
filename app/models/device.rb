class Device < ApplicationRecord
  has_many :measurements, dependent: :destroy
end
