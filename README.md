> We are engineers so we do as much work as possible to be as lazy as possible - Patrick Collins
----------------------------------------------------------------------------------

# Proveably Random Raffle Contracts
​
## About
​
This code is to create a proveably random smart contract lottery.
​
## What we want it to do?
​
1. Users should be able to enter the raffle by paying for a ticket. The ticket fees are going to be the prize the winner receives.
2. The lottery should automatically and programmatically draw a winner after a certain period.
3. Chainlink VRF should generate a provably random number.
4. Chainlink Automation should trigger the lottery draw regularly.

## Tests!

1. Write deploy scripts
   1. Note, this will not work on zksync
2. Write tests
   1. Local chain
   2. Forked testnet
   3. Forked mainnet

```bash
source .env
cast wallet import account --interactive
cast wallet list
forge script script/Interactions.s.sol:FundSubscription --rpc-url $SEPOLIA --account sepolia --broadcast
forge coverage --report debug > coverage.txt
forge test --mt testPerformUpkeepUpdatesRaffleStateAndEmitsRequestId -vvvvv
cast sig "createSubscription"
forge test --fork-url $SEPOLIA
forge verify-contract 0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925 src/Raffle.sol:Raffle --etherscan-api-key $ETHERSCAN --rpc-url $SEPOLIA --show-standrad-json-input > json.json
forge test --debug testFulfillRandomWordsPicksAWinnerResetsAndSendsMoney
forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $RPC --account defaultKey --sender $PUB --broadcast --legacy -vvvvv
```
`[Deployed address in sepolia: 0x0d9cb3317fd1fa5e97b718d17c86f24ec9b8e925](https://sepolia.etherscan.io/address/0x0d9cb3317fd1fa5e97b718d17c86f24ec9b8e925#readContract)`

```

╭---------------------------+------------------+------------------+---------------+----------------╮
| File                      | % Lines          | % Statements     | % Branches    | % Funcs        |
+==================================================================================================+
| script/DeployRaffle.s.sol | 90.48% (19/21)   | 96.00% (24/25)   | 100.00% (1/1) | 50.00% (1/2)   |
|---------------------------+------------------+------------------+---------------+----------------|
| script/HelperConfig.s.sol | 76.19% (16/21)   | 85.00% (17/20)   | 20.00% (1/5)  | 60.00% (3/5)   |
|---------------------------+------------------+------------------+---------------+----------------|
| script/Interactions.s.sol | 50.00% (26/52)   | 48.00% (24/50)   | 50.00% (1/2)  | 37.50% (3/8)   |
|---------------------------+------------------+------------------+---------------+----------------|
| src/Raffle.sol            | 90.20% (46/51)   | 94.00% (47/50)   | 75.00% (3/4)  | 81.82% (9/11)  |
|---------------------------+------------------+------------------+---------------+----------------|
| test/mocks/LinkToken.sol  | 11.76% (2/17)    | 7.14% (1/14)     | 0.00% (0/1)   | 20.00% (1/5)   |
|---------------------------+------------------+------------------+---------------+----------------|
| Total                     | 67.28% (109/162) | 71.07% (113/159) | 46.15% (6/13) | 54.84% (17/31) |
╰---------------------------+------------------+------------------+---------------+----------------╯
[⠊] Compiling...
No files changed, compilation skipped
Warning: Detected artifacts built from source files that no longer exist. Run `forge clean` to make sure builds are in sync with project files.
 - /home/licdora/Boot/foundry/foundry-raffle/test/Counter.t.sol
 - /home/licdora/Boot/foundry/foundry-raffle/src/Counter.sol
 - /home/licdora/Boot/foundry/foundry-raffle/script/Counter.s.sol
Traces:
  [19128804] DeployRaffle::run()
    ├─ [8318598] → new HelperConfig@0xC7f2Cf4845C6db0e1a1e91ED41Bcd0FcC1b0E141
    │   └─ ← [Return] 40538 bytes of code
    ├─ [8866] HelperConfig::getConfig()
    │   ├─ [0] console::log("HelperConfig.s - Subscription ID:", 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76]) [staticcall]
    │   │   └─ ← [Stop]
    │   └─ ← [Return] NetworkConfig({ entranceFee: 10000000000000000 [1e16], interval: 30, vrfCoordinator: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B, gasLane: 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae, callbackGasLimit: 500000 [5e5], subscriptionId: 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76], link: 0x779877A7B0D9E8603169DdbD7836e478b4624789, account: 0x55F710a5509f4a8a8fE8a41dF476e51daD401454 })
    ├─ [0] console::log("DeployRaffle.s - Subscription ID:", 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76]) [staticcall]
    │   └─ ← [Stop]
    ├─ [0] console::log("DeployRaffle.s - Subscription ID:", 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76]) [staticcall]
    │   └─ ← [Stop]
    ├─ [0] VM::startBroadcast(0x55F710a5509f4a8a8fE8a41dF476e51daD401454)
    │   └─ ← [Return]
    ├─ [1604762] → new Raffle@0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925
    │   └─ ← [Return] 7664 bytes of code
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    ├─ [0] console::log("DeployRaffle.s - Subscription ID:", 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76]) [staticcall]
    │   └─ ← [Stop]
    ├─ [8997774] → new AddConsumer@0xdaE97900D4B184c5D2012dcdB658c008966466DD
    │   └─ ← [Return] 44815 bytes of code
    ├─ [66786] AddConsumer::addConsumer(0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B, 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76], Raffle: [0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925], 0x55F710a5509f4a8a8fE8a41dF476e51daD401454)
    │   ├─ [0] console::log("Interactions.s - Adding consumer contract:", Raffle: [0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925]) [staticcall]
    │   │   └─ ← [Stop]
    │   ├─ [0] console::log("Interactions.s - To subscription:", 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76]) [staticcall]
    │   │   └─ ← [Stop]
    │   ├─ [0] console::log("Interactions.s - To vrfCoordinator:", 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B) [staticcall]
    │   │   └─ ← [Stop]
    │   ├─ [0] console::log("Interactions.s - On ChainID: ", 11155111 [1.115e7]) [staticcall]
    │   │   └─ ← [Stop]
    │   ├─ [0] VM::startBroadcast(0x55F710a5509f4a8a8fE8a41dF476e51daD401454)
    │   │   └─ ← [Return]
    │   ├─ [56142] 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B::addConsumer(20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76], Raffle: [0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925])
    │   │   ├─ emit SubscriptionConsumerAdded(subId: 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76], consumer: Raffle: [0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925])
    │   │   └─ ← [Stop]
    │   ├─ [0] VM::stopBroadcast()
    │   │   └─ ← [Return]
    │   ├─ [0] console::log("Interactions.s - Consumer added successfully") [staticcall]
    │   │   └─ ← [Stop]
    │   └─ ← [Stop]
    ├─ [0] console::log("DeployRaffle.s - Subscription ID:", 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76]) [staticcall]
    │   └─ ← [Stop]
    └─ ← [Stop]


Script ran successfully.

== Logs ==
  HelperConfig.s - Subscription ID: 20754675458119495485073855082968386476599663373639752400642952203878427767022
  DeployRaffle.s - Subscription ID: 20754675458119495485073855082968386476599663373639752400642952203878427767022
  DeployRaffle.s - Subscription ID: 20754675458119495485073855082968386476599663373639752400642952203878427767022
  DeployRaffle.s - Subscription ID: 20754675458119495485073855082968386476599663373639752400642952203878427767022
  Interactions.s - Adding consumer contract: 0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925
  Interactions.s - To subscription: 20754675458119495485073855082968386476599663373639752400642952203878427767022
  Interactions.s - To vrfCoordinator: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B
  Interactions.s - On ChainID:  11155111
  Interactions.s - Consumer added successfully
  DeployRaffle.s - Subscription ID: 20754675458119495485073855082968386476599663373639752400642952203878427767022

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [1604762] → new Raffle@0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925
    └─ ← [Return] 7664 bytes of code

  [56142] 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B::addConsumer(20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76], Raffle: [0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925])
    ├─ emit SubscriptionConsumerAdded(subId: 20754675458119495485073855082968386476599663373639752400642952203878427767022 [2.075e76], consumer: Raffle: [0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925])
    └─ ← [Stop]


==========================

Chain 11155111

Estimated gas price: 1.079094047 gwei

Estimated total gas used for script: 2443552

Estimated amount required: 0.002636822416734944 ETH

==========================
Enter keystore password:

##### sepolia
✅  [Success] Hash: 0x2273418b601f5982ea914681e7f3265076f44887fab03ebea1c3270a500986c7
Contract Address: 0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925
Block: 10170926
Paid: 0.00180099535614299 ETH (1796690 gas * 1.002396271 gwei)


##### sepolia
✅  [Success] Hash: 0xc912b45dd3819543392f9f1d9d6b412bc296d87daf389c7be1ba49457da884a7
Block: 10170926
Paid: 0.000078273115217306 ETH (78086 gas * 1.002396271 gwei)

✅ Sequence #1 on sepolia | Total Paid: 0.001879268471360296 ETH (1874776 gas * avg 1.002396271 gwei)
                                                                                                                                                                                           

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
##
Start verification for (1) contracts
Start verifying contract `0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925` deployed on sepolia
EVM version: prague
Compiler version: 0.8.19
Constructor args: 000000000000000000000000000000000000000000000000002386f26fc10000000000000000000000000000000000000000000000000000000000000000001e0000000000000000000000009ddfaca8183c41ad55329bdeed9f6a8d53168b1b787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae2de2bae2a5d4fb1335a54134e48902fe041e7ddb235ef9df76aae7ccd237b0ee000000000000000000000000000000000000000000000000000000000007a120

Submitting verification for [src/Raffle.sol:Raffle] 0x0D9cB3317FD1fA5E97b718D17c86F24Ec9b8e925.
Submitted contract for verification:
	Response: `OK`
	GUID: `52eupcja1iifcpstnrqvhkaezwceg7vphupjxzgpr1giyp5baa`
	URL: https://sepolia.etherscan.io/address/0x0d9cb3317fd1fa5e97b718d17c86f24ec9b8e925
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Warning: Verification is still pending...; waiting 15 seconds before trying again (7 tries remaining)
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
All (1) contracts were verified!
```
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
