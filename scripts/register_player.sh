sozo execute tonatuna-actions create_fish_pond

address=$(grep 'account_address' ./dojo_dev.toml | awk -F '"' '{print $2}')

echo "Player address: $address"
sozo execute tonatuna-actions new_player  --account-address $address --calldata 0x32 
