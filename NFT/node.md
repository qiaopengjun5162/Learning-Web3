# 学习笔记

## Deployment steps
1. 部署 ERC20 合约
2. 部署 ERC721 合约
3. 使用ERC20 合约地址作为初始化参数部署 NFTMarket 合约
4. 账户1 在 ERC20 合约上 mint token
5. 账户1 在 ERC721 合约上 safeMint NFT
6. 账户1 在 ERC721 合约上调用 setApprovalForAll 授权 NFTMarket 合约，参数为 NFTMarket 合约地址和 true
7. 账户1 在 NFTMarket 合约上调用 listNFT 挂单（上架 tokenId 为 0 的 NFT）
8. 账户1 在 ERC20 合约上调用 transfer 转移 10个 ERC20 token 给 账户2
9. 账户2 在 ERC20 合约上调用 approve 方法授权 NFTMarket 合约使用1个ERC20token，参数为 NFTMarket 合约地址 和数量 1,000,000,000,000,000,000
10. 账户2 在 NFTMarket 合约上调用 buyNFT 购买 tokenId 为 0 的 NFT
11. 查看账户1 和账户2 的 ERC20 和 ERC721 余额 （balanceOf）

## 合约地址
- 0x66A8D109a4a48C7d8d969bf687DF21aB0c21FeD0
- https://sepolia.etherscan.io/tx/0xb05e7c513e42dac7426cff4c55a2e2d93f1974c23bffd42fb59d353e2cca85c2
- https://sepolia.etherscan.io/tx/0x453196cc5fa3457f37b854163b4257624c4f7d2af7c85f5206b9b768e77d9f3a
- https://testnets.opensea.io/account
- https://app.pinata.cloud/
- https://docs.opensea.io/docs/metadata-standards
- https://img.learnblockchain.cn/space/banner/18602/h7ljMtGq668b998356db8.jpg