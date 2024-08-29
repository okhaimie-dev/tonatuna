sozo execute tonatuna-actions create_fish_pond

# address=$(grep 'account_address' ./dojo_dev.toml | awk -F '"' '{print $2}')
address=0xe29882a1fcba1e7e10cad46212257fea5c752a4f9b1b1ec683c503a2cf5c8a
private_key_1=0x14d6672dcb4b77ca36a887e9a11cd9d637d5012468175829e9c6e770c61642
echo "Player 1 address: $address"

address_2=0xb3ff441a68610b30fd5e2abbf3a1548eb6ba6f3559f2862bf2dc757e5828ca
private_key_2=0x2bbf4f9fd0bbb2e60b0316c1fe0b76cf7a4d0198bd493ced9b8df2a3a24d68a
echo "Player 2 address: $address_2"


echo "Try to register player(might be failed cuz already exeisted)"
sozo execute tonatuna-actions new_player -c 0xff --account-address $address --private-key $private_key_1
sozo execute tonatuna-actions new_player -c 0xee --account-address $address_2 --private-key $private_key_2

echo "↑it's okay to fail↑"


echo "Player 1 info"
player_1_info=$(sozo model get Player $address)
echo $player_1_info

echo "Player 2 info"
player_2_info=$(sozo model get Player $address_2)
echo $player_2_info

echo "Reset Daily Attempts"
sozo execute tonatuna-actions reset_daily_attempts --account-address $address --private-key $private_key_1
sozo execute tonatuna-actions reset_daily_attempts --account-address $address_2 --private-key $private_key_2

echo "Buy Baits"
sozo execute tonatuna-actions buy_baits -c 5 --account-address $address --private-key $private_key_1
player_1_info=$(sozo model get Player $address)
echo $player_1_info
sozo execute tonatuna-actions buy_baits -c 5 --account-address $address_2 --private-key $private_key_2
player_2_info=$(sozo model get Player $address_2)
echo $player_2_info

fish_pond_id=1
fish_id=1
fish_id_2=1 # same fish_id
fish_num=5
salt=123
salt_2=456
# fish_id=1, salt=123, then
commitment=0x2FD1E45D82B19ECDEEA8D16601D97F16D293D767A288B7774DE2B28B4C299B0
# fish_id=1, salt=456, then
commitment_2=0x430283BD41E0C78039DB8234BACB08860B3E0CD42F435FF60BC8D5CD4159345

echo "Fish Pond Info"
fish_pond_info=$(sozo model get FishPond $fish_pond_id)
echo $fish_pond_info

sozo execute tonatuna-actions spawn_multiple_fishes -c $fish_pond_id,$fish_num

echo "Fish ID: $fish_id"
fish_info=$(sozo model get Fish $fish_pond_id $fish_id)
echo $fish_info

echo "Fish ID: $fish_id_2"
fish_info_2=$(sozo model get Fish $fish_pond_id $fish_id_2)
echo $fish_info_2

echo "cast fishing"
# 
sozo execute tonatuna-actions cast_fishing -c $fish_pond_id,$commitment --account-address $address --private-key $private_key_1

sozo execute tonatuna-actions cast_fishing -c $fish_pond_id,$commitment_2 --account-address $address_2 --private-key $private_key_2

echo "Commitment:"
commitment_info=$(sozo model get Commitment $address $fish_pond_id)
echo $commitment_info

sleep 2

echo "Commitment 2:"
commitment_info_2=$(sozo model get Commitment $address_2 $fish_pond_id)
echo $commitment_info_2

sleep 30
# to proceed block number
sozo execute tonatuna-actions create_fish_pond
echo "Reveal History"
reveal_history=$(sozo model get RevealHistory $fish_pond_id $fish_id)
echo $reveal_history

echo "Reveal"
sozo execute tonatuna-actions reel_by_revealing -c $fish_pond_id,$fish_id,$salt --account-address $address --private-key $private_key_1

sleep 2

echo "Reveal 2"
sozo execute tonatuna-actions reel_by_revealing -c $fish_pond_id,$fish_id_2,$salt_2 --account-address $address_2 --private-key $private_key_2

echo "Reveal History"
reveal_history=$(sozo model get RevealHistory $fish_pond_id $fish_id)
echo $reveal_history


sleep 20
# to proceed block number
sozo execute tonatuna-actions create_fish_pond

echo "Catch"
sozo execute tonatuna-actions catch_the_fish -c $fish_pond_id,$fish_id --account-address $address --private-key $private_key_1

echo "Catch 2"
sozo execute tonatuna-actions catch_the_fish -c $fish_pond_id,$fish_id_2 --account-address $address_2 --private-key $private_key_2

echo "Player 1 Status"
player_info=$(sozo model get Player $address)
echo $player_info

echo "Player 2 Status"
player_info_2=$(sozo model get Player $address_2)
echo $player_info_2