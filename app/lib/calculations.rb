module Calculations
  include Math

  EARTH_MEAN_RADIUS = 6371.009

  def convert_degrees_to_radians(degrees)
    (degrees * Math::PI) / 180
  rescue Exception => e
    puts "Incorrect argument passed to method #{__method__}: #{degrees.inspect}"
  end

  def calculate_great_circle_distance(phi1:, lambda1:, phi2:, lambda2:)
    del_lambda = lambda1 - lambda2
    num = sqrt((cos(phi2)*sin(del_lambda))**2 + (cos(phi1)*sin(phi2) - sin(phi1)*cos(phi2)*cos(del_lambda))**2)
    den = sin(phi1)*sin(phi2) + cos(phi1)*cos(phi2)*cos(del_lambda)
    angle = atan( num / den )
    (EARTH_MEAN_RADIUS * angle).round(2) # Verified here https://www.onlineconversion.com/map_greatcircle_distance.htm
  rescue Math::DomainError => e
    puts "Incorrect arguments provided : #{e.message}"
  rescue Exception => e
    puts "Error while calculating great circle distance : #{e.message}"
  end
end