sozo execute tonatuna-actions create_fish_pond

address=$(grep 'account_address' ./dojo_dev.toml | awk -F '"' '{print $2}')
echo "Player address: $address"

echo "Player info"
player_info=$(sozo model get Player $address)
echo $player_info

echo "Reset Daily Attempts"
sozo execute tonatuna-actions reset_daily_attempts

echo "Buy Baits"
sozo execute tonatuna-actions buy_baits -c 5
player_info=$(sozo model get Player $address)
echo $player_info

fish_pond_id=1
fish_id=1
fish_num=5
commitment=0x2FD1E45D82B19ECDEEA8D16601D97F16D293D767A288B7774DE2B28B4C299B0
salt=123

echo "Fish Pond Info"
fish_pond_info=$(sozo model get FishPond $fish_pond_id)
echo $fish_pond_info

sozo execute tonatuna-actions spawn_multiple_fishes -c $fish_pond_id,$fish_num

echo "Fish ID: $fish_id"
fish_info=$(sozo model get Fish $fish_pond_id $fish_id)
echo $fish_info

echo "cast fishing"
sozo execute tonatuna-actions cast_fishing -c $fish_pond_id,$commitment

echo "Commitment:"
commitment_info=$(sozo model get Commitment $address $fish_pond_id)
echo $commitment_info

sleep 30
# to proceed block number
sozo execute tonatuna-actions create_fish_pond

echo "Reveal"
sozo execute tonatuna-actions reel_by_revealing -c $fish_pond_id,$fish_id,$salt

sleep 30
# to proceed block number
sozo execute tonatuna-actions create_fish_pond

echo "Catch"
sozo execute tonatuna-actions catch_the_fish -c $fish_pond_id,$fish_id

echo "Player Status"
player_info=$(sozo model get Player $address)
echo $player_info