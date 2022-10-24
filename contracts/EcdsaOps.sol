// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract EcdsaOps {
    using ECDSA for bytes32;

    function checkSignatures(
        bytes[] calldata signatures,
        address[] calldata addresses,
        string calldata message
    ) public pure returns (uint256) {
        uint256 correctSignatures = 0;
        bytes32 msgHash = keccak256(abi.encode(message));
        bytes32 messageHash = msgHash.toEthSignedMessageHash();
        for (uint256 i = 0; i < addresses.length; i++) {
            address recoveredAddress = ECDSA.recover(
                messageHash,
                signatures[i]
            );
            if (recoveredAddress == addresses[i]) {
                correctSignatures++;
            }
        }
        return correctSignatures;
    }
}
