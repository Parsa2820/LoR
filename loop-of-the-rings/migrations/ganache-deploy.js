var instance = artifacts.require (“./Instance.sol”);
module.exports = function(deployer) {
      deployer.deploy(instance);
}