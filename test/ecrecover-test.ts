import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";

describe("benchmark", () => {
  const msg = "bridging is tough";

  async function opsFixture() {
    const Ecrecover = await ethers.getContractFactory("NoCacheEcrecover");
    const ecrecover = await Ecrecover.deploy();
    return ecrecover;
  }

  describe("Ecrecover", () => {
    it("should recover 1 address from signature and msg", async () => {
      const ecrecover = await loadFixture(opsFixture);
      const signer = ethers.Wallet.createRandom();
      const signature = await signer.signMessage(
        ethers.utils.arrayify(
          ethers.utils.keccak256(
            ethers.utils.defaultAbiCoder.encode(["string"], [msg])
          )
        )
      );
      const splitSig = ethers.utils.splitSignature(signature);
      const sigData = [
        { v: splitSig.v, r: splitSig.r, s: splitSig.s, addr: signer.address },
      ];
      const hash = ethers.utils.hashMessage(msg);
      const response = await ecrecover.benchmarkEcrecover(hash, sigData, 1);
      const result = await response.wait();
      console.log(result);
      console.log(result.gasUsed.toString());
    });
    it("should recover 20 addresses from signature and msg", async () => {
      const ecrecover = await loadFixture(opsFixture);
      const NUMBER = 20;
      const sigData = [];
      for (let i = 0; i < NUMBER; i++) {
        const signer = ethers.Wallet.createRandom();
        const signature = await signer.signMessage(
          ethers.utils.arrayify(
            ethers.utils.keccak256(
              ethers.utils.defaultAbiCoder.encode(["string"], [msg])
            )
          )
        );
        const splitSig = ethers.utils.splitSignature(signature);
        sigData.push({
          v: splitSig.v,
          r: splitSig.r,
          s: splitSig.s,
          addr: signer.address,
        });
      }
      const hash = ethers.utils.hashMessage(msg);
      const response = await ecrecover.benchmarkEcrecover(
        hash,
        sigData,
        NUMBER
      );
      const result = await response.wait();
      console.log(result.gasUsed.toString());
    });
    it("should recover 667 addresses from signature and msg", async () => {
      const ecrecover = await loadFixture(opsFixture);
      const NUMBER = 667;
      const sigData = [];
      for (let i = 0; i < NUMBER; i++) {
        const signer = ethers.Wallet.createRandom();
        const signature = await signer.signMessage(
          ethers.utils.arrayify(
            ethers.utils.keccak256(
              ethers.utils.defaultAbiCoder.encode(["string"], [msg])
            )
          )
        );
        const splitSig = ethers.utils.splitSignature(signature);
        sigData.push({
          v: splitSig.v,
          r: splitSig.r,
          s: splitSig.s,
          addr: signer.address,
        });
      }
      const hash = ethers.utils.hashMessage(msg);
      const response = await ecrecover.benchmarkEcrecover(
        hash,
        sigData,
        NUMBER
      );
      const result = await response.wait();
      console.log(result.gasUsed.toString());
    });
    it("should recover 2000 addresses from signature and msg", async () => {
      const ecrecover = await loadFixture(opsFixture);
      const NUMBER = 2000;
      const sigData = [];
      for (let i = 0; i < NUMBER; i++) {
        const signer = ethers.Wallet.createRandom();
        const signature = await signer.signMessage(
          ethers.utils.arrayify(
            ethers.utils.keccak256(
              ethers.utils.defaultAbiCoder.encode(["string"], [msg])
            )
          )
        );
        const splitSig = ethers.utils.splitSignature(signature);
        sigData.push({
          v: splitSig.v,
          r: splitSig.r,
          s: splitSig.s,
          addr: signer.address,
        });
      }
      const hash = ethers.utils.hashMessage(msg);
      const response = await ecrecover.benchmarkEcrecover(
        hash,
        sigData,
        NUMBER
      );
      const result = await response.wait();
      console.log(result.gasUsed.toString());
    });
    it("should recover 4000 addresses from signature and msg", async () => {
      const ecrecover = await loadFixture(opsFixture);
      const NUMBER = 2000;
      const sigData = [];
      for (let i = 0; i < NUMBER; i++) {
        const signer = ethers.Wallet.createRandom();
        const signature = await signer.signMessage(
          ethers.utils.arrayify(
            ethers.utils.keccak256(
              ethers.utils.defaultAbiCoder.encode(["string"], [msg])
            )
          )
        );
        const splitSig = ethers.utils.splitSignature(signature);
        sigData.push({
          v: splitSig.v,
          r: splitSig.r,
          s: splitSig.s,
          addr: signer.address,
        });
      }
      const sigData2 = sigData;
      sigData2.push(...sigData);
      const hash = ethers.utils.hashMessage(msg);
      const response = await ecrecover.benchmarkEcrecover(
        hash,
        sigData2,
        NUMBER * 2
      );
      const result = await response.wait();
      console.log(result.gasUsed.toString());
    });
    it("should recover 4700 addresses from signature and msg", async () => {
      const ecrecover = await loadFixture(opsFixture);
      const NUMBER = 2350;
      const sigData = [];
      for (let i = 0; i < NUMBER; i++) {
        const signer = ethers.Wallet.createRandom();
        const signature = await signer.signMessage(
          ethers.utils.arrayify(
            ethers.utils.keccak256(
              ethers.utils.defaultAbiCoder.encode(["string"], [msg])
            )
          )
        );
        const splitSig = ethers.utils.splitSignature(signature);
        sigData.push({
          v: splitSig.v,
          r: splitSig.r,
          s: splitSig.s,
          addr: signer.address,
        });
      }
      const sigData2 = sigData;
      sigData2.push(...sigData);
      const hash = ethers.utils.hashMessage(msg);
      const response = await ecrecover.benchmarkEcrecover(
        hash,
        sigData2,
        NUMBER * 2
      );
      const result = await response.wait();
      console.log(result.gasUsed.toString());
    });
  });
});
