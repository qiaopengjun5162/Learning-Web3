const { ethers } = require("hardhat")
const { assert } = require("chai")

describe("test fundme contract", async function () {
    it("test if the owner is msg.sender", async function () {
        const [firstAccount] = await ethers.getSigners()
        const fundMeFactory = await ethers.getContractFactory("FundMe")
        const fundMe = await fundMeFactory.deploy(180)
        await fundMe.waitForDeployment()
        assert.equal((await fundMe.owner()), firstAccount.address)
    })

    // it("test if the datafeed is assigned correctly", async function () {
    //     await fundMe.waitForDeployment()
    //     assert.equal((await fundMe.dataFeed()), mockV3Aggregator.address)
    // })
})
