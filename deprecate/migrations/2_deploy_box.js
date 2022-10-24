
const { deploy } = require('truffle');

const EcdsaSecp256k1Ops = artifacts.require('EcdsaSecp256k1Ops');

module.exports = async function (deployer) {

  await deployer.deploy(EcdsaSecp256k1Ops);
  const dc = await EcdsaSecp256k1Ops.deployed();

  console.log("Contract Address: ", dc.address);
};

