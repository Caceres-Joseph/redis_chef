
require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new(region: 'us-west-2')
item = {
    'ipAddress': (node['ipaddress']).to_s,
    'host': (node['hostname']).to_s
}

params = {
    table_name: 'joseph-chef',
    item: item
}

begin
#  dynamodb.put_item(params)
  dynamodb.put_item({
    item: {
      'ipAddress': node['ipaddress'],
      'host': node['hostname']
    },
    table_name: 'joseph-chef',
  })

  puts 'Added ip: '
rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to add ip:'
  puts error.message
end
