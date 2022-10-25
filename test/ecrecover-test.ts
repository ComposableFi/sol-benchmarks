import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";

describe("benchmark", () => {
  async function opsFixture() {
    const Ecrecover = await ethers.getContractFactory("BenchEcrecover");
    const ecrecover = await Ecrecover.deploy();
    return ecrecover;
  }

  describe("Ecrecover", () => {
    it("should recover 8129 addresses from signature and msg", async () => {
      const ecrecover = await loadFixture(opsFixture);
      const NUMBER = 8129;
      const hash =
        "0x1db2807a7ef74eb2555abb27f4cbd68574a7f163b570a7fc016fd3b8a9a04a83";
      const v = 28;
      const r =
        "0xbceab59162da5e511fb9c37fda207d443d05e438e5c843c57b2d5628580ce921";
      const s =
        "0x6ffa0335834d8bb63d86fb42a8dd4d18f41bc3a301546e2c47aa1041c3a18237";
      const addr = "0x999471bB43B9C9789050386F90C1Ad63DCa89106";
      await expect(ecrecover.benchmarkEcrecover(hash, v, r, s, addr, NUMBER))
        .to.emit(ecrecover, "Verify")
        .withArgs(NUMBER);
    });
  });
});
