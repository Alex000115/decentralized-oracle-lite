const hre = require("hardhat");

async function main() {
  const oracle = await hre.ethers.deployContract("SimpleOracle");
  await oracle.waitForDeployment();

  console.log("Oracle deployed to:", await oracle.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
