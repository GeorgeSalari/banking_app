# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FundsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/bank_account/10/transaction_history').to route_to(
        controller: 'transaction_history',
        action: 'index',
        bank_account_id: '10'
      )
    end
  end
end
