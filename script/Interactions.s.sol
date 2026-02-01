// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig, CodeConstants} from "./HelperConfig.s.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";
import {LinkToken} from "test/mocks/LinkToken.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract CreateSubscription is Script {

    function createSubscriptionUsingConfig() public returns (uint256, address) {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        address account = helperConfig.getConfig().account;
        (uint256 subscriptionId, ) = createSubscription(vrfCoordinator, account);
        return (subscriptionId, vrfCoordinator);
    }

    function createSubscription(address vrfCoordinator, address account) public returns (uint256, address) {
        console.log("Interections.s - Creating subscription on ChainID: ", block.chainid);
        vm.startBroadcast(account);
        uint256 subscriptionId = VRFCoordinatorV2_5Mock(vrfCoordinator).createSubscription();
        vm.stopBroadcast();
        console.log("Interactions.s - Subscription Id: ", subscriptionId);
        console.log("Interactions.s - Please update subscriptionId in HelperConfig!");
        return (subscriptionId, vrfCoordinator);
    }

    function run() external returns (uint256, address) {
        return createSubscriptionUsingConfig();
    }
}

contract FundSubscription is Script, CodeConstants {
    uint256 public constant FUND_AMOUNT = 3 ether; // 3 LINK

    function fundSubscriptionUsingConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        uint256 subscriptionId = helperConfig.getConfig().subscriptionId;
        address link = helperConfig.getConfig().link;
        address account = helperConfig.getConfig().account;
        fundSubscription(vrfCoordinator, subscriptionId, link, account);
    }

    function fundSubscription(address vrfCoordinator, uint256 subscriptionId, address linkToken, address account) public {
        console.log("Interactions.s - Funding subscription", subscriptionId);
        console.log("Interactions.s - Using vrfCoordinator:", vrfCoordinator);
        console.log("Interactions.s - On ChainID: ", block.chainid);
        
        if (block.chainid == LOCAL_CHAIN_ID) {
            vm.startBroadcast();
            VRFCoordinatorV2_5Mock(vrfCoordinator).fundSubscription(subscriptionId, FUND_AMOUNT * 100);
            vm.stopBroadcast();
            console.log("Interactions.s - Funded subscription with mock LINK");
        } else {
            vm.startBroadcast(account);
            // For a real chain, use the LinkToken to transferAndCall the vrfCoordinator
            LinkToken(linkToken).transferAndCall(vrfCoordinator, FUND_AMOUNT, abi.encode(subscriptionId));
            vm.stopBroadcast();
        }
    }

    function run() public {
        fundSubscriptionUsingConfig();
    }
}

contract AddConsumer is Script {
    function addConsumerUsingConfig(address mostRecentlyDeployed) public {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        uint256 subscriptionId = helperConfig.getConfig().subscriptionId;
        address account = helperConfig.getConfig().account;
        addConsumer(vrfCoordinator, subscriptionId, mostRecentlyDeployed, account);
    }

    function addConsumer(address vrfCoordinator, uint256 subscriptionId, address contractToAddtoVrf, address account) public {
        console.log("Interactions.s - Adding consumer contract:", contractToAddtoVrf);
        console.log("Interactions.s - To subscription:", subscriptionId);
        console.log("Interactions.s - To vrfCoordinator:", vrfCoordinator);
        console.log("Interactions.s - On ChainID: ", block.chainid);

        vm.startBroadcast(account);
        VRFCoordinatorV2_5Mock(vrfCoordinator).addConsumer(subscriptionId, contractToAddtoVrf);
        vm.stopBroadcast();
        console.log("Interactions.s - Consumer added successfully");
    }

    // function run() external {
    //     address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("Raffle", block.chainid);
    //     addConsumerUsingConfig(mostRecentlyDeployed);
    // }
}