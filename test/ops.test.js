const ops = artifacts.require("EcdsaSecp256k1Ops");
const jsrsasign = require("jsrsasign");

contract("ops", () => {
  const charlen = 256;
  const ec = new jsrsasign.KJUR.crypto.ECDSA({ curve: "secp256k1" });

  beforeEach(async () => {
    opsContract = await ops.deployed();
  });

  it("Derive public key from private key", async () => {
    // generate a new key pair
    const keypair = ec.generateKeyPairHex();
    // pass the new private key to the contract
    var result = await opsContract.derivePubKey("0x".concat(keypair.ecprvhex));
    var hX = result[0].toString(16).slice(-charlen);
    var hY = result[1].toString(16).slice(-charlen);
    var hPub = "04" + hX + hY;
    console.log(hPub);
    console.log(keypair.ecpubhex);
    // test if both public key hex are identical
    assert.equal(hPub, keypair.ecpubhex);
  });
});
