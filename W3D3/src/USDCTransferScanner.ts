import { decodeEventLog, parseAbi, parseAbiItem } from 'viem';
import { publicClient } from './client';

const tokenContract = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";


async function getBlockNumber() {
    const blockNumber = await publicClient.getBlockNumber();
    return blockNumber;
}

async function getBalance() {
    const balance = await publicClient.getBalance({
        address: "0x4B16c5dE96EB2117bBE5fd171E4d203624B014aa",
    })
    return balance;
}

async function getEventFilter(fromBlock: bigint, toBlock: bigint) {
    const filter = await publicClient.createEventFilter({
        address: tokenContract,
        event: parseAbiItem('event Transfer(address indexed from, address indexed to, uint256 value)'),
        fromBlock: fromBlock,
        toBlock: toBlock,
        strict: true
    })
    return filter;
}


async function getTransferLogs(fromBlock: bigint, toBlock: bigint) {
    const logs = await publicClient.getLogs({
        address: tokenContract,
        event: parseAbiItem('event Transfer(address indexed, address indexed, uint256)'),
        //  *** Transfer(index_topic_1 address from, index_topic_2 address to, uint256 value)
        fromBlock: fromBlock,
        toBlock: toBlock
    });
    return logs;
}

function decodeTransferLog(log: any) {
    // const from = log.topics[1];
    // const to = log.topics[2];
    // const value = parseInt(log.data, 16) / 1e6; // USDC 有 6 位小数
    // const transactionHash = log.transactionHash;

    // console.log("log.topics: ", log.topics);
    const topics = decodeEventLog({
        abi: parseAbi(['event Transfer(address indexed from, address indexed to, uint256 value)']),
        data: log.data,
        topics: log.topics
    })

    // console.log("topics: ", topics);
    const from = topics.args.from;
    const to = topics.args.to;
    const value = topics.args.value;
    const transactionHash = log.transactionHash;

    return { from, to, value, transactionHash };
}

async function getTransaction() {
    const transaction = await publicClient.getTransaction({
        hash: '0x5c504ed432cb51138bcf09aa5e8a410dd4a1e204ef84bfed1be16dfba1b22060',
    });
    return transaction;
}

async function getTransactionCount() {
    const transactionCount = await publicClient.getTransactionCount({
        address: "0x4B16c5dE96EB2117bBE5fd171E4d203624B014aa",
    })
    return transactionCount;

}


async function main() {
    const balance = await getBalance();

    const latestBlockNumber = await getBlockNumber();
    const fromBlock = latestBlockNumber - BigInt(100);
    const toBlock = latestBlockNumber;
    const transactionCount = await getTransactionCount();


    console.log(`Fetching USDC transfer logs from block ${fromBlock} to ${toBlock}...`);

    const logs = await getTransferLogs(fromBlock, toBlock);
    // const filter = await getEventFilter(fromBlock, toBlock);
    // const logs = await publicClient.getFilterLogs({ filter })


    console.log(`最新区块号：${latestBlockNumber}`);

    console.log(`USDC 合约余额：${balance}`);

    console.log(`交易数量：${transactionCount}`);

    console.log(`找到 ${logs.length} 条转账记录`);

    console.log("___", logs[0]);



    console.log(`解码转账记录...`);

    const transfers = logs.map(decodeTransferLog);

    for (const transfer of transfers) {
        // console.log(`从 ${transfer.from} 转账给 ${transfer.to} ${transfer.value.toFixed(5)} USDC, 交易ID：${transfer.transactionHash}`);
        console.log(`从 ${transfer.from} 转账给 ${transfer.to} ${transfer.value} USDC, 交易ID：${transfer.transactionHash}`);
    }
}

main().catch(error => {
    console.error('Error:', error);
});
