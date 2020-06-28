Aws.config.update({
  credentials: Aws::Credentials.new(
    ENV['AWS_S3_ACCESS_KEY_ID'],
    ENV['AWS_S3_SECRET_ACCESS_KEY']
  )
})
