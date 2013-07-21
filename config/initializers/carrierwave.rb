
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => "AWS",                        # required
    :aws_access_key_id      => 'AKIAJDFCUGIGBA63N4RQ',                        # required
    :aws_secret_access_key  => '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',                        # required
  }
  config.fog_directory  = "moviepulse"                     # required
end

#CarrierWave.configure do |config|
#  config.root = ::Rails.root.to_s + "/public"
#end