require 'aws-sdk-kinesis'
require 'faker'
require 'json'

# Create a client
kinesis = Aws::Kinesis::Client.new(
  region: 'us-east-1',
  endpoint: 'http://localhost:4568'
)

# Create the stream
begin
  kinesis.create_stream(stream_name: 'usersSignedUp', shard_count: 1)
rescue Aws::Kinesis::Errors::ResourceInUseException
  puts "The stream already exists"
end


loop do
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email_address = "#{first_name}.#{last_name}@#{Faker::Internet.domain_word}.#{Faker::Internet.domain_suffix}"

  fake_user_info = { firstName: first_name, lastName: last_name, emailAddress: email_address }

  puts "Publishing: #{fake_user_info}"

  resp = kinesis.put_record(
    stream_name: 'usersSignedUp', # required
    data: JSON.generate(fake_user_info), # required
    partition_key: 'sPartitionKey'
  )

  sleep 0.5
end
