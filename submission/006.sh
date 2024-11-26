# Which tx in block 257,343 spends the coinbase output of block 256,128?

BLOCK_COINBASE=256128
BLOCK_SPENDING=257343

COINBASE_TXNID=$(bitcoin-cli getblock $(bitcoin-cli getblockhash $BLOCK_COINBASE) | jq -r '.tx[0]')
TXN_IDS=$(bitcoin-cli getblock $(bitcoin-cli getblockhash $BLOCK_SPENDING) | jq -r '.tx[]')

for TXN_ID in $TXN_IDS; do
  RAW_TX=$(bitcoin-cli getrawtransaction "$TXN_ID" true)
  if echo "$RAW_TX" | jq -e --arg coinbase_txnid "$COINBASE_TXNID" '.vin[] | select(.txid == $coinbase_txnid)' > /dev/null; then
    echo $TXN_ID
    exit 0
  fi
done
