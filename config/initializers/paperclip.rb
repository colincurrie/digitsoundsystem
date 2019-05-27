Paperclip::Attachment.default_options[:url] = 'https://s3.eu-west-2.amazonaws.com/digitsoundsystem-gallery'
Paperclip::Attachment.default_options[:path] = "#{ENV.fetch('RAILS_ENV','development')}/:class/:id/:style/:basename.:extension"
Paperclip::Attachment.default_options[:s3_host_name] = 's3.eu-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:s3_region] = 'EU (London)'
