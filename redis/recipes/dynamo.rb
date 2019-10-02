
require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new()
item = {
    ip: node['ipaddress']
}

params = {
    table_name: 'chef-joseph',
    item: item
}

begin
  dynamodb.put_item(params)
  puts 'Added ip: '
rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to add ip:'
  puts error.message
end
