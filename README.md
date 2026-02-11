# Decentralized Oracle Lite

A high-quality boilerplate for building a custom decentralized oracle system. This contract allows a set of authorized providers to report external data (such as asset prices), which is then aggregated to provide a reliable on-chain data point.

## Features
* **Multi-Provider Consensus:** Prevents data manipulation by requiring reports from multiple independent nodes.
* **Median Aggregation:** Automatically calculates the median value from reported data to filter out outliers.
* **Stale Data Protection:** Includes timestamps to ensure data consumed by dApps is current.
* **Flat File Structure:** Single-directory layout for rapid auditing and seamless integration.

## Interaction Flow
1. **Report:** Authorized nodes call `pushData()` with current off-chain values.
2. **Aggregate:** The contract collects values within a specific window.
3. **Consume:** Consumer contracts call `getLatestData()` to receive the verified median price.
