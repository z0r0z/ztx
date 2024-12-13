# [ztx](https://github.com/z0r0z/ztx)  [![License: AGPL-3.0-only](https://img.shields.io/badge/License-AGPL-black.svg)](https://opensource.org/license/agpl-v3/) [![solidity](https://img.shields.io/badge/solidity-%5E0.8.28-black)](https://docs.soliditylang.org/en/v0.8.28/) [![Foundry](https://img.shields.io/badge/Built%20with-Foundry-000000.svg)](https://getfoundry.sh/)

Zero TX (ZTX) is a gas optimization technique that enables lightweight programmability in smart contract interactions through the least significant bits of ETH transfers, eliminating the need for calldata.

## Concept

ZTX encodes additional parameters directly in the value field of ETH transfers. For example, when swapping ETH for USDC, the minimum output amount for slippage protection against an AMM is encoded in the last 10 digits of the transfer value:

```mermaid
graph LR
    A[ETH Value] --> B[Main Amount]
    A --> C[MinOut]
    B[Main Amount: 1.0 ETH] --> D[1000000000000000000]
    C[MinOut: 3900 USDC] --> E[3900000000]
    D --> F[Final Value: 1000000003900000000]
    E --> F
```

## Getting Started

Run: `curl -L https://foundry.paradigm.xyz | bash && source ~/.bashrc && foundryup`

Build the foundry project with `forge build`. Run tests with `forge test`. Measure gas with `forge snapshot`. Format with `forge fmt`.
