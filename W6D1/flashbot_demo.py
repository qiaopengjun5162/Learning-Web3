
import os

import requests
from dotenv import load_dotenv
from eth_account import Account, messages
from web3 import Web3

load_dotenv()

"""
利用 flashbot eth_sendBundle 捆绑 OpenspaceNFT 的开启预售和参与
预售的交易(sepolia 测试网络)，并使用 flashbots_getBundleStats 查询状态，最终打印交易哈
希和 stats 信息

https://protect.flashbots.net/summary?fast=true
https://docs.flashbots.net/flashbots-protect/quick-start
https://docs.flashbots.net/flashbots-auction/advanced/rpc-endpoint
https://web3py.readthedocs.io/en/stable/quickstart.html
https://eth-account.readthedocs.io/en/stable/eth_account.html
https://github.com/ethereum/eth-account
"""


url = "https://relay-sepolia.flashbots.net"
mainnet = "https://relay.flashbots.net"
data = {
    "jsonrpc": "2.0",
    "id": 1,
    "method": "eth_sendBundle",
    "params": [
        {
            "txs": ["0x123abc...", "0x456def..."],
            "blockNumber": "0xb63dcd",
            "minTimestamp": 0,
            "maxTimestamp": 1615920932
        }
    ]
}
my_id = os.getenv("ID")
my_secret_key = os.getenv("SECRET_KEY")
private_key = os.getenv("PRIVATE_KEY")

body = '{"jsonrpc":"2.0","method":"eth_sendBundle","params":[{see above}],"id":1}'
message = messages.encode_defunct(text=Web3.keccak(text=body).hex())
signature = Account.from_key(private_key).address + ':' + \
    Account.sign_message(message, private_key).signature.hex()

headers = {
    "Content-Type": "application/json",
    "X-Flashbots-Signature": signature
}

response = requests.post(url=mainnet, headers=headers, data=body)
print(response.json())
