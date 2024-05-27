const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const cresento = await ethers.getContractFactory("Cresento");
  const CRESENTO = await cresento.deploy();
  console.log("Cresento address:", CRESENTO.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
