// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract EcdsaOps {
    using ECDSA for bytes32;
    event Verify(uint256 correctSignatures);

    function checkSignatures(
        bytes[] calldata signatures,
        address[] calldata addresses,
        string calldata message
    ) public {
        uint256 correctSignatures = 0;
        bytes32 msgHash = keccak256(abi.encode(message));
        bytes32 messageHash = msgHash.toEthSignedMessageHash();
        uint256 n = addresses.length;
        for (uint256 i; i < n; ++i) {
            address recoveredAddress = ECDSA.recover(
                messageHash,
                signatures[i]
            );
            if (recoveredAddress == addresses[i]) {
                correctSignatures++;
            }
        }
        emit Verify(correctSignatures);
    }
}
