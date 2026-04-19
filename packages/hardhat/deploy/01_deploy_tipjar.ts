import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { parseEther } from "viem";

const deployTipJar: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  await deploy("TipJar", {
    from: deployer,
    args: [parseEther("0.1")], // 목표 금액: 0.1 ETH (원하는 값으로 변경)
    log: true,
    autoMine: true,
  });
};

export default deployTipJar;

deployTipJar.tags = ["TipJar"];
