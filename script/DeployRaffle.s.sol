// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "./Interactions.s.sol";

contract DeployRaffle is Script {
    function run() public {
        deployContract();
    }

    function deployContract() public returns (Raffle, HelperConfig.NetworkConfig memory) {
        // Implementation will go here
        HelperConfig helperConfig = new HelperConfig();
        // local -> deploy mocks, get local config
        // sepolia -> get sepolia config
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        console.log("DeployRaffle.s - Subscription ID:", config.subscriptionId);
        if (config.subscriptionId == 0) {
            // create subscription
            CreateSubscription createSubscription = new CreateSubscription();
            (config.subscriptionId, config.vrfCoordinator) = createSubscription.createSubscription(config.vrfCoordinator, config.account);
            console.log("DeployRaffle.s - Subscription ID:", config.subscriptionId);

            //fund it
            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(
                config.vrfCoordinator,
                config.subscriptionId,
                config.link,
                config.account
            );
        }
        console.log("DeployRaffle.s - Subscription ID:", config.subscriptionId);

        // Now deploy the Raffle contract
        vm.startBroadcast(config.account);
        Raffle raffle = new Raffle(
            config.entranceFee,
            config.interval,
            config.vrfCoordinator,
            config.gasLane,
            config.subscriptionId,
            config.callbackGasLimit
        );
        vm.stopBroadcast();
        console.log("DeployRaffle.s - Subscription ID:", config.subscriptionId);

        // Add the raffle contract as a consumer
        AddConsumer addConsumer = new AddConsumer();
        // don't need to broadcast
        addConsumer.addConsumer(
            config.vrfCoordinator,
            config.subscriptionId,
            address(raffle),
            config.account
        );
        console.log("DeployRaffle.s - Subscription ID:", config.subscriptionId);
        return (raffle, config); // should return `config`not the `helperConfig`
    }
}