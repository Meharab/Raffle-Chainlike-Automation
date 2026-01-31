// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployRaffle is Script {
    function run() external {
        deployContract();
    }

    function deployContract() internal returns (Raffle, HelperConfig) {
        // Implementation will go here
        HelperConfig helperConfig = new HelperConfig();
        // local -> deploy mocks, get local config
        // sepolia -> get sepolia config
        HelperConfig.NetworkConfig memory networkConfig = helperConfig.getConfig();

        vm.startBroadcast();
        Raffle raffle = new Raffle(
            networkConfig.entranceFee,
            networkConfig.interval,
            networkConfig.vrfCoordinator,
            networkConfig.gasLane,
            networkConfig.subscriptionId,
            networkConfig.callbackGasLimit
        );
        vm.stopBroadcast();
        return (raffle, helperConfig);
    }
}

// function run() external returns (Raffle, HelperConfig) {
//     HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!
//     (
//         uint256 entranceFee,
//         uint256 interval,
//         address vrfCoordinator,
//         bytes32 gasLane,
//         uint256 subscriptionId,
//         uint32 callbackGasLimit
//     ) = helperConfig.getConfig();

//     vm.startBroadcast();
//     Raffle raffle = new Raffle(
//         entranceFee,
//         interval,
//         vrfCoordinator,
//         gasLane,
//         subscriptionId,
//         callbackGasLimit
//     );
//     vm.stopBroadcast();

//     return (raffle, helperConfig);
// }