sozo execute tonatuna-actions create_fish_pond

# address=$(grep 'account_address' ./dojo_dev.toml | awk -F '"' '{print $2}')
address=0xb3ff441a68610b30fd5e2abbf3a1548eb6ba6f3559f2862bf2dc757e5828ca

echo "Player address: $address"
sozo execute tonatuna-actions new_player  --account-address $address --calldata 0x45
