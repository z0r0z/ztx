// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";

contract TestSwapGuard is Test {
    /// @dev This is an ETH receiver swapper that targets Univ3 USDC pool.
    address constant buyUSDC = 0x0000000000008765af4E1A776bdaBBFB2aBe67c8;

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main"));
    }

    function testSwapGuard() public payable {
        // Case 1: Sending 1 ETH with 3900 USDC minOut encoded:
        (bool success,) = buyUSDC.call{value: 1000000003900000000}("");
        assertTrue(success);

        // Case 2: Sending 1 ETH but requiring 4000 USDC minOut (should revert):
        (success,) = buyUSDC.call{value: 1000000004000000000}("");
        assertFalse(success);
    }
}
