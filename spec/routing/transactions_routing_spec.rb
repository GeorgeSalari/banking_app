# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(get: '/transactions/new').to route_to('transactions#new')
    end

    it 'routes to #create' do
      expect(post: '/transactions').to route_to('transactions#create')
    end
  end
end
