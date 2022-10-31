import { Deployer } from "@matterlabs/hardhat-zksync-deploy";
import { Wallet, Provider, Contract } from "zksync-web3";
import * as hre from "hardhat";
import * as ethers from "ethers";

const msg = "bridging is tough";

const RICH_WALLET_PK =
  "0x47b2813817cc5683fca341b796c4f557ab254575d68bc08450000ccc16899963";

describe("ZK-ECDSAOpsTest", () => {
  const messageHash =
    "0x58115cb6135ae9d09153677de96b8e540ad4b2cde5aaafd52afc4141519ceda3";

  async function opsFixture(deployer: Deployer): Promise<Contract> {
    const artifact = await deployer.loadArtifact("EcdsaOps");
    return await deployer.deploy(artifact);
  }

  describe("Benchmark Ecrecover", () => {
    it("should recover 339 address from signature and msg", async () => {
      const provider = Provider.getDefaultProvider();
      const wallet = new Wallet(RICH_WALLET_PK, provider);
      const deployer = new Deployer(hre, wallet);
      const opsContract = await opsFixture(deployer);
      const addresses = [];
      const signatures = [];
      const NUMBER = 339;
      console.log(NUMBER);
      for (let i = 0; i < NUMBER; i++) {
        const signer = ethers.Wallet.createRandom();
        const signature = await signer.signMessage(
          ethers.utils.arrayify(
            ethers.utils.keccak256(
              ethers.utils.defaultAbiCoder.encode(["string"], [msg])
            )
          )
        );
        const address = await signer.getAddress();
        addresses.push(address);
        signatures.push(signature);
      }
      const res = await opsContract.checkSignatures(
        signatures,
        addresses,
        messageHash
      );
      const result = await res.wait();
      console.log(result);
      //   const block = await provider.getBlock(result.blockNumber);
      //   console.log(block);
      console.log("gas: ", result.gasUsed.toString());
    });
  });
});
