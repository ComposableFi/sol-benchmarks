// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract SimpleVrsCacheEcrecover {
    event Verify(uint256 correctSignatures);
    mapping(bytes32 => address) vrsCaching;

    function benchmarkEcrecover(
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s,
        address addr,
        uint256 n
    ) public {
        uint256 correctSignatures;
        for (uint256 i; i < n; ++i) {
            bytes32 _vrs = keccak256(abi.encodePacked(v, r, s));
            if (vrsCaching[_vrs] == addr) {
                ++correctSignatures;
                continue;
            }
            address recoveredAddress = ecrecover(hash, v, r, s);
            if (recoveredAddress == addr) {
                ++correctSignatures;
                bytes32 newVrs = keccak256(abi.encodePacked(v, r, s));
                vrsCaching[newVrs] = addr;
            }
        }
        emit Verify(correctSignatures);
    }
}
