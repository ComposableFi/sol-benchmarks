// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// import "elliptic-curve-solidity/contracts/EllipticCurve.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract EcdsaSecp256k1Ops {
    uint256 public constant GX =
        0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798;
    uint256 public constant GY =
        0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8;
    uint256 public constant AA = 0;
    uint256 public constant BB = 7;
    uint256 public constant PP =
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;

    // /// @notice Public Key derivation from private key
    // /// Warning: this is just an example. Do not expose your private key.
    // /// @param privKey The private key
    // /// @return (qx, qy) The Public Key
    // function derivePubKey(uint256 privKey)
    //     external
    //     pure
    //     returns (uint256, uint256)
    // {
    //     return EllipticCurve.ecMul(privKey, GX, GY, AA, PP);
    // }

    // function sign(bytes32 message, uint256 privKey) external pure {}
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

    // function verify(
    //     string calldata message,
    //     bytes calldata sig,
    //     address addr
    // ) external pure returns (bool) {
    //     bytes32 msgHex = ethMessageHash(message);
    //     return recover(msgHex, sig) == addr;
    // }

    // function recover(bytes32 hash, bytes memory sig)
    //     internal
    //     pure
    //     returns (address)
    // {
    //     bytes32 r;
    //     bytes32 s;
    //     uint8 v;

    //     // Check the signature length
    //     if (sig.length != 65) {
    //         return (address(0));
    //     }

    //     // Divide the signature in r, s and v variables
    //     // ecrecover takes the signature parameters, and the only way to get them
    //     // currently is to use assembly.
    //     // solium-disable-next-line security/no-inline-assembly
    //     assembly {
    //         r := mload(add(sig, 32))
    //         s := mload(add(sig, 64))
    //         v := byte(0, mload(add(sig, 96)))
    //     }

    //     // Version of signature should be 27 or 28, but 0 and 1 are also possible versions
    //     if (v < 27) {
    //         v += 27;
    //     }

    //     // If the version is correct return the signer address
    //     if (v != 27 && v != 28) {
    //         return (address(0));
    //     } else {
    //         // solium-disable-next-line arg-overflow
    //         return ecrecover(hash, v, r, s);
    //     }
    // }
}
