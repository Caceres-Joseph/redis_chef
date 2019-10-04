
require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new(region: node["opsworks"]["instance"]["region"])
item = {
    ipAddress: node['ipaddress'],
    host: node['hostname']
}

params = {
    table_name: 'joseph-chef',
    item: item
}

begin
  dynamodb.put_item(params)
  puts 'Added ip: '
rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to add ip:'
  puts error.message
end
