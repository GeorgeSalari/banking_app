# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do

  ## Test of validations
  it { should validate_presence_of :from_bank_account }
  it { should validate_presence_of :to_bank_account }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of(:amount).is_greater_than(0) }

  ## Test of associations
  it { should belong_to(:from_bank_account) }
  it { should belong_to(:to_bank_account) }
end
