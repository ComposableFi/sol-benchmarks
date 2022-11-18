import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import * as TestVectors from "./blake2-kat.json";

describe("KeccakTest", () => {
  async function hasherFixture() {
    const Hasher = await ethers.getContractFactory("KeccakTest");
    const hasher = await Hasher.deploy();
    return hasher;
  }

  describe("Benchmark KeccakTest", () => {
    it("keccak reference test vectors", async () => {
      const hasherContract = await loadFixture(hasherFixture);
      const inputArr: Buffer[] = [];
      for (var i in TestVectors) {
        const testCase = TestVectors[i];
        if (testCase.hash !== "blake2b" || testCase.key.length !== 0) {
          continue;
        }
        let input = Buffer.from(testCase.in, "hex");
        let input_length = input.length;
        // Pad with zeroes.
        // FIXME: this should not be needed once the library is finished.
        if (input_length === 0 || input_length % 128 !== 0) {
          input = Buffer.concat([
            input,
            Buffer.alloc(128 - (input_length % 128)),
          ]);
        }

        inputArr.push(input);
      }
      console.log("input: ", inputArr);
      const res = await hasherContract.testOneBlock(inputArr);
      const result = await res.wait();
      console.log(result);
      console.log(result.gasUsed.toString());
    });
  });
});
