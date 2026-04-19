// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract TipJar {
    address public owner;
    uint256 public targetAmount;
    uint256 public totalRaised;

    mapping(address => uint256) public donorBalances;

    event TipReceived(address indexed tipper, uint256 amount);
    event TipWithdrawn(address indexed owner, uint256 amount);
    event GoalReached(uint256 totalAmount);

    constructor(uint256 _targetAmount) {
        owner = msg.sender;
        targetAmount = _targetAmount;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    modifier goalReached() {
        require(address(this).balance >= targetAmount, "Goal not yet reached.");
        _;
    }

    function tip() public payable {
        require(msg.value > 0, "You must send a tip to use this function.");

        donorBalances[msg.sender] += msg.value;
        totalRaised += msg.value;

        emit TipReceived(msg.sender, msg.value);

        if (address(this).balance >= targetAmount) {
            emit GoalReached(address(this).balance);
        }
    }

    function withdrawTips() public onlyOwner goalReached {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "There are no tips to withdraw.");

        // CEI 패턴: 상태 변경 먼저
        totalRaised = 0;

        (bool success, ) = payable(owner).call{ value: contractBalance }("");
        require(success, "Transfer failed.");

        emit TipWithdrawn(owner, contractBalance);
    }

    function getDonorBalance(address _donor) public view returns (uint256) {
        return donorBalances[_donor];
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getCompletionRate() public view returns (uint256) {
        if (targetAmount == 0) return 0;
        uint256 rate = (address(this).balance * 100) / targetAmount;
        return rate > 100 ? 100 : rate;
    }
}
