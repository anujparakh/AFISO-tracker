# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  subject do
    described_class.new(semester_name: 'Fall 2020', start_date: DateTime.now, end_date: (DateTime.now + 2),
                        dues_deadline: (DateTime.now + 1))
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.semester_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a start date' do
      subject.start_date = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an end date' do
      subject.end_date = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if end date is before start date' do
      subject.end_date = subject.start_date - 1
      expect(subject).to_not be_valid
    end

    it 'is not valid if due date is before start date' do
      subject.dues_deadline = subject.start_date - 1
      expect(subject).to_not be_valid
    end

    it 'is not valid if due date is after start date' do
      subject.dues_deadline = subject.end_date + 1
      expect(subject).to_not be_valid
    end
  end
end
