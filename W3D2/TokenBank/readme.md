# TokenBank

编写一个 TokenBank 合约，可以将自己的 Token 存入到 TokenBank， 和从 TokenBank 取出。

TokenBank 有两个方法：

deposit() : 需要记录每个地址的存入数量；
withdraw（）: 用户可以提取自己的之前存入的 token。

修改 TokenBank 存款合约 ,添加一个函数 permitDeposit 以支持离线签名授权（permit）进行存款。
