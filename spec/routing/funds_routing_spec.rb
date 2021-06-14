# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FundsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/funds').to route_to('funds#index')
    end
  end
end
