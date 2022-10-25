// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../Contracts/BenchEcrecover.sol";
import "../../lib/forge-std/src/Test.sol";

contract EcdsaOpsTest is Test {
    BenchEcrecover public ops;
    uint256 NUMBER = 8000;

    function setUp() public virtual {
        ops = new BenchEcrecover();
    }

    function test() public {
        verify();
    }

    function verify() public {
        bytes32 message = ethMessageHash("TEST");

        bytes
            memory sig = hex"bceab59162da5e511fb9c37fda207d443d05e438e5c843c57b2d5628580ce9216ffa0335834d8bb63d86fb42a8dd4d18f41bc3a301546e2c47aa1041c3a1823701";
        address addr = 0x999471bB43B9C9789050386F90C1Ad63DCa89106;

        recover(message, sig, addr);
    }

    function recover(
        bytes32 hash,
        bytes memory sig,
        address addr
    ) internal {
        bytes32 r;
        bytes32 s;
        uint8 v;

        // solium-disable-next-line security/no-inline-assembly
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }

        // Version of signature should be 27 or 28, but 0 and 1 are also possible versions
        if (v < 27) {
            v += 27;
        }

        ops.benchmarkEcrecover(hash, v, r, s, addr, NUMBER);
    }

    /**
     * @dev prefix a bytes32 value with "\x19Ethereum Signed Message:" and hash the result
     */
    function ethMessageHash(string memory message)
        internal
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    keccak256(abi.encodePacked(message))
                )
            );
    }
}
