// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract ValidatorSetCacheEcrecover {
    event Verify(uint256 correctSignatures);
    struct ValidatorSet {
        uint256 id;
        bytes32 root;
        uint256 length;
    }
    mapping(bytes32 => ValidatorSet) verifiedValidatorSets;

    function benchmarkEcrecover(ValidatorSet calldata vset) public {
        uint256 verifiedValidators;
        bytes32 _vsetHash = keccak256(abi.encode(vset));
        if (
            keccak256(abi.encode(verifiedValidatorSets[_vsetHash])) ==
            keccak256(abi.encode(vset))
        ) {
            verifiedValidators = vset.length;
            emit Verify(verifiedValidators);
            return;
        }
        // verify each validator;
    }
}
