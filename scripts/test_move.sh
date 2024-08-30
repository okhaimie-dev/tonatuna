sozo execute tonatuna-actions create_fish_pond

address=$(grep 'account_address' ./dojo_dev.toml | awk -F '"' '{print $2}')

echo "Player address: $address"
# sozo execute tonatuna-actions new_player  --account-address $address --calldata 0x32 

echo "move to 0x2,0x3"
sozo execute tonatuna-actions move -c 0x2,0x3

player_info=$(sozo model get Player $address)
echo $player_info
