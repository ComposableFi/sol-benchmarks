import { utils, Wallet } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the EcdsaOps contract`);

  // Initialize the wallet.
  const wallet = new Wallet(String(process.env.PRIVATE_KEY));
  console.log(process.env.PRIVATE_KEY);
  // Create deployer object and load the artifact of the contract we want to deploy.
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("EcdsaOps");
  console.log(await deployer.zkWallet.getAddress());
  //   //   // Deposit some funds to L2 in order to be able to perform L2 transactions.
  //   //   const depositAmount = ethers.utils.parseEther("0.15");
  //   //   const depositHandle = await deployer.zkWallet.deposit({
  //   //     to: deployer.zkWallet.address,
  //   //     token: utils.ETH_ADDRESS,
  //   //     amount: depositAmount,
  //   //   });
  //   //   // Wait until the deposit is processed on zkSync
  //   //   await depositHandle.wait();

  //   console.log("Deploying...");
  //   // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  //   const opsContract = await deployer.deploy(artifact);
  //   console.log("Deployed!");
  //   // Show the contract info.
  //   const contractAddress = opsContract.address;
  //   console.log(`${artifact.contractName} was deployed to ${contractAddress}`);

  //   // Call the deployed contract.
  //   //   const greetingFromContract = await opsContract.greet();
  //   const messageHash =
  //     "0x58115cb6135ae9d09153677de96b8e540ad4b2cde5aaafd52afc4141519ceda3";

  //   const addresses = [];
  //   const signatures = [];
  //   const NUMBER = 20;
  //   console.log(NUMBER);
  //   for (let i = 0; i < NUMBER; i++) {
  //     addresses.push("0xC326701346c11BAD229f5A5D62861E438738B17b");
  //     signatures.push(
  //       "0x78467dd39b993bab0344ce2efe859605a21f429fa0f02b7a21cf3ce76d1867b471a1fc856e8dcb9344ff07a2d20601f37ee9c620b7a1a96671dfb53467121ceb1c"
  //     );
  //   }
  //   const res = await opsContract.checkSignatures(
  //     signatures,
  //     addresses,
  //     messageHash
  //   );
  //   const result = await res.wait();
  //   console.log(result);
  //   //   const block = await provider.getBlock(result.blockNumber);
  //   //   console.log(block);
  //   console.log("gas: ", result.gasUsed.toString());
}
