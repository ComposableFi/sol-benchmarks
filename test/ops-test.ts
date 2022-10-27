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

      const res = await opsContract.checkSignatures(
        signatures,
        addresses,
        messageHash
      );
      const result = await res.wait();
      console.log("gas", result.cumulativeGasUsed.toString());
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
      const res = await opsContract.checkSignatures(
        signatures,
        addresses,
        messageHash
      );
      const result = await res.wait();
      console.log("gas: ", result.gasUsed.toString());
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

        addresses.push(address);
        signatures.push(signature);
      }
      const res = await opsContract.checkSignatures(
        signatures,
        addresses,
        messageHash
      );
      const result = await res.wait();
      console.log("gas: ", result.gasUsed.toString());
      await expect(
        opsContract.checkSignatures(signatures, addresses, messageHash)
      )
        .to.emit(opsContract, "Verify")
        .withArgs(NUMBER);
    });
    it("should recover 4340 addresses from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 4340;
      console.log(NUMBER);
      for (let i = 0; i < NUMBER; i++) {
        // const signer = ethers.Wallet.createRandom();
        // const signature = await signer.signMessage(
        //   ethers.utils.arrayify(
        //     ethers.utils.keccak256(
        //       ethers.utils.defaultAbiCoder.encode(["string"], [msg])
        //     )
        //   )
        // );
        // const address = await signer.getAddress();
        addresses.push("0xC326701346c11BAD229f5A5D62861E438738B17b");
        signatures.push(
          "0x78467dd39b993bab0344ce2efe859605a21f429fa0f02b7a21cf3ce76d1867b471a1fc856e8dcb9344ff07a2d20601f37ee9c620b7a1a96671dfb53467121ceb1c"
        );
      }
      const res = await opsContract.checkSignatures(
        signatures,
        addresses,
        messageHash
      );
      const result = await res.wait();
      console.log("gas", result.gasUsed.toString());
    });
    it("should recover 4341 addresses from signature and msg", async () => {
      const opsContract = await loadFixture(opsFixture);
      const addresses = [];
      const signatures = [];
      const NUMBER = 4341;
      console.log(NUMBER);
      for (let i = 0; i < NUMBER; i++) {
        addresses.push("0xC326701346c11BAD229f5A5D62861E438738B17b");
        signatures.push(
          "0x78467dd39b993bab0344ce2efe859605a21f429fa0f02b7a21cf3ce76d1867b471a1fc856e8dcb9344ff07a2d20601f37ee9c620b7a1a96671dfb53467121ceb1c"
        );
      }
      const res = await opsContract.checkSignatures(
        signatures,
        addresses,
        messageHash
      );
      const result = await res.wait();
      console.log("gas: ", result.gasUsed.toString());
    });
  });
});
