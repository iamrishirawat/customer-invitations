require_relative './list_users'

begin
  ListUsers.call
rescue Exception => e
  puts "Error while processing: #{e.message}"
end
