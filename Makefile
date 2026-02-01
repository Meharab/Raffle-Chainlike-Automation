-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

build:; forge build

test:
	forge test

install:; forge install Cyfrin/foundry-devops@0.1.0 --no-commit && forge install smartcontractkit/chainlink@42c74fcd30969bca26a9aadc07463d1c2f473b8c --no-commit && forge install foundry-rs/forge-std@v1.7.0 --no-commit && forge install transmissions11/solmate@v6 --no-commit

deploy:
    @forge script script/DeployRaffle.s.sol:DeployRaffle $(NETWORK_ARGS)

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

# if --network sepolia is used, then use sepolia stuff, otherwise anvil stuff
ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) --legacy -vvvvv
endif



anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy-sepolia:
	@forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $(SEPOLIA) --account sepolia --sender $(SENDER) --broadcast --verify --etherscan-api-key $(ETHERSCAN) --legacy -vvvvv

deploy-anvil:
	@forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $(RPC) --private-key $(PRI) --broadcast -vvvvv
	