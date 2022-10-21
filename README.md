# benchmarks

## sol ecrecover precompile

### local ganache chain

node memory allocated - 16GB
gas limit - 30M

| Signatures | Gas           |
|------------|---------------|
| 864        | 6,720,069     |
| 1000       | 7,781,665     |
| 1200       | 9,345,732     |
| 2000       | 15,641,128    |
| 2200       | 17,224,355    |
| 2300       | out of memory |
| 2400       | out of memory |