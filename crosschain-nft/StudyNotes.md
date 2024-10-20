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
npx env-enc set-pw   
npx env-enc set   
npx env-enc view  

OpenSpace-S3-code/crosschain-nft on  main [✘!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 29.1s 
➜ npx hardhat deploy --network sepolia --tags sourceChain
Nothing to compile
Deploying the nft contract
deploying "MyToken" (tx: 0x6068e8f52886a7a5139fa9f27310353b831477cc1eded377270d2ee380c2ab90)...: deployed at 0x2c90C69C8074762927Fe9F2a0851Afbd8500e863 with 2626208 gas
MyToken is deployed!
non local environment: source chain router: 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59, link token: 0x779877A7B0D9E8603169DdbD7836e478b4624789
NFT address: 0x2c90C69C8074762927Fe9F2a0851Afbd8500e863
deploying the lmn pool
deploying "NFTPoolLockAndRelease" (tx: 0x8640a2d0434d36dd49967b5da442c5874ce777402f3e61f7f116b6669d2dab03)...: deployed at 0x040a9da2c423e9e4BEb118813d41fF20379F6B6B with 2559460 gas
lmn pool deployed


OpenSpace-S3-code/crosschain-nft on  main [✘!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 33.1s 
➜ npx hardhat deploy --network amoy --tags destChain              
Nothing to compile
deploying wrapped NFT on destination chain
deploying "WrappedNFT" (tx: 0xae161b0835be52d329f01cae4ce46fd969c92630b35e2559672c9a684d06d68d)...: deployed at 0x0660c412bf2aca856ee119cEfdD155b24595a6CE with 2637808 gas
deployed wrapped nft
get the parameters: 0x9C32fCB86BF0f4a1A8921a9Fe46de3198bb884B2, 0x0Fd9e8d3aF1aaee056EB9e802c3A762a667b1904, 0x0660c412bf2aca856ee119cEfdD155b24595a6CE
deploying nftPoolBurnAndMint
deploying "NFTPoolBurnAndMint" (tx: 0x4a441cc30cdca1c2396947928193f204ea45322dc6bffd0b0f01e3f09667918e)...: deployed at 0x71c5B6424191c9F9751fdFeAbcbc7b5C7c292656 with 2484847 gas
nftPoolBurnAndMint deployed


OpenSpace-S3-code/crosschain-nft on  main [✘!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 24.2s 
➜ npx hardhat check-nft --network sepolia           
checking status of ERC-721
there are 0 tokens under the collection

OpenSpace-S3-code/crosschain-nft on  main [?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 3.5s 
➜ npx hardhat mint-nft --network sepolia 
nft address is 0x2c90C69C8074762927Fe9F2a0851Afbd8500e863
minting NFT...
NFT minted, tokenId is 0

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 1m 32.6s 
➜ npx hardhat check-nft --network sepolia
checking status of ERC-721
there are 1 tokens under the collection
TokenId: 0, Owner is 0x750Ea21c1e98CcED0d4557196B6f4a5974CCB6f5

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 3.3s 
➜ npx hardhat lock-and-cross --tokenid 0 --network sepolia
deployer is 0x750Ea21c1e98CcED0d4557196B6f4a5974CCB6f5
NFTPoolBurnAndMint address on destination chain is 0x71c5B6424191c9F9751fdFeAbcbc7b5C7c292656
destination chain selector is 16281711391670634445
balance before: 0
balance after: 10000000000000000000
approve successfully
0, 0x750Ea21c1e98CcED0d4557196B6f4a5974CCB6f5, 16281711391670634445, 0x71c5B6424191c9F9751fdFeAbcbc7b5C7c292656
NFT locked and crossed, transaction hash is 0x7e367948bd029fe7eb230e4533d1082a1f5cf4f686508a5db18c2eeae294f83b

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 3.4s 
➜ npx hardhat check-nft --network sepolia                 
checking status of ERC-721
there are 1 tokens under the collection
TokenId: 0, Owner is 0x040a9da2c423e9e4BEb118813d41fF20379F6B6B

npx hardhat burn-and-cross --network amoy --tokenid 0
npx hardhat check-wrapped-nft --tokenid 0 --network amoy

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 5.2s 
➜ npx hardhat check-wnft --network amoy                
checking status of ERC-721
there are 1 tokens under the collection
TokenId: 0, Owner is 0x750Ea21c1e98CcED0d4557196B6f4a5974CCB6f5

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 24.7s 
➜ npx hardhat burn-and-cross --network amoy --tokenid 0
transferring 10 LINK token to NFTPoolBurnAndMint contract
NFT burned and crossed with txhash 0x95332a9d7e3c6b1a415ea5d84f5ed7401f623d05303313893400b485a8010ca8

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 24.7s 
➜ npx hardhat burn-and-cross --network amoy --tokenid 0
transferring 10 LINK token to NFTPoolBurnAndMint contract
NFT burned and crossed with txhash 0x95332a9d7e3c6b1a415ea5d84f5ed7401f623d05303313893400b485a8010ca8

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 46.5s 
➜ npx hardhat check-nft --network sepolia              
checking status of ERC-721
there are 1 tokens under the collection
TokenId: 0, Owner is 0x040a9da2c423e9e4BEb118813d41fF20379F6B6B

OpenSpace-S3-code/crosschain-nft on  main [!?] is 📦 1.0.0 via ⬢ v22.1.0 via 🅒 base took 3.3s 
➜ npx hardhat check-nft --network sepolia
checking status of ERC-721
there are 1 tokens under the collection
TokenId: 0, Owner is 0x750Ea21c1e98CcED0d4557196B6f4a5974CCB6f5

```

## 参考

- <https://console.filebase.com/buckets>
- <https://github.com/smartcontractkit/chainlink-local>
- <https://ccip.chain.link/#/side-drawer/msg/0xafb689e029b60b41cf730d8650d138731b5daa5b8fb4eeb1782aeaa50737498b>
- <https://ccip.chain.link/#/side-drawer/msg/0x728f26fecd0beb0384e5773033f8591b77d11f6897a3947129960155a9001721>
- <https://github.com/smartcontractkit/Web3_tutorial_Chinese/tree/main>
