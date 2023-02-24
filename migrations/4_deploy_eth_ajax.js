/* global artifacts */
require('dotenv').config({ path: '../.env' })
const ETHAjax = artifacts.require('ETHAjax')
const Verifier = artifacts.require('Verifier')
const Hasher = artifacts.require('Hasher')

module.exports = function (deployer) {
  return deployer.then(async () => {
    const { MERKLE_TREE_HEIGHT, ETH_AMOUNT } = process.env
    const verifier = await Verifier.deployed()
    const hasher = await Hasher.deployed()
    const ajax = await deployer.deploy(
      ETHAjax,
      verifier.address,
      hasher.address,
      ETH_AMOUNT,
      MERKLE_TREE_HEIGHT,
    )
    console.log('ETHAjax address', ajax.address)
  })
}
