// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract BenchEcrecover {
    event Verify(uint256 correctSignatures);

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
            address recoveredAddress = ecrecover(hash, v, r, s);
            if (recoveredAddress == addr) {
                ++correctSignatures;
            }
        }
        emit Verify(correctSignatures);
    }
}
