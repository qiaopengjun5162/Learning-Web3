// function deployFunction() {
//     console.log("this is a deploy function")
// }



// module.exports.default=deployFunction
// module.exports= async(hre) => {
//     const getNamedAccounts = hre.getNamedAccounts
//     const deployments = hre.deployments
//     console.log("this is a deploy function")
// }

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { firstAccount } = await getNamedAccounts();
    const { deploy } = deployments;
    console.log("Deploying contracts with account:", firstAccount);


    await deploy("FundMe", {
        from: firstAccount,
        args: [180],
        log: true,

    });
};

module.exports.tags = ["all", "fundme"]
