# Cross chain NFT

## 实操

```bash
mcd crosschain-nft
pnpm init
ls
touch StudyNotes.md
pnpm install -D hardhat
ls
npx hardhat init
c
pnpm install -D @openzeppelin/contracts
pnpm install -D @chainlink/contracts-ccip    
npx hardhat compile   
pnpm install --save-dev @nomicfoundation/hardhat-ethers ethers hardhat-deploy hardhat-deploy-ethers
pnpm install -D @chainlink/local
pnpm install -D @chainlink/env-enc   
npx hardhat deploy
```

## 参考

- <https://console.filebase.com/buckets>
- <https://github.com/smartcontractkit/chainlink-local>
