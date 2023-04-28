// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {console} from "forge-std/console.sol";

import "./BN256G2.sol";

contract BLS {
    // Field order
    uint256 constant  N =
        21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Negated genarator of G2
    uint256 constant nG2x1 =
        11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant nG2x0 =
        10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant nG2y1 =
        17805874995975841540914202342111839520379459829704422454583296818431106115052;
    uint256 constant nG2y0 =
        13392588948715843804641432497768002650278120570034223513918757245338268106653;

    uint256 constant FIELD_MASK =
        0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    uint256 constant SIGN_MASK =
        0x8000000000000000000000000000000000000000000000000000000000000000;
    uint256 constant ODD_NUM =
        0x8000000000000000000000000000000000000000000000000000000000000000;

    function verifySinglePK(
        uint256[2] memory signature,
        PublicKey memory pubkey,
        uint256[2] memory message
    ) public view returns (bool) {
        uint256[12] memory input = [
            signature[0],
            signature[1],
            nG2x1,
            nG2x0,
            nG2y1,
            nG2y0,
            message[0],
            message[1],
            pubkey.y_real,
            pubkey.x_real,
            pubkey.y_imaginary,
            pubkey.x_imaginary
        ];
        uint256[1] memory out;
        bool success;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            success := staticcall(sub(gas(), 2000), 8, input, 384, out, 0x20)
        }
        require(success, "Could not verify");
        return out[0] != 0;
    }
    function verifySingle(
        uint256[2] memory signature,
        uint256[4] memory pubkey,
        uint256[2] memory message
    ) public view returns (bool) {
        uint256[12] memory input = [
            signature[0],
            signature[1],
            nG2x1,
            nG2x0,
            nG2y1,
            nG2y0,
            message[0],
            message[1],
            pubkey[1],
            pubkey[0],
            pubkey[3],
            pubkey[2]
        ];
        uint256[1] memory out;
        bool success;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            success := staticcall(sub(gas(), 2000), 8, input, 384, out, 0x20)
        }
        require(success, "Could not verify");
        return out[0] != 0;
    }

    function verifyMultiple(
        uint256[2] memory signature,
        uint256[4][] memory pubkeys,
        uint256[2][] memory messages
    ) internal view returns (bool) {
        uint256 size = pubkeys.length;
        require(size > 0, "BLS: number of public key is zero");
        require(
            size == messages.length,
            "BLS: number of public keys and messages must be equal"
        );
        uint256 inputSize = (size + 1) * 6;
        uint256[] memory input = new uint256[](inputSize);
        input[0] = signature[0];
        input[1] = signature[1];
        input[2] = nG2x1;
        input[3] = nG2x0;
        input[4] = nG2y1;
        input[5] = nG2y0;
        for (uint256 i = 0; i < size; i++) {
            input[i * 6 + 6] = messages[i][0];
            input[i * 6 + 7] = messages[i][1];
            input[i * 6 + 8] = pubkeys[i][1];
            input[i * 6 + 9] = pubkeys[i][0];
            input[i * 6 + 10] = pubkeys[i][3];
            input[i * 6 + 11] = pubkeys[i][2];
        }
        uint256[1] memory out;
        bool success;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            success := staticcall(
                sub(gas(), 2000),
                8,
                add(input, 0x20),
                mul(inputSize, 0x20),
                out,
                0x20
            )
        }
        require(success, "Could not verify");
        return out[0] != 0;
    }

    function hashToPoint(bytes memory data)
        public
        view
        returns (uint256[2] memory p)
    {
        return mapToPoint(keccak256(data));
    }

    function mapToPoint(bytes32 _x) public view returns (uint256[2] memory p) {
        uint256 x = uint256(_x) % N;
        uint256 y;
        bool found = false;
        while (true) {
            y = mulmod(x, x, N);
            y = mulmod(y, x, N);
            y = addmod(y, 3, N);
            (y, found) = sqrt(y);
            if (found) {
                p[0] = x;
                p[1] = y;
                break;
            }
            x = addmod(x, 1, N);
        }
    }

    event Debug(uint256 y0, uint256 y1, uint256 m0, uint256 m1);

    function mapToPointWithHelp(
        uint256[2] memory _x,
        uint256[2] memory expected_roots
    ) public pure returns (uint256[2] memory px, uint256[2] memory py) {
        uint256 x0 = uint256(_x[0]) % N;
        uint256 x1 = uint256(_x[1]) % N;

        uint256 y0;
        uint256 y1;
        uint256 y0tmp;
        uint256 m0;
        uint256 m1;

        y0 = addmod(mulmod(x0, x0, N), mulmod(N - x1, x1, N), N);
        y1 = mulmod(2 * x0, x1, N);
        y0tmp = y0;
        y0 = addmod(mulmod(x0, y0, N), mulmod(N - x1, y1, N), N);
        y1 = addmod(mulmod(x0, y1, N), mulmod(x1, y0tmp, N), N);
        y0 = addmod(
            y0,
            19485874751759354771024239261021720505790618469301721065564631296452457478373,
            N
        );
        y1 = addmod(
            y1,
            266929791119991161246907387137283842545076965332900288569378510910307636690,
            N
        );
        m0 = addmod(
            mulmod(expected_roots[0], expected_roots[0], N),
            mulmod(N - expected_roots[1], expected_roots[1], N),
            N
        );
        m1 = mulmod(2 * expected_roots[0], expected_roots[1], N);
        if (m0 == y0 && m1 == y1) {
            px[0] = x0;
            px[1] = x1;
            py[0] = expected_roots[0];
            py[1] = expected_roots[1];
        } else {
            revert("Wrong expected root.");
        }
    }

    function isValidPublicKey(uint256[4] memory publicKey)
        internal
        pure
        returns (bool)
    {
        if (
            (publicKey[0] >= N) ||
            (publicKey[1] >= N) ||
            (publicKey[2] >= N || (publicKey[3] >= N))
        ) {
            return false;
        } else {
            return isOnCurveG2(publicKey);
        }
    }

    function isValidSignature(uint256[2] memory signature)
        internal
        pure
        returns (bool)
    {
        if ((signature[0] >= N) || (signature[1] >= N)) {
            return false;
        } else {
            return isOnCurveG1(signature);
        }
    }

    function pubkeyToUncompresed(
        uint256[2] memory compressed,
        uint256[2] memory y
    ) internal pure returns (uint256[4] memory uncompressed) {
        uint256 desicion = compressed[0] & SIGN_MASK;
        require(
            desicion == ODD_NUM || y[0] & 1 != 1,
            "BLS: bad y coordinate for uncompressing key"
        );
        uncompressed[0] = compressed[0] & FIELD_MASK;
        uncompressed[1] = compressed[1];
        uncompressed[2] = y[0];
        uncompressed[3] = y[1];
    }

    function signatureToUncompresed(uint256 compressed, uint256 y)
        internal
        pure
        returns (uint256[2] memory uncompressed)
    {
        uint256 desicion = compressed & SIGN_MASK;
        require(
            desicion == ODD_NUM || y & 1 != 1,
            "BLS: bad y coordinate for uncompressing key"
        );
        return [compressed & FIELD_MASK, y];
    }

    function isValidCompressedPublicKey(uint256[2] memory publicKey)
        internal
        view
        returns (bool)
    {
        uint256 x0 = publicKey[0] & FIELD_MASK;
        uint256 x1 = publicKey[1];
        if ((x0 >= N) || (x1 >= N)) {
            return false;
        } else if ((x0 == 0) && (x1 == 0)) {
            return false;
        } else {
            return isOnCurveG2([x0, x1]);
        }
    }

    function isValidCompressedSignature(uint256 signature)
        internal
        view
        returns (bool)
    {
        uint256 x = signature & FIELD_MASK;
        if (x >= N) {
            return false;
        } else if (x == 0) {
            return false;
        }
        return isOnCurveG1(x);
    }

    function isOnCurveG1(uint256[2] memory point)
        internal
        pure
        returns (bool _isOnCurve)
    {
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let t0 := mload(point)
            let t1 := mload(add(point, 32))
            let t2 := mulmod(t0, t0, N)
            t2 := mulmod(t2, t0, N)
            t2 := addmod(t2, 3, N)
            t1 := mulmod(t1, t1, N)
            _isOnCurve := eq(t1, t2)
        }
    }

    function isOnCurveG1(uint256 x) internal view returns (bool _isOnCurve) {
        bool callSuccess;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let t0 := x
            let t1 := mulmod(t0, t0, N)
            t1 := mulmod(t1, t0, N)
            t1 := addmod(t1, 3, N)

            let freemem := mload(0x40)
            mstore(freemem, 0x20)
            mstore(add(freemem, 0x20), 0x20)
            mstore(add(freemem, 0x40), 0x20)
            mstore(add(freemem, 0x60), t1)
            // (N - 1) / 2 = 0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            mstore(
                add(freemem, 0x80),
                0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            )
            // N = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            mstore(
                add(freemem, 0xA0),
                0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            )
            callSuccess := staticcall(
                sub(gas(), 2000),
                5,
                freemem,
                0xC0,
                freemem,
                0x20
            )
            _isOnCurve := eq(1, mload(freemem))
        }
    }

    function isOnCurveG2(uint256[4] memory point)
        internal
        pure
        returns (bool _isOnCurve)
    {
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            // x0, x1
            let t0 := mload(point)
            let t1 := mload(add(point, 32))
            // x0 ^ 2
            let t2 := mulmod(t0, t0, N)
            // x1 ^ 2
            let t3 := mulmod(t1, t1, N)
            // 3 * x0 ^ 2
            let t4 := add(add(t2, t2), t2)
            // 3 * x1 ^ 2
            let t5 := addmod(add(t3, t3), t3, N)
            // x0 * (x0 ^ 2 - 3 * x1 ^ 2)
            t2 := mulmod(add(t2, sub(N, t5)), t0, N)
            // x1 * (3 * x0 ^ 2 - x1 ^ 2)
            t3 := mulmod(add(t4, sub(N, t3)), t1, N)

            // x ^ 3 + b
            t0 := addmod(
                t2,
                0x2b149d40ceb8aaae81be18991be06ac3b5b4c5e559dbefa33267e6dc24a138e5,
                N
            )
            t1 := addmod(
                t3,
                0x009713b03af0fed4cd2cafadeed8fdf4a74fa084e52d1852e4a2bd0685c315d2,
                N
            )

            // y0, y1
            t2 := mload(add(point, 64))
            t3 := mload(add(point, 96))
            // y ^ 2
            t4 := mulmod(addmod(t2, t3, N), addmod(t2, sub(N, t3), N), N)
            t3 := mulmod(shl(1, t2), t3, N)

            // y ^ 2 == x ^ 3 + b
            _isOnCurve := and(eq(t0, t4), eq(t1, t3))
        }
    }

    function isOnCurveG2(uint256[2] memory x)
        internal
        view
        returns (bool _isOnCurve)
    {
        bool callSuccess;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            // x0, x1
            let t0 := mload(add(x, 0))
            let t1 := mload(add(x, 32))
            // x0 ^ 2
            let t2 := mulmod(t0, t0, N)
            // x1 ^ 2
            let t3 := mulmod(t1, t1, N)
            // 3 * x0 ^ 2
            let t4 := add(add(t2, t2), t2)
            // 3 * x1 ^ 2
            let t5 := addmod(add(t3, t3), t3, N)
            // x0 * (x0 ^ 2 - 3 * x1 ^ 2)
            t2 := mulmod(add(t2, sub(N, t5)), t0, N)
            // x1 * (3 * x0 ^ 2 - x1 ^ 2)
            t3 := mulmod(add(t4, sub(N, t3)), t1, N)
            // x ^ 3 + b
            t0 := add(
                t2,
                0x2b149d40ceb8aaae81be18991be06ac3b5b4c5e559dbefa33267e6dc24a138e5
            )
            t1 := add(
                t3,
                0x009713b03af0fed4cd2cafadeed8fdf4a74fa084e52d1852e4a2bd0685c315d2
            )

            // is non residue ?
            t0 := addmod(mulmod(t0, t0, N), mulmod(t1, t1, N), N)
            let freemem := mload(0x40)
            mstore(freemem, 0x20)
            mstore(add(freemem, 0x20), 0x20)
            mstore(add(freemem, 0x40), 0x20)
            mstore(add(freemem, 0x60), t0)
            // (N - 1) / 2 = 0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            mstore(
                add(freemem, 0x80),
                0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            )
            // N = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            mstore(
                add(freemem, 0xA0),
                0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            )
            callSuccess := staticcall(
                sub(gas(), 2000),
                5,
                freemem,
                0xC0,
                freemem,
                0x20
            )
            _isOnCurve := eq(1, mload(freemem))
        }
    }

    function isNonResidueFP(uint256 e)
        internal
        view
        returns (bool isNonResidue)
    {
        bool callSuccess;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let freemem := mload(0x40)
            mstore(freemem, 0x20)
            mstore(add(freemem, 0x20), 0x20)
            mstore(add(freemem, 0x40), 0x20)
            mstore(add(freemem, 0x60), e)
            // (N - 1) / 2 = 0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            mstore(
                add(freemem, 0x80),
                0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            )
            // N = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            mstore(
                add(freemem, 0xA0),
                0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            )
            callSuccess := staticcall(
                sub(gas(), 2000),
                5,
                freemem,
                0xC0,
                freemem,
                0x20
            )
            isNonResidue := eq(1, mload(freemem))
        }
        require(callSuccess, "BLS: isNonResidueFP modexp call failed");
        return !isNonResidue;
    }

    function isNonResidueFP2(uint256[2] memory e)
        internal
        view
        returns (bool isNonResidue)
    {
        uint256 a = addmod(mulmod(e[0], e[0], N), mulmod(e[1], e[1], N), N);
        bool callSuccess;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let freemem := mload(0x40)
            mstore(freemem, 0x20)
            mstore(add(freemem, 0x20), 0x20)
            mstore(add(freemem, 0x40), 0x20)
            mstore(add(freemem, 0x60), a)
            // (N - 1) / 2 = 0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            mstore(
                add(freemem, 0x80),
                0x183227397098d014dc2822db40c0ac2ecbc0b548b438e5469e10460b6c3e7ea3
            )
            // N = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            mstore(
                add(freemem, 0xA0),
                0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            )
            callSuccess := staticcall(
                sub(gas(), 2000),
                5,
                freemem,
                0xC0,
                freemem,
                0x20
            )
            isNonResidue := eq(1, mload(freemem))
        }
        require(callSuccess, "BLS: isNonResidueFP2 modexp call failed");
        return !isNonResidue;
    }

    function sqrt(uint256 xx) internal view returns (uint256 x, bool hasRoot) {
        bool callSuccess;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let freemem := mload(0x40)
            mstore(freemem, 0x20)
            mstore(add(freemem, 0x20), 0x20)
            mstore(add(freemem, 0x40), 0x20)
            mstore(add(freemem, 0x60), xx)
            // (N + 1) / 4 = 0xc19139cb84c680a6e14116da060561765e05aa45a1c72a34f082305b61f3f52
            mstore(
                add(freemem, 0x80),
                0xc19139cb84c680a6e14116da060561765e05aa45a1c72a34f082305b61f3f52
            )
            // N = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            mstore(
                add(freemem, 0xA0),
                0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            )
            callSuccess := staticcall(
                sub(gas(), 2000),
                5,
                freemem,
                0xC0,
                freemem,
                0x20
            )
            x := mload(freemem)
            hasRoot := eq(xx, mulmod(x, x, N))
        }
        require(callSuccess, "BLS: sqrt modexp call failed");
    }

    function addPoints(uint256[2] memory p1, uint256[2] memory p2)
        internal
        view
        returns (uint256[2] memory r)
    {
        uint256[4] memory input;
        input[0] = p1[0];
        input[1] = p1[1];
        input[2] = p2[0];
        input[3] = p2[1];
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 6, input, 0xc0, r, 0x60)
        }
        require(success, "Failed to add points");
    }

    function mulPoint(uint256[2] memory p, uint256 s)
        internal
        view
        returns (uint256[2] memory r)
    {
        uint256[3] memory input;
        input[0] = p[0];
        input[1] = p[1];
        input[2] = s;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 7, input, 0x80, r, 0x60)
        }
        require(success);
    }

    struct PublicKey {
      uint256 x_real;
      uint256 y_real;
      uint256 x_imaginary;
      uint256 y_imaginary;
    }

    function addKey(PublicKey memory a, PublicKey memory b) public view returns (uint256, uint256, uint256, uint256) {
        return BN256G2.ecTwistAdd(a.x_real, a.y_real, a.x_imaginary, a.y_imaginary, b.x_real, b.y_real, b.x_imaginary, b.y_imaginary);
    }

    function verifyAggregated(
        PublicKey[] memory pubkeys,
        uint256[2] memory aggregated_signature,
        bytes memory data
    ) public {
        uint256[2] memory hash = hashToPoint(data);

        PublicKey memory aggregated_pubkey = pubkeys[0];
        for (uint256 i = 1; i < pubkeys.length; i++) {
            (uint256 x_real, uint256 y_real, uint256 x_imaginary, uint256 y_imaginary) = addKey(aggregated_pubkey, pubkeys[i]);
            aggregated_pubkey.x_real = x_real;
            aggregated_pubkey.y_real = y_real;
            aggregated_pubkey.x_imaginary = x_imaginary;
            aggregated_pubkey.y_imaginary = y_imaginary;
        }

        require(
            verifySingle(aggregated_signature, [aggregated_pubkey.x_real, aggregated_pubkey.y_real, aggregated_pubkey.x_imaginary, aggregated_pubkey.y_imaginary], hash),
            "Verification failed"
        );
    }

    function verifyOptimizedAggregated(
        uint256[2][] memory pubkeys_g1,
        PublicKey memory aggregated_g2,
        uint256[2] memory signature,
        bytes memory data
    ) public {
        unchecked {
        uint256[2] memory hash = hashToPoint(data);
        require(
            verifySinglePK(signature, aggregated_g2, hash),
            "verification failed 1"
        );
        uint256[2] memory aggregated_g1 = addPoints(pubkeys_g1[0], pubkeys_g1[1]);
          for (uint256 i = 2; i < pubkeys_g1.length; i++) {
            aggregated_g1 = addPoints(aggregated_g1, pubkeys_g1[i]);
          }
        uint256 alpha = uint256(
            keccak256(
                abi.encodePacked(
                    data,
                    signature[0],
                    signature[1],
                    aggregated_g2.x_real,
                    aggregated_g2.y_real,
                    aggregated_g2.x_imaginary,
                    aggregated_g2.y_imaginary,
                    aggregated_g1[0],
                    aggregated_g1[1]
                )
            )
        );
        // alpha*P1
        uint256[2] memory scaled_g1 = mulPoint(aggregated_g1, alpha);
        // alpha*H
        uint256[2] memory scaled_g1_generator = mulPoint(
            [
                7875458235035678754887153468411793526875066621955642619646139314277366414792,
                8106623690154677659962327366078301943507317780154727084061147098569974335996
            ],
            alpha
        );
        // sigma + alpha*P1
        uint256[2] memory g1_part_sig = addPoints(signature, scaled_g1);
        // H(m) + alpha*H
        uint256[2] memory g1_part_hash = addPoints(hash, scaled_g1_generator);
        require(
            verifySinglePK(g1_part_sig, aggregated_g2, g1_part_hash),
            "verification failed 2"
        );
        }
    }

    function verifyHelpedAggregated(
        uint256[2][200] memory points_g1,
        uint256[4] memory aggregated_g2,
        bytes memory data,
        uint256[2] memory signature
    ) public {
        uint256[2] memory hash = hashToPoint(data);
        console.log("Hash");
        require(
            verifySingle(signature, aggregated_g2, hash),
            "verification failed"
        );
        uint256[2] memory aggregated_p1 = addPoints(points_g1[0], points_g1[1]);
        for (uint256 i = 2; i < 200; i++) {
            aggregated_p1 = addPoints(aggregated_p1, points_g1[i]);
        }

        emit Debug(gasleft(), 0, 0, 0);
        uint256 alpha = uint256(
            keccak256(
                abi.encodePacked(
                    data,
                    signature[0],
                    signature[1],
                    aggregated_g2[0],
                    aggregated_g2[1],
                    aggregated_g2[2],
                    aggregated_g2[3],
                    aggregated_p1[0],
                    aggregated_p1[1]
                )
            )
        );
        emit Debug(gasleft(), 0, 0, 0);
        uint256[2] memory scaled_p1 = mulPoint(aggregated_p1, alpha);
        uint256[2] memory scaled_g1_generator = mulPoint(
            [
                7875458235035678754887153468411793526875066621955642619646139314277366414792,
                8106623690154677659962327366078301943507317780154727084061147098569974335996
            ],
            alpha
        );

        uint256[2] memory g1_part_sig = addPoints(signature, scaled_p1);
        uint256[2] memory g1_part_hash = addPoints(hash, scaled_g1_generator);
        emit Debug(gasleft(), 0, 0, 0);
        require(
            verifySingle(g1_part_sig, aggregated_g2, g1_part_hash),
            "verification failed"
        );
        emit Debug(gasleft(), 0, 0, 0);
    }
}
