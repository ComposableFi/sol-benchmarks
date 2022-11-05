// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract NoCacheEcrecover {
    event Verify(uint256 correctSignatures);

    struct SigData {
        uint8 v;
        bytes32 r;
        bytes32 s;
        address addr;
    }

    function benchmarkEcrecover(
        bytes32 hash,
        SigData[] memory sigData,
        uint256 n
    ) public {
        uint256 correctSignatures;
        for (uint256 i; i < n; ++i) {
            address recoveredAddress = ecrecover(
                hash,
                sigData[i].v,
                sigData[i].r,
                sigData[i].s
            );
            if (recoveredAddress == sigData[i].addr) {
                ++correctSignatures;
            }
        }
        emit Verify(correctSignatures);
    }
}
