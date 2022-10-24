# Benchmarks

```shell
npx hardhat compile
npx hardhat node
npx hardhat run scripts/deploy.ts
npx hardhat test
```
## [Gas report](gas-report.txt)

![TestImage Image](images/test_report.png)

Max signature count is 153, beyond which the transaction gas limit exceeds block gas limit of 30M
