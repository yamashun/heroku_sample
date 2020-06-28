namespace :coverage do
  desc '実行結果をS3にアップロード'

  task upload: :environment do
    CoverageS3Upload.new.upload
  end
end
