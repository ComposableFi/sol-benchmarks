// // SPDX-License-Identifier: MIT

// pragma solidity ^0.8.9;

// contract SimpleVrsCacheEcrecover {
//     event Verify(uint256 correctSignatures);
//     mapping(bytes32 => address) vrsCaching;
//     mapping(bytes32 => address[]) batchVrsCaching;

//     function benchmarkEcrecover(
//         bytes32 hash,
//         uint8[] calldata v,
//         bytes32[] calldata r,
//         bytes32[] calldata s,
//         address[] calldata addr,
//         uint256 n
//     ) public {
//         uint256 correctSignatures;
//         bytes32 _batchVrs = keccak256(abi.encodePacked(v, r, s));
//         if (
//             keccak256(abi.encodePacked(batchVrsCaching[_batchVrs])) ==
//             keccak256(abi.encodePacked(addr))
//         ) {
//             correctSignatures = addr.length - 1;
//             emit Verify(correctSignatures);
//             return;
//         }
//         for (uint256 i; i < n; ++i) {
//             bytes32 _vrs = keccak256(abi.encodePacked(v[i], r[i], s[i]));
//             if (vrsCaching[_vrs] == addr[i]) {
//                 ++correctSignatures;
//                 continue;
//             }
//             address recoveredAddress = ecrecover(hash, v[i], r[i], s[i]);
//             if (recoveredAddress == addr[i]) {
//                 ++correctSignatures;
//                 vrsCaching[keccak256(abi.encodePacked(v, r, s))] = addr[i];
//             }
//         }
//         if (correctSignatures == addr.length - 1) {
//             batchVrsCaching[keccak256(abi.encodePacked(v, r, s))] = addr;
//         }
//         emit Verify(correctSignatures);
//     }
// }
