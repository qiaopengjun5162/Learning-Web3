# Web3 tutorial

## 实操

```bash
OpenSpace-S3-code on  main via 🅒 base
➜
mcd Web3_tutorial

OpenSpace-S3-code/Web3_tutorial on  main via 🅒 base
➜
pnpm init
Wrote to /Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/package.json

{
  "name": "Web3_tutorial",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base
➜
pnpm install --save-dev hardhat
 WARN  GET https://registry.npmjs.org/hardhat/-/hardhat-2.22.13.tgz error (ECONNRESET). Will retry in 10 seconds. 2 retries left.
Progress: resolved 2, reused 1, downloaded 0, added 0
^C

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 1m 1.9s
➜
export https_proxy=http://127.0.0.1:33210 http_proxy=http://127.0.0.1:33210 all_proxy=socks5://127.0.0.1:33210

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base
➜
pnpm install --save-dev hardhat

   ╭──────────────────────────────────────────────────────────────────╮
   │                                                                  │
   │                Update available! 9.8.0 → 9.12.1.                 │
   │   Changelog: https://github.com/pnpm/pnpm/releases/tag/v9.12.1   │
   │                Run "pnpm self-update" to update.                 │
   │                                                                  │
   │         Follow @pnpmjs for updates: https://x.com/pnpmjs         │
   │                                                                  │
   ╰──────────────────────────────────────────────────────────────────╯

Downloading @nomicfoundation/edr-darwin-x64@0.6.3: 5.30 MB/5.30 MB, done
Downloading @nomicfoundation/edr-linux-x64-gnu@0.6.3: 7.54 MB/7.54 MB, done
Downloading @nomicfoundation/edr-linux-x64-musl@0.6.3: 7.52 MB/7.52 MB, done
Downloading @nomicfoundation/edr-linux-arm64-musl@0.6.3: 7.64 MB/7.64 MB, done
Downloading @nomicfoundation/edr-win32-x64-msvc@0.6.3: 5.55 MB/5.55 MB, done
Downloading @nomicfoundation/edr-linux-arm64-gnu@0.6.3: 7.70 MB/7.70 MB, done
 WARN  3 deprecated subdependencies found: glob@7.2.0, glob@8.1.0, inflight@1.0.6
Packages: +257
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Progress: resolved 257, reused 244, downloaded 13, added 257, done
node_modules/.pnpm/secp256k1@4.0.3/node_modules/secp256k1: Running install script, done in 3.8s

devDependencies:
+ hardhat 2.22.13

Done in 22.1s

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 22.3s
➜
touch StudyNotes.md

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base
➜
pnpm self-update
The latest version, v9.12.1, is already present on the system. It was activated by linking it from /Users/qiaopengjun/Library/pnpm/.tools/pnpm/9.12.1.

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base
➜
pnpx hardhat
 WARN  3 deprecated subdependencies found: glob@7.2.0, glob@8.1.0, inflight@1.0.6
Packages: +257
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Progress: resolved 257, reused 257, downloaded 0, added 257, done
888    888                      888 888               888
888    888                      888 888               888
888    888                      888 888               888
8888888888  8888b.  888d888 .d88888 88888b.   8888b.  888888
888    888     "88b 888P"  d88" 888 888 "88b     "88b 888
888    888 .d888888 888    888  888 888  888 .d888888 888
888    888 888  888 888    Y88b 888 888  888 888  888 Y88b.
888    888 "Y888888 888     "Y88888 888  888 "Y888888  "Y888

👷 Welcome to Hardhat v2.22.13 👷‍

✔ What do you want to do? · Create a JavaScript project
✔ Hardhat project root: · /Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial
✔ Do you want to add a .gitignore? (Y/n) · y
✔ Do you want to install this sample project's dependencies with pnpm (@nomicfoundation/hardhat-network-helpers @nomicfoundation/hardhat-verify chai hardhat-gas-reporter solidity-coverage @nomicfoundation/hardhat-ignition @nomicfoundation/hardhat-toolbox @nomicfoundation/hardhat-chai-matchers @nomicfoundation/hardhat-ethers ethers @typechain/hardhat typechain @typechain/ethers-v6 @nomicfoundation/hardhat-ignition-ethers)? (Y/n) · y




pnpm add -D "@nomicfoundation/hardhat-network-helpers@^1.0.0" "@nomicfoundation/hardhat-verify@^2.0.0" "chai@^4.2.0" "hardhat-gas-reporter@^1.0.8" "solidity-coverage@^0.8.0" "@nomicfoundation/hardhat-ignition@^0.15.0" "@nomicfoundation/hardhat-toolbox@^5.0.0" "@nomicfoundation/hardhat-chai-matchers@^2.0.0" "@nomicfoundation/hardhat-ethers@^3.0.0" "ethers@^6.4.0" "@typechain/hardhat@^9.0.0" "typechain@^8.3.0" "@typechain/ethers-v6@^0.5.0" "@nomicfoundation/hardhat-ignition-ethers@^0.15.0"
 WARN  5 deprecated subdependencies found: glob@5.0.15, glob@7.1.7, glob@7.2.0, glob@8.1.0, inflight@1.0.6
Packages: +268 -1
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
Progress: resolved 524, reused 501, downloaded 23, added 268, done

devDependencies:
+ @nomicfoundation/hardhat-chai-matchers 2.0.8
+ @nomicfoundation/hardhat-ethers 3.0.8
+ @nomicfoundation/hardhat-ignition 0.15.6
+ @nomicfoundation/hardhat-ignition-ethers 0.15.6
+ @nomicfoundation/hardhat-network-helpers 1.0.12
+ @nomicfoundation/hardhat-toolbox 5.0.0
+ @nomicfoundation/hardhat-verify 2.0.11
+ @typechain/ethers-v6 0.5.1
+ @typechain/hardhat 9.1.0
+ chai 4.5.0 (5.1.1 is available)
+ ethers 6.13.4
+ hardhat-gas-reporter 1.0.10 (2.2.1 is available)
+ solidity-coverage 0.8.13
+ typechain 8.3.2

 WARN  Issues with peer dependencies found
.
└─┬ @nomicfoundation/hardhat-toolbox 5.0.0
  └── ✕ unmet peer @types/chai@^4.2.0: found 5.0.0

Done in 15.1s

✨ Project created ✨

See the README.md file for some example tasks you can run

Give Hardhat a star on Github if you're enjoying it! ⭐️✨

     https://github.com/NomicFoundation/hardhat


DEPRECATION WARNING

 Initializing a project with npx hardhat is deprecated and will be removed in the future.
 Please use npx hardhat init instead.



OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 1m 1.8s
➜
ls
README.md         contracts         ignition          package.json      test
StudyNotes.md     hardhat.config.js node_modules      pnpm-lock.yaml

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base
➜
c

OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base
➜
OpenSpace-S3-code/Web3_tutorial on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ pnpm install @chainlink/contracts     
OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 11.3s 
➜ pnpm install --save-dev @chainlink/contracts 
OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 2.0s 
➜ pnpm uninstall @chainlink/contracts       

OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ npx hardhat compile 
Compiled 3 Solidity files successfully (evm target: paris).
npm notice
npm notice New minor version of npm available! 10.7.0 -> 10.9.0
npm notice Changelog: https://github.com/npm/cli/releases/tag/v10.9.0
npm notice To update run: npm install -g npm@10.9.0
npm notice

OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ npx hardhat run scripts/deployFundMe.js --network hardhat

OpenSpace-S3-code/Web3_tutorial on  main [✘!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ npx hardhat run scripts/deployFundMe.js --network sepolia
contract deploying
contract has been deployed successfully, contract address is 0x38A1e0224Dc1B50De2fDe584Eac4901058aD2602
verification skipped..
TypeError: Cannot read properties of undefined (reading 'address')
    at main (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/scripts/deployFundMe.js:35:69)
    at processTicksAndRejections (node:internal/process/task_queues:95:5)

OpenSpace-S3-code/Web3_tutorial on  main [✘!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 33.4s 
➜ pnpm install --save-dev dotenv    

OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 3.0s 
➜ pnpm install --save-dev @chainlink/env-enc   

OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 4.6s 
➜ npx env-enc set-pw                                       
Enter the password (input will be hidden): 
*********


OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ npx env-enc set   
Please enter the variable name (or press ENTER to finish): 
SEPOLIA_RPC_URL
Please enter the variable value (input will be hidden): 
*********************************************************************
Would you like to set another variable? Please enter the variable name (or press ENTER to finish): 
PRIVATE_KEY
Please enter the variable value (input will be hidden): 
******************************************************************
Would you like to set another variable? Please enter the variable name (or press ENTER to finish): 

OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ npx env-enc set   

OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 1m 40.4s 
➜ 

OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ npx hardhat run scripts/deployFundMe.js --network sepolia
contract deploying
contract has been deployed successfully, contract address is 0xB8eFaa87e3F8D027fB1F848a5B2E04f59dFd3838
Waiting for 5 confirmations
The contract 0xB8eFaa87e3F8D027fB1F848a5B2E04f59dFd3838 has already been verified on the block explorer. If you're trying to verify a partially verified contract, please use the --force flag.
https://sepolia.etherscan.io/address/0xB8eFaa87e3F8D027fB1F848a5B2E04f59dFd3838#code

ProviderError: execution reverted: Send more ETH
    at HttpProvider.request (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/node_modules/.pnpm/hardhat@2.22.13_ts-node@10.9.2_@types+node@22.7.5_typescript@5.6.3__typescript@5.6.3/node_modules/hardhat/src/internal/core/providers/http.ts:107:21)
    at processTicksAndRejections (node:internal/process/task_queues:95:5)
    at HardhatEthersProvider.estimateGas (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/node_modules/.pnpm/@nomicfoundation+hardhat-ethers@3.0.8_ethers@6.13.4_hardhat@2.22.13_ts-node@10.9.2_@types+nod_2f75xpawt3agbuz2b2qvz4znxq/node_modules/@nomicfoundation/hardhat-ethers/src/internal/hardhat-ethers-provider.ts:246:27)
    at /Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/node_modules/.pnpm/@nomicfoundation+hardhat-ethers@3.0.8_ethers@6.13.4_hardhat@2.22.13_ts-node@10.9.2_@types+nod_2f75xpawt3agbuz2b2qvz4znxq/node_modules/@nomicfoundation/hardhat-ethers/src/signers.ts:235:35
    at async Promise.all (index 0)
    at HardhatEthersSigner._sendUncheckedTransaction (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/node_modules/.pnpm/@nomicfoundation+hardhat-ethers@3.0.8_ethers@6.13.4_hardhat@2.22.13_ts-node@10.9.2_@types+nod_2f75xpawt3agbuz2b2qvz4znxq/node_modules/@nomicfoundation/hardhat-ethers/src/signers.ts:256:7)
    at HardhatEthersSigner.sendTransaction (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/node_modules/.pnpm/@nomicfoundation+hardhat-ethers@3.0.8_ethers@6.13.4_hardhat@2.22.13_ts-node@10.9.2_@types+nod_2f75xpawt3agbuz2b2qvz4znxq/node_modules/@nomicfoundation/hardhat-ethers/src/signers.ts:125:18)
    at send (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/node_modules/.pnpm/ethers@6.13.4/node_modules/ethers/src.ts/contract/contract.ts:313:20)
    at Proxy.fund (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/node_modules/.pnpm/ethers@6.13.4/node_modules/ethers/src.ts/contract/contract.ts:352:16)
    at main (/Users/qiaopengjun/Code/solidity-code/OpenSpace-S3-code/Web3_tutorial/scripts/deployFundMe.js:31:20)



OpenSpace-S3-code/Web3_tutorial on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 1m 31.8s 
➜ npx hardhat run scripts/deployFundMe.js --network sepolia
contract deploying
contract has been deployed successfully, contract address is 0xeFBf864f30D92f96c716E96CaD9691FCe82A3fa2
Waiting for 5 confirmations
The contract 0xeFBf864f30D92f96c716E96CaD9691FCe82A3fa2 has already been verified on the block explorer. If you're trying to verify a partially verified contract, please use the --force flag.
https://sepolia.etherscan.io/address/0xeFBf864f30D92f96c716E96CaD9691FCe82A3fa2#code

2 accounts are 0x750Ea21c1e98CcED0d4557196B6f4a5974CCB6f5 and 0x632d05154f4E519357e2E42c5f36AB90E3389F27
Balance of the contract is 500000000000000000
Balance of the contract is 1000000000000000000
Balance of first account 0x750Ea21c1e98CcED0d4557196B6f4a5974CCB6f5 is 500000000000000000
Balance of second account 0x632d05154f4E519357e2E42c5f36AB90E3389F27 is 500000000000000000


npx hardhat deploy-fundme --network sepolia

npx hardhat interact-fundme --addr 0xeFBf864f30D92f96c716E96CaD9691FCe82A3fa2 --network sepolia

pnpm install -D hardhat-deploy

OpenSpace-S3-code/Web3_tutorial on  main [!] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base 
➜ npx hardhat test
Compiled 1 Solidity file successfully (evm target: paris).


  test fundme contract
    ✔ test if the owner is msg.sender (424ms)
    ✔ test if the datafeed is assigned correctly


  2 passing (430ms)
```

## 参考

- <https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol>
- <https://github.com/smartcontractkit/Web3_tutorial_Chinese>
- <https://sepolia.etherscan.io/address/0x38a1e0224dc1b50de2fde584eac4901058ad2602#code>
- <https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-verify>
- <https://sepolia.etherscan.io/address/0xeFBf864f30D92f96c716E96CaD9691FCe82A3fa2#code>
