require("@nomicfoundation/hardhat-toolbox");
// import * as dotenv from "dotenv";

// dotenv.config(); // load .env file
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  // defaultNetwork: "hardhat",
  solidity: "0.8.27",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,
      accounts: [process.env.SEPOLIA_PRIVATE_KEY]
    }
  }
};
