# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

TXID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

RAW_TRANSACTION=$(bitcoin-cli getrawtransaction "$TXID" true)
PUB_KEY_1=$(echo $RAW_TRANSACTION | jq -r '.vin[0].txinwitness[1]')
PUB_KEY_2=$(echo $RAW_TRANSACTION | jq -r '.vin[1].txinwitness[1]')
PUB_KEY_3=$(echo $RAW_TRANSACTION | jq -r '.vin[2].txinwitness[1]')
PUB_KEY_4=$(echo $RAW_TRANSACTION | jq -r '.vin[3].txinwitness[1]')

MULTISIG=$(bitcoin-cli createmultisig 1 "[\"$PUB_KEY_1\",\"$PUB_KEY_2\",\"$PUB_KEY_3\",\"$PUB_KEY_4\"]")
ADDRESS=$(echo $MULTISIG | jq -r '.address')

echo $ADDRESS
