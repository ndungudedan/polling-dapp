const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

async function main() {

  const pollingContract = await ethers.getContractFactory("Polling");

  // deploy the contract
  const deployedPollingContract = await pollingContract.deploy();

  await deployedPollingContract.deployed();

  // print the address of the deployed contract
  console.log("Pollling Contract Address:", deployedPollingContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });