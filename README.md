# Benchmarks

### Openzeppelin ECDSA recover (signature verification)

| Number of signatures verified | Gas Usage | Gas Price (Eth) (15 Gwei) | USD (at 1500/eth) |
|-------------------------------|-----------|---------------------------|-------------------|
| 1                             | 30381     | 0.0004                    | 0.6               |
| 20                            | 152751    | 0.0022                    | 3.3               |
| 2000                          | 13143370  | 0.1971                    | 295.65            |
| 4000                          | 26653668  | 0.3998                    | 599.7             |
| 4340                          | 28989246  | 0.4348                    | 652.2             |

[Gas report](gas-report.txt)
### ecrecover precompile

| Number of signatures verified | Gas Usage | Gas Price (Eth)(15 Gwei) | USD (at 1500/eth) |
|-------------------------------|-----------|--------------------------|-------------------|
| 1                             | 11276     | 0.00016                  | 0.24              |
| 20                            | 78721     | 0.00118                  | 1.77              |
| 2000                          | 7119578   | 0.10679                  | 160.18            |
| 4000                          | 14247110  | 0.21370                  | 320.55            |
| 8000                          | 28548929  | 0.42823                  | 642.385           |
| 8405                          | 29996915  | 0.44995                  | 674.925           |

## Development

```shell
npx hardhat compile
npx hardhat node
npx hardhat run scripts/deploy.ts
npx hardhat test
forge test
```

## Contract details

### NoCacheEcrecover

> Contract for benchmarking ecrecover precompile using foundry's forge tests in `test/forge-test`. An event is emitted with the number of correct matches.

### EcdsaOps

> Contract includes looping through each signature and recovering each address from the message hash and signature using `ECDSA.recover` function. Finally, an event is emitted with the number of correct matches.





