// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.17;

// import "../../Contracts/EcdsaOps.sol";
// import "../../lib/forge-std/src/Test.sol";

// contract EcdsaOpsTest is Test {
//     EcdsaOps public ops;

//     function setUp() public virtual {
//         ops = new EcdsaOps();
//     }

//     function test1Address() public {
//         // address[] calldata addr = [0x9B2a55aA202F3b1F7dC90BFa6DB7e0A94BD21208];
//         // bytes calldata signature = bytes(
//         //     "46760147ffaee84a87a0bf89054513e4151c3bf051078bba4a1877ba6810938d134f5ebaac01cc6e17fc9591f65e730e77d0c513fbba9d7eb4eac5ffd4af45e71c"
//         // );
//         // bytes32 messageHash = keccak256(abi.encodePacked("bridging is tough"));
//         // ops.checkSignatures([signature], addr, messageHash);
//         address[] memory addr = new address[](1);
//         addr[0] = 0x999471bB43B9C9789050386F90C1Ad63DCa89106;
//         bytes[] memory sig = new bytes[](1);
//         sig[
//             0
//         ] = hex"bceab59162da5e511fb9c37fda207d443d05e438e5c843c57b2d5628580ce9216ffa0335834d8bb63d86fb42a8dd4d18f41bc3a301546e2c47aa1041c3a1823701";
//         bytes32 messageHash = ethMessageHash("TEST");
//         ops.checkSignatures(sig, addr, messageHash);
//     }

//     function ethMessageHash(string memory message)
//         internal
//         pure
//         returns (bytes32)
//     {
//         return
//             keccak256(
//                 abi.encodePacked(
//                     "\x19Ethereum Signed Message:\n32",
//                     keccak256(abi.encodePacked(message))
//                 )
//             );
//     }
// }
