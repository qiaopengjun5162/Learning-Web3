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
```
