// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./Blake2b.sol";

contract Blake2bTest {
    using Blake2b for Blake2b.Instance;

    event Blake2bHash(bool);

    function testOneBlock(bytes[] calldata input, uint256[] calldata input_len)
        public
    {
        Blake2b.Instance memory instance = Blake2b.init(hex"", 64);
        for (uint256 i; i < input.length; ++i) {
            instance.finalize(input[i], input_len[i]);
        }
        emit Blake2bHash(true);
    }
}
