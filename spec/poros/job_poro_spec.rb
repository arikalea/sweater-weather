require 'rails_helper'

RSpec.describe 'Job poro' do
  describe 'happy path' do
    it 'can create poro' do
      attrs = {
              job: {
                  id: "DATA-ANALYST",
                  title: "Data Analyst"
              },
              salary_percentiles: {
                  percentile_25: 42878.34161807408,
                  percentile_50: 51604.570316663645,
                  percentile_75: 62106.68549841864
              }
          }
      job = Job.new(attrs)

      expect(job).to be_a(Job)
      expect(job.title).to eq(attrs[:job][:title])
      expect(job.min).to eq("$#{attrs[:salary_percentiles][:percentile_25].round(2)}")
      expect(job.max).to eq("$#{attrs[:salary_percentiles][:percentile_75].round(2)}")
    end
  end
end
