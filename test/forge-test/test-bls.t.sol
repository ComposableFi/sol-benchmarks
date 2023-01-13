// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../../Contracts/BLS.sol";
import "../../lib/forge-std/src/Test.sol";

contract BLSTest is Test {
    BLS public bls;

    function setUp() public virtual {
        bls = new BLS();
    }

    function testSampleCall() public {
        uint256[2][2] memory points_g1 = [
            [
                4732500246076266494184282090774606989935310339956125703553588050065105269449,
                17680088654892913246817622267030318133161076660043605649300612920347752169327
            ],
            [
                1655578660422496991839058780452835616766416333598975400769190111973908174329,
                16334665185251989719101735311683947808779079810183866863232955457422711503726
            ]
        ];
        uint256[4] memory aggregated_g2 = [
            14178005680273297700635884606972956253020209975180923080212567002716174962641,
            19525222298104009616876491016641859478269371167286197258132969779795797305743,
            19027518723931341103073785465668576605740970714805850125609708850081760732489,
            18057896816083435547450502703136613724962816380884002962302407485956668096709
        ];
        bytes memory data = toBytes(43981);
        console.logBytes(data);
        uint256[2] memory signature = [
            6804144552764344418959845231470699534013438283199506455269959243065640516474,
            18573269969639768122779348061540594442522455166686531364025732447737093670312
        ];
        bls.verifyHelpedAggregated(points_g1, aggregated_g2, data, signature);
    }

    function toBytes(uint256 x) public returns (bytes memory b) {
        b = new bytes(32);
        for (uint256 i = 0; i < 32; i++) {
            b[i] = bytes1(uint8(x / (2**(8 * (31 - i)))));
        }
    }
}
