import { ethers } from "hardhat";

async function main() {
  const Ops = await ethers.getContractFactory("EcdsaOps");
  const ops = await Ops.deploy();
  await ops.deployed();
  console.log("ecdsa operations contract deployed: ", ops.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
