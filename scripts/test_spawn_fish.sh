sozo execute tonatuna-actions create_fish_pond

# address=$(grep 'account_address' ./dojo_dev.toml | awk -F '"' '{print $2}')
# echo "Player address: $address"

fish_pond_id=1
fish_id=1


echo "Fish Pond Info"
fish_pond_info=$(sozo model get FishPond $fish_pond_id)
echo $fish_pond_info

sozo execute tonatuna-actions spawn_fish -c $fish_pond_id,$fish_id

fish_info=$(sozo model get Fish $fish_pond_id $fish_id)
echo $fish_info
