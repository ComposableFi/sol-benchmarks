const ops = artifacts.require("EcdsaSecp256k1Ops");
const jsrsasign = require("jsrsasign");

contract("ops", (accounts) => {
  const alg = "SHA256withECDSA";
  const msg = "bridging is tough";
  const curve = "secp256k1";
  const charlen = 256;

  const ec = new jsrsasign.KJUR.crypto.ECDSA({ curve: curve });
  const keypair = ec.generateKeyPairHex();
  const sig = new jsrsasign.KJUR.crypto.Signature({ alg: alg });
  sig.init({ d: keypair.ecprvhex, curve: curve });
  sig.updateString(msg);
  const sigHex = sig.sign();

  beforeEach(async () => {
    opsContract = await ops.deployed();
  });

  it("derives public key from private key", async () => {
    // generate a new key pair
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

  it("verifies ECDSA signature", async () => {
    var result = await opsContract.verify(msg, sigHex, accounts[0]);
    console.log(result);
  });
});
