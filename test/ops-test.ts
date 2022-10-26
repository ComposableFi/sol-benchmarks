import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";

describe("ECDSAOpsTest", () => {
  const msg = "bridging is tough";
  const messageHash =
    "0x58115cb6135ae9d09153677de96b8e540ad4b2cde5aaafd52afc4141519ceda3";

  async function opsFixture() {
    const Ops = await ethers.getContractFactory("EcdsaOps");
    const ops = await Ops.deploy();
    return ops;
  }

  describe("Benchmark Ecrecover", () => {
    it("should recover 1 address from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 1;
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

      await expect(
        opsContract.checkSignatures(signatures, addresses, messageHash)
      )
        .to.emit(opsContract, "Verify")
        .withArgs(NUMBER);
    });
    it("should recover 2 addresses from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 2;
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
      await expect(
        opsContract.checkSignatures(signatures, addresses, messageHash)
      )
        .to.emit(opsContract, "Verify")
        .withArgs(NUMBER);
    });
    it("should recover 20 addresses from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 20;
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
        // console.log(`${i}` + " address: ", address);
        // console.log("signature: ", signature);
        addresses.push(address);
        signatures.push(signature);
      }
      await expect(
        opsContract.checkSignatures(signatures, addresses, messageHash)
      )
        .to.emit(opsContract, "Verify")
        .withArgs(NUMBER);
    });
    it("should recover 152 addresses from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 152;
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
      await expect(
        opsContract.checkSignatures(signatures, addresses, messageHash)
      )
        .to.emit(opsContract, "Verify")
        .withArgs(NUMBER);
    });
    it("should recover 153 addresses from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 153;
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
      await expect(
        opsContract.checkSignatures(signatures, addresses, messageHash)
      )
        .to.emit(opsContract, "Verify")
        .withArgs(NUMBER);
    });
  });
});
