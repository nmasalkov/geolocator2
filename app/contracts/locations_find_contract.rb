# frozen_string_literal: true

class LocationsFindContract < Dry::Validation::Contract
  params do
    required(:source).filled(:string)
    required(:type).filled(:string)
  end
end
