// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract KeccakTest {
    event KeccakHash(bool);

    function testOneBlock(bytes[] calldata input) public {
        for (uint256 i; i < input.length; ++i) {
            keccak256(input[i]);
        }
        emit KeccakHash(true);
    }
}
