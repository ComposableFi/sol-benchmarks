# Benchmarks

```shell
npx hardhat compile
npx hardhat node
npx hardhat run scripts/deploy.ts
npx hardhat test
forge test
```
### BenchEcrecover report

![TestImage Image](images/forge-test-report-1.png)

Max signature count is 8406, beyond which the gas limit exceeds 30M

### EcdsaOps report

![HardhatTestImage Image](images/hardhat-test-report-1.png)

Max signature count is 153, beyond which the gas limit exceeds 30M

## Contract details

### BenchEcrecover

> Contract for benchmarking ecrecover precompile using foundry's forge tests in `test/forge-test`.

### EcdsaOps

> Contract includes encoding and hashing of message string, looping through each signature and recovering each address from the message hash and signature using `ECDSA.recover` function. Finally, an event is emitted with the number of correct matches.




