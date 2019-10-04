
require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new(region: 'us-west-2')

begin
  
  result = client.get_item({
    item: {
      "ip" =>  node['ipaddress']
    },  
    table_name: "chef-joseph" 
  })

  if result.item == nil
    resp = dynamodb.put_item({
      item: {
        "ip" =>  node['ipaddress'], 
        "host" => node['hostname'] 
      },  
      table_name: "chef-joseph" 
    })
  
    puts 'Agregando el maestro' 
  else
    puts 'Si hay maestro dentro de la tabla, agregando el esclavo'
  end




#  dynamodb.put_item(params)
#  dynamodb.put_item({item: {"ipAddress"=> node['ipaddress'], "host" =>  node['hostname']}, table_name: "joseph-chef"})
  


rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to add ip:'
  puts error.message
end
