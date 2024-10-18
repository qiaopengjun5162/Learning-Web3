const { DECIMAL, INITIAL_ANSWER, developmentChains } = require("../helper-hardhat-config")

module.exports = async ({ getNamedAccounts, deployments }) => {

    if (developmentChains.includes(network.name)) {
        const { firstAccount } = await getNamedAccounts()
        const { deploy } = deployments

        await deploy("MockV3Aggregator", {
            from: firstAccount,
            args: [DECIMAL, INITIAL_ANSWER],
            log: true
        })
    } else {
        console.log("environment is not local, mock contract deployment is skipped")
    }
}

module.exports.tags = ["all", "mock"]
