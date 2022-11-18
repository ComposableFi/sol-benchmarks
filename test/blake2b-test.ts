import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import * as TestVectors from "./blake2-kat.json";

describe("Blake2bTest", () => {
  async function hasherFixture() {
    const Hasher = await ethers.getContractFactory("Blake2bTest");
    const hasher = await Hasher.deploy();
    return hasher;
  }

  describe("Benchmark Blake2bTest", () => {
    it("blake2b reference test vectors", async () => {
      const hasherContract = await loadFixture(hasherFixture);
      const inputArr = [];
      const inputLenArr = [];
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
        inputLenArr.push(input_length);
      }
      let res = await hasherContract.testOneBlock(inputArr, inputLenArr);
      const result = await res.wait();
      console.log(result);
      console.log(result.gasUsed.toString());
    });
  });
});
