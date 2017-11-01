#!/bin/bash
geth --networkid 13 --datadir ~/.ethereum-blokkchat --port 30304 --rpc --rpcport "8545" --rpccorsdomain "http://localhost:3000,http://localhost:3001,https://www.ttt222.org,https://www.eth.ttt222.org,https://www.blokkchat.ttt222.org,https://www.cybernetic.ttt222.org,https://www.cybernetic-chat.ttt222.org" --bootnodes "enode://b7c95ea29b647e03d6c2abd31f76ae4f2e43cdca5b280d09dd78b7a1cefbb25832d2f515c49c7ff7c9d46894cc6f92da3f6b4f0d762f8f901206ae1f5a5aa5bf@67.191.137.216:30303" $@ console
