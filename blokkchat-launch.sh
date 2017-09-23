#!/bin/bash
geth --networkid 13 --nodiscover --datadir ~/.ethereum-blokkchat --port 30304 --rpc --rpcport "8545" --bootnode "enode://b7c95ea29b647e03d6c2abd31f76ae4f2e43cdca5b280d09dd78b7a1cefbb25832d2f515c49c7ff7c9d46894cc6f92da3f6b4f0d762f8f901206ae1f5a5aa5bf@24.98.78.94:30303?discport=0" $@ console
