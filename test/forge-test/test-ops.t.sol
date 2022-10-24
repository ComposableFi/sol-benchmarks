// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../Contracts/EcdsaOps.sol";
import "../../lib/forge-std/src/Test.sol";

contract EcdsaOpsTest is Test {
    uint256 a;

    function setUp() public virtual {
        a = 10;
    }

    function testExample() public {
        assertEq(a, 10);
    }
}
