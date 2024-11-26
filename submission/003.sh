# How many new outputs were created by block 123,456?

BLOCK_HASH=$(bitcoin-cli getblockhash "123456")

BLOCK_DETAILS=$(bitcoin-cli getblock $BLOCK_HASH 2)
TXN_IDS=$(echo $BLOCK_DETAILS | jq -r '.tx[].txid')

TOTAL_OUTPUTS=0

for TXN_ID in $TXN_IDS; do
  TXN=$(bitcoin-cli getrawtransaction $TXN_ID 1)
  TOTAL_OUTPUTS=$((TOTAL_OUTPUTS + $(echo $TXN | jq '.vout | length')))
done

echo $TOTAL_OUTPUTS
