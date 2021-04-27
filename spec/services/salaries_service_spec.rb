require 'rails_helper'

RSpec.describe SalariesService do
  it 'returns salaries for specific jobs' do
    jobs = SalariesService.get_salary_info('denver')

    expect(jobs).to be_an(Array)
    expect(jobs.count).to eq(7)
    expect(jobs.first).to be_a(Job)

    jobs.each do |job|
      expect(job.title).to be_a(String)
      expect(job.min).to be_a(String)
      expect(job.max).to be_a(String)
    end
  end

  it 'finds specific jobs' do
    job_1 = Job.new({
            "job": {
                "id": "ARCHITECT",
                "title": "Architect"
            },
            "salary_percentiles": {
                "percentile_25": 43470.96334773236,
                "percentile_50": 53828.81526137848,
                "percentile_75": 66654.63862085681
            }
        })
    job_2 = Job.new({
            "job": {
                "id": "DATA-ANALYST",
                "title": "Data Analyst"
            },
            "salary_percentiles": {
                "percentile_25": 42878.34161807408,
                "percentile_50": 51604.570316663645,
                "percentile_75": 62106.68549841864
            }
        })
    all_jobs = [job_1, job_2]
    result = SalariesService.find_job_titles(all_jobs)

    expect(result).to be_an(Array)
    expect(result.count).to eq(1)
    expect(result).to include(job_2)
    expect(result).to_not include(job_1)
  end
end
