# Benchmarks

```shell
npx hardhat compile
npx hardhat node
npx hardhat run scripts/deploy.ts
npx hardhat test
```
## Gas report

·--------------------------------|---------------------------|-------------|-----------------------------·
|      Solc version: 0.8.17      ·  Optimizer enabled: true  ·  Runs: 200  ·  Block limit: 30000000 gas  │
·································|···························|·············|······························
|  Methods                                                                                               │
·············|···················|············|··············|·············|···············|··············
|  Contract  ·  Method           ·  Min       ·  Max         ·  Avg        ·  # calls      ·  usd (avg)  │
·············|···················|············|··············|·············|···············|··············
|  EcdsaOps  ·  checkSignatures  ·     31166  ·     1004067  ·     306606  ·            8  ·          -  │
·············|···················|············|··············|·············|···············|··············
|  Deployments                   ·                                         ·  % of limit   ·             │
·································|············|··············|·············|···············|··············
|  EcdsaOps                      ·         -  ·           -  ·     449473  ·        1.5 %  ·          -  │
·--------------------------------|------------|--------------|-------------|---------------|-------------·

Max signature count is 153, beyond which the transaction gas limit exceeds block gas limit of 30M
