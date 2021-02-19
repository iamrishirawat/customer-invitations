require_relative './lib/calculations'
require_relative './lib/file_operations'

class ListUsers
  MAX_DISTANCE = 100
  BASE_LATITUDE = 53.339428
  BASE_LONGITUDE = -6.257664
  USERS_FILE_URL = 'https://s3.amazonaws.com/intercom-take-home-test/customers.txt'.freeze

  class << self
    include Calculations
    include FileOperations

    def call
      users = import_data_list(USERS_FILE_URL)
      return puts "No customers found!!!" if users.nil? || users.empty?
      users = set_users_distance_from_base(users)
      user_list = filter_and_sort_users(users)
      export_data_list("invitation_list.txt", user_list)
    end

    private

    def set_users_distance_from_base(users)
      params = {
        phi1: convert_degrees_to_radians(BASE_LATITUDE),
        lambda1: convert_degrees_to_radians(BASE_LONGITUDE)
      }
      users.each do |user|
        params[:phi2] = convert_degrees_to_radians(user["latitude"].to_f)
        params[:lambda2] = convert_degrees_to_radians(user["longitude"].to_f)
        user["distance"] = calculate_great_circle_distance(**params)
      end
      users
    end

    def filter_and_sort_users(users)
      user_list = users.select { |user| user["distance"] <= 100 }
      user_list = user_list.map { |user| user.slice("user_id", "name") }
      user_list.sort_by { |user| user["user_id"] }
    end
  end
end
