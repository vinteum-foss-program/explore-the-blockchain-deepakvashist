# Only one single output remains unspent from block 123,321. What address was it sent to?

BLOCK_NUMBER=123321

BLOCK_HASH=$(bitcoin-cli getblockhash $BLOCK_NUMBER)
BLOCK=$(bitcoin-cli getblock $BLOCK_HASH)

TXN_IDS=$(echo "$BLOCK" | jq -r '.tx[]')

for TXN_ID in $(echo "$BLOCK" | jq -r '.tx[]'); do
  RAW_TXN=$(bitcoin-cli getrawtransaction "$TXN_ID" true 2>/dev/null)
  OUTPUTNS=$(echo "$RAW_TXN" | jq -r '.vout[].n')

  for OUTPUTN in $OUTPUTNS; do
    TXNOUT=$(bitcoin-cli gettxout "$TXN_ID" "$OUTPUTN")
    if [ -n "$TXNOUT" ]; then
      ADDRESS=$(echo $TXNOUT | jq -r '.scriptPubKey.address')
      echo $ADDRESS
      exit 0
    fi
  done
done
