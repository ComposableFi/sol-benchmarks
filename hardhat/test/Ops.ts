import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";

describe("ECDSAOps", () => {
  const msg = "bridging is tough";

  async function opsFixture() {
    const Ops = await ethers.getContractFactory("EcdsaOps");
    const ops = await Ops.deploy();

    return ops;
  }

  describe("Benchmark Ecrecover", () => {
    it("should recover all addresses from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 2;
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
        console.log(i);
        console.log(address);
        console.log(signature);
        addresses.push(address);
        signatures.push(signature);
      }
      const result = await opsContract.checkSignatures(
        signatures,
        addresses,
        msg
      );
      expect(result.toString()).to.equal(NUMBER.toString());
    });
  });
});
