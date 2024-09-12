
```shell
OpenSpace-S3-code/W4D3/esRNT on  main [⇡+] via 🅒 base 
➜ source .env                                                                                                   

OpenSpace-S3-code/W4D3/esRNT on  main [⇡!+?] via 🅒 base 
➜ forge script --chain sepolia NFTMarketScript --rpc-url $SEPOLIA_RPC_URL --account MetaMask --broadcast --verify -vvvv  

Error: 
No contract found with the name `NFTMarketScript`

OpenSpace-S3-code/W4D3/esRNT on  main [⇡!+?] via 🅒 base 
➜ forge script --chain sepolia esRNTScript --rpc-url $SEPOLIA_RPC_URL --account MetaMask --broadcast --verify -vvvv      

[⠊] Compiling...
[⠒] Compiling 22 files with Solc 0.8.20
[⠢] Solc 0.8.20 finished in 1.07s
Compiler run successful!
Enter keystore password:
Traces:
  [573336] esRNTScript::run()
    ├─ [0] VM::startBroadcast()
    │   └─ ← [Return] 
    ├─ [532640] → new esRNT@0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb
    │   └─ ← [Return] 63 bytes of code
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return] 
    └─ ← [Stop] 


Script ran successfully.

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [532640] → new esRNT@0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb
    └─ ← [Return] 63 bytes of code


==========================

Chain 11155111

Estimated gas price: 60.680620566 gwei

Estimated total gas used for script: 770088

Estimated amount required: 0.046729417730429808 ETH

==========================

##### sepolia
✅  [Success]Hash: 0x424e03bf6ec9f302f7d51ab29b4d6e9e8af1ac90eac7e25b790ecb4f6a2be52c
Contract Address: 0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb
Block: 6367765
Paid: 0.020468293923707316 ETH (592404 gas * 34.551241929 gwei)

✅ Sequence #1 on sepolia | Total Paid: 0.020468293923707316 ETH (592404 gas * avg 34.551241929 gwei)
                                                                                                                                                                  

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
##
Start verification for (1) contracts
Start verifying contract `0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb` deployed on sepolia

Submitting verification for [src/esRNT.sol:esRNT] 0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb.

Submitting verification for [src/esRNT.sol:esRNT] 0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb.

Submitting verification for [src/esRNT.sol:esRNT] 0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb.

Submitting verification for [src/esRNT.sol:esRNT] 0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb.

Submitting verification for [src/esRNT.sol:esRNT] 0x14385ee5b58Ef54Fd459B4011A5c231c5E980bDb.
Submitted contract for verification:
        Response: `OK`
        GUID: `b2gbpn75b734rcja8cyj5rvi6m76inwthbtlpr4kmek562men8`
        URL: https://sepolia.etherscan.io/address/0x14385ee5b58ef54fd459b4011a5c231c5e980bdb
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
All (1) contracts were verified!

Transactions saved to: /Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/W4D3/esRNT/broadcast/esRNT.s.sol/11155111/run-latest.json

Sensitive values saved to: /Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/W4D3/esRNT/cache/esRNT.s.sol/11155111/run-latest.json


OpenSpace-S3-code/W4D3/esRNT on  main [⇡!+?] via 🅒 base took 1m 35.9s 
```
