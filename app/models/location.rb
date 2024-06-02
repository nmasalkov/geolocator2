# frozen_string_literal: true
class Location < ApplicationRecord
  validates :url, uniqueness: true
  validates :ip_address, uniqueness: true
end
