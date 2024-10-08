# Ballot

## 投票合约

用 Solidity 合约实现委托投票，以便自动和完全透明的投票计数。

投票合约
giveRightToVote
delegate
vote
winningProposal
winnerName

这段Solidity代码实现了一个投票合约。以下是代码的详细解释：

1. 定义了两个结构体，`Voter` 和 `Proposal`，分别用于表示投票者和提案。

2. 定义了合约的构造函数，接收一个提案名称数组作为参数。构造函数中，将合约的创建者设为chairperson，并将他的投票权重设为1。然后，将提案数组初始化为一系列带有名称和票数0的提案。

3. 定义了一个名为 `giveRightToVote` 的公共函数，用于赋予投票者投票权。该函数要求调用者是chairperson，且被赋予投票权的投票者尚未投票。

4. 定义了一个名为 `delegate` 的公共函数，用于投票者将投票权委托给其他人。该函数要求调用者具有投票权，尚未投票，且不能自我委托。在委托过程中，会检查委托链中是否存在循环。

5. 定义了一个名为 `vote` 的公共函数，用于投票者对提案进行投票。该函数要求调用者具有投票权，尚未投票。

6. 定义了一个名为 `winningProposal` 的公共视图函数，用于计算得票最多的提案的索引。

7. 定义了一个名为 `winnerName` 的公共函数，用于获取得票最多的提案的名称。

注意事项：

1. 合约中的所有函数都使用了 `require` 语句来检查条件是否满足，如果不满足则抛出异常。

2. 合约中的变量都使用了 `storage` 关键字，表示它们会被存储在区块链上。

3. 合约中的函数都使用了 `external` 关键字，表示它们只能被外部调用。

4. 合约中的函数都使用了 `public` 关键字，表示它们可以被任何人调用。

为投票过程添加时间限制。设置一个开始时间和结束时间来控制投票的时间窗口。用户只能在投票周期内进行投票。
允许投票权重的设置。投票权重可以由合约所有者设置，默认每个选民的权重为1。

## 参考

- <https://www.devoven.com/encoding/string-to-bytes32>
