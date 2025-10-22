// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DailyRewardToken is ERC20 {

    mapping(address => uint256) public lastClaimAt;
    uint256 public dailyReward = 100 * 10 ** 18; // 100 tokens daily

    constructor() ERC20("DailyRewardToken", "DRT") {
        _mint(address(this), 1000000 * 10 ** 18); // mint tokens to contract
    }

    function claim() external {
        require(block.timestamp - lastClaimAt[msg.sender] >= 1 days, "Already claimed today!");
        require(balanceOf(address(this)) >= dailyReward, "Not enough tokens in contract");

        lastClaimAt[msg.sender] = block.timestamp;
        _transfer(address(this), msg.sender, dailyReward);
    }

    function myBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
