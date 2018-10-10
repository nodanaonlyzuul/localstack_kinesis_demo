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
  kinesis.create_stream(stream_name: 'usersSignedUp', shard_count: 2)
rescue Aws::Kinesis::Errors::ResourceInUseException
  puts 'The stream already exists'
end

shared_response = kinesis.list_shards(stream_name: 'usersSignedUp')

iterator = kinesis.get_shard_iterator(
  stream_name: 'usersSignedUp', # required
  shard_id: shared_response.shards[0].shard_id, # required
  shard_iterator_type: 'TRIM_HORIZON'
).shard_iterator

resp = kinesis.get_records(shard_iterator: iterator, limit: 100)

resp.records.each do |record|
  fake_user_info = JSON.parse(record.data)
  message = "A user was created named #{fake_user_info['firstName']} #{fake_user_info['lastName']}"
  puts message
  `say -v #{['Fred', 'Kathy', 'Ava', 'Allison', 'Junior', 'Juan'].sample} --rate=300 "#{message}"`
end
