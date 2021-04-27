require 'rails_helper'

RSpec.describe 'Job poro' do
  describe 'happy path' do
    it 'can create poro' do
      attrs = { title: 'Data Analyst',
                min: 42878.34161807408,
                max: 62106.68549841864 }
      job = Job.new(attrs)

      expect(job).to be_a(Job)
      expect(job.title).to eq(attrs[:title])
      expect(job.min).to eq(attrs[:min].round(2))
      expect(job.max).to eq(attrs[:max].round(2))
    end
  end
end
