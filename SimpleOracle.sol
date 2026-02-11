// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SimpleOracle
 * @dev A minimalist decentralized oracle for price feeds.
 */
contract SimpleOracle is Ownable {
    struct PriceReport {
        uint256 price;
        uint256 timestamp;
    }

    mapping(address => bool) public isProvider;
    mapping(address => PriceReport) public reports;
    address[] public providers;

    event PriceUpdated(uint256 averagePrice, uint256 timestamp);
    event ProviderAdded(address provider);

    constructor() Ownable(msg.sender) {}

    function addProvider(address _provider) external onlyOwner {
        require(!isProvider[_provider], "Already a provider");
        isProvider[_provider] = true;
        providers.push(_provider);
        emit ProviderAdded(_provider);
    }

    function pushData(uint256 _price) external {
        require(isProvider[msg.sender], "Not an authorized provider");
        reports[msg.sender] = PriceReport(_price, block.timestamp);
    }

    /**
     * @dev Aggregates data from all providers and returns the average.
     * In production, a median or weighted average is preferred.
     */
    function getLatestData() external view returns (uint256) {
        uint256 total;
        uint256 count;
        uint256 validTime = block.timestamp - 1 hours;

        for (uint256 i = 0; i < providers.length; i++) {
            if (reports[providers[i]].timestamp >= validTime) {
                total += reports[providers[i]].price;
                count++;
            }
        }

        require(count > 0, "No fresh data available");
        return total / count;
    }
}
