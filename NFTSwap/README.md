# NFTSwap

一个零手续费的去中心化NFT交易所：NFTSwap。

设计逻辑
卖家：出售NFT的一方，可以挂单list、撤单revoke、修改价格update。
买家：购买NFT的一方，可以购买purchase。
订单：卖家发布的NFT链上订单，一个系列的同一tokenId最多存在一个订单，其中包含挂单价格price和持有人owner信息。当一个订单交易完成或被撤单后，其中信息清零。
