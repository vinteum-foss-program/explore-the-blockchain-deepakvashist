# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

TXN_ID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
TXN_INFO=$(bitcoin-cli getrawtransaction $TXN_ID true)
KEY=$(echo $TXN_INFO | jq -r '.vin[0].txinwitness[2]')
PUBLIC_KEY=${KEY:4:66}

echo $PUBLIC_KEY
