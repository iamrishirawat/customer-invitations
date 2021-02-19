require_relative '../app/list_users'

describe ListUsers do

  it 'checks invalid data for filter_and_sort_users' do
    expect{ ListUsers.send(:set_users_distance_from_base, nil) }.to raise_error(NoMethodError)
  end

  it 'filters and sorts users successfully' do
    users = [
      {"latitude"=>"52.986375", "user_id"=>12, "name"=>"Christina McArdle", "longitude"=>"-6.043701"},
      {"latitude"=>"52.228056", "user_id"=>18, "name"=>"Bob Larkin", "longitude"=>"-7.915833"}
    ]
    expect(ListUsers.send(:set_users_distance_from_base, users)).to eq(
      [
        {"latitude"=>"52.986375", "user_id"=>12, "name"=>"Christina McArdle", "longitude"=>"-6.043701", "distance"=>41.77},
        {"latitude"=>"52.228056", "user_id"=>18, "name"=>"Bob Larkin", "longitude"=>"-7.915833", "distance"=>166.45}
      ]
    )
  end

  it 'checks invalid data for filter_and_sort_users' do
    expect{ ListUsers.send(:filter_and_sort_users, nil) }.to raise_error(NoMethodError)
  end

  it 'filters and sorts users successfully' do
    users = [
      {"user_id" => 14,"name" => "Ian Kehoe","distance" => 10.57},
      {"user_id" => 5,"name" => "Nora Dempsey","distance" => 123.29},
      {"user_id" => 12,"name" => "Christina McArdle","distance" => 41.77}
    ]
    expect(ListUsers.send(:filter_and_sort_users, users)).to eq([{"name"=>"Christina McArdle", "user_id"=>12},{"name"=>"Ian Kehoe", "user_id"=>14}])
  end
end
