const ops = artifacts.require("EcdsaSecp256k1Ops");
const { ethers } = require("ethers");
const jsrsasign = require("jsrsasign");
// const addresses = require("../addresses.json");
// const signatures = require("../signatures.json");
const fs = require("fs");
const { assert } = require("console");

contract("ops", (accounts) => {
  // const alg = "SHA256withECDSA";
  const msg = "bridging is tough";
  // const curve = "secp256k1";
  // const charlen = 256;

  // const ec = new jsrsasign.KJUR.crypto.ECDSA({ curve: curve });
  // const sig = new jsrsasign.KJUR.crypto.Signature({ alg: alg });
  // sig.init({ d: keypair.ecprvhex, curve: curve });
  // sig.updateString(msg);
  // const sigHex = sig.sign();

  beforeEach(async () => {
    opsContract = await ops.deployed();
  });

  //   it("derives public key from private key", async () => {
  //     // generate a new key pair
  //     // pass the new private key to the contract
  //     var result = await opsContract.derivePubKey("0x".concat(keypair.ecprvhex));
  //     var hX = result[0].toString(16).slice(-charlen);
  //     var hY = result[1].toString(16).slice(-charlen);
  //     var hPub = "04" + hX + hY;
  //     console.log(hPub);
  //     console.log(keypair.ecpubhex);
  //     // test if both public key hex are identical
  //     assert.equal(hPub, keypair.ecpubhex);
  //   });

  //   it("verifies ECDSA signature", async () => {
  //     var result = await opsContract.verify(msg, sigHex, accounts[0]);
  //     console.log(result);
  //   });
  it("recovers all addresses from signature and msg", async () => {
    const addresses = [];
    const signatures = [];
    const NUMBER = 2290;
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
      console.log(address);
      console.log(signature);
      addresses.push(address);
      signatures.push(signature);
    }
    const result = await opsContract.checkSignatures.estimateGas(
      signatures,
      addresses,
      msg
    );
    console.log(result.toString());
  });
});

// for (let i = 0; i < 4000; i++) {
//   const keypair = ec.generateKeyPairHex();
//   const signer = new ethers.Wallet(keypair.ecprvhex);
//   const signature = await signer.signMessage(msg);
//   const address = await signer.getAddress();
//   console.log(address);
//   console.log(signature);
//   addresses.push(address);
//   signatures.push(signature);
// }

// const a = JSON.stringify(addresses);
// const s = JSON.stringify(signatures);
// fs.writeFile("addresses.json", a, "utf8", (err) => {
//   if (err) {
//     console.error(err);
//   }
//   console.log("JSON updated successfully");
// });
// fs.writeFile("signatures.json", s, "utf8", (err) => {
//   if (err) {
//     console.error(err);
//   }
//   console.log("JSON updated successfully");
// });
