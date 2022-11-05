import web3 from "web3";
import { ethers } from "ethers";
const ethUtil = require("ethereumjs-util");
import fs from "fs";

const addresses: string[] = [];
// const sigs: string[] = [];
const v: number[] = [];
const r: string[] = [];
const s: string[] = [];

const main = async () => {
  const wallet = ethers.Wallet.createRandom();
  //   console.log(`Wallet Address: `, await wallet.getAddress());

  const messageToSign = "bridging is tough";
  const hash = web3.utils.soliditySha3(messageToSign);
  console.log(hash);
  if (!hash) return;
  const privateKey = wallet.privateKey;
  //   console.log(`Wallet Private Key: ${privateKey}`);

  await generateSignature(hash, privateKey);
  //   console.log(`Signature:          ${sig}`);
  addresses.push(wallet.address);
};

function generateSignature(dataToSign: string, privateKey: string) {
  const msg = Buffer.from(dataToSign.replace("0x", ""), "hex");
  const msgHash = ethUtil.hashPersonalMessage(msg);
  const pk = Buffer.from(privateKey.replace("0x", ""), "hex");
  const sig = ethUtil.ecsign(msgHash, pk);
  if (!sig.r || !sig.s) return;
  v.push(sig.v);
  r.push(ethers.utils.keccak256(sig.r));
  s.push(ethers.utils.keccak256(sig.s));
  //   return ethUtil.toRpcSig(sig.v, sig.r, sig.s);
}

const run = async () => {
  for (let i = 0; i < 667; i++) {
    await main();
  }
  const addr = JSON.stringify(addresses);
  const vss = JSON.stringify(v);
  const rss = JSON.stringify(r);
  const sss = JSON.stringify(s);
  fs.writeFile("addr.json", addr, "utf8", (err) => {
    if (err) {
      console.error(err);
    }
    console.log("JSON updated successfully");
  });
  fs.writeFile("vss.json", vss, "utf8", (err) => {
    if (err) {
      console.error(err);
    }
    console.log("JSON updated successfully");
  });
  fs.writeFile("rss.json", rss, "utf8", (err) => {
    if (err) {
      console.error(err);
    }
    console.log("JSON updated successfully");
  });
  fs.writeFile("sss.json", sss, "utf8", (err) => {
    if (err) {
      console.error(err);
    }
    console.log("JSON updated successfully");
  });
};

run();
