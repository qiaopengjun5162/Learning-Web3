# WETH

实现一个 WETH，将 ETH 包装成 ERC20

WETH (Wrapped ETH) 是 ETH 的包装版本。由于以太币本身并不符合 ERC20 标准，导致与其他代币之间的互操作性较弱，难以用于去中心化应用程序（dApps）。

本练习要求实现一个符合 ERC20 标准的 WETH ，它比普通的 ERC20 多了两个功能：存款和取款，通过这两个功能，WETH 可以 1:1 兑换ETH。
