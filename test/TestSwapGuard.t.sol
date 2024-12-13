// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {Test, console} from "../lib/forge-std/src/Test.sol";
interface ICTC {
    function checkPrice(string calldata token) external view returns (uint256 price, string memory priceStr);
}
contract TestSwapGuard is Test {
    /// @dev This is an ETH receiver swapper that targets Univ3 USDC pool.
    address constant buyUSDC = 0x0000000000008765af4E1A776bdaBBFB2aBe67c8;
    // @dev CTC Check the chain contract
    address constant ctc = 0x0000000000cDC1F8d393415455E382c30FBc0a84;

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main"));
    }

    function testSwapGuardCTC() public payable {
        (uint256 price,) = ICTC(ctc).checkPrice("WETH");
        
        // Case 1: Sending 1 ETH with USDC price (-$5) minOut encoded:
        (bool success,) = buyUSDC.call{value: 1 ether + price - 5e6}("");
        assertTrue(success);

        // Case 2: Sending 1 ETH but requiring more than USDC price minOut (should revert):
        (success,) = buyUSDC.call{value: 1 ether + price + 5e6}("");
        assertFalse(success);
    }
}
