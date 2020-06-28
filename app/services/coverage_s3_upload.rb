class CoverageS3Upload
  def upload
    bucket = Aws::S3::Resource.new.bucket(ENV['COVERAGE_BUCKET'])
    create_summary_json
    file = File.open("#{::Rails.root}/coverage/coverage_summary.json","r")
    bucket.put_object(body: file, key: "all/#{Date.today.strftime('%Y-%m')}/coverage-#{Time.now.strftime('%d-%H-%M-%S')}.json")
  end

  private

  def create_summary_json
    file_path = "#{::Rails.root}/coverage/coverage.json"
    hash = File.open(file_path) do |j|
      JSON.load(j)
    end

    result = hash['metrics']
    result['date'] = Date.today.strftime('%Y-%m-%d')
    result['time'] = result['time'] = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    File.write("#{::Rails.root}/coverage/coverage_summary.json", result.to_json)
  end
end
