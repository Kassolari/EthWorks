import chai, {expect} from 'chai';
import chaiAsPromised from 'chai-as-promised';
import {createMockProvider, deployContract, getWallets} from 'ethereum-waffle';
import {utils} from 'ethers';
import Splitter from '../../build/Splitter.json';
import BasicToken from '../../build/BasicToken.json';
chai.use(chaiAsPromised);

describe('Splitter', () => {
  let provider;
  let owner;
  let token;
  let splitter1;
  let splitter2;
  let feeCollector;
  let contractForSeller;
  const beneficiaries = [];
  // let equalAmount;
  before(async () => {
    provider = createMockProvider();
    [owner, splitter1, splitter2, feeCollector] = await getWallets(provider);
    token = await deployContract(owner, BasicToken, [owner.address, 10000]);
  });

  beforeEach(async () => {
    // constructor(address[] _beneficiaries, address _feeCollector, ERC20 _token)
    beneficiaries.push(splitter1.address);
    beneficiaries.push(splitter2.address);
    contractForSeller = await deployContract(owner, Splitter, [beneficiaries, feeCollector.address, token.address]);
  });

  describe('construction', () => {
    it('fails if there is less than 2 people to split', async () => {
      // await expect(deployContract(sellerWallet, Escrow, [], {value: doublePrice.sub(1)})).to.be.eventually.rejected;
      beneficiaries.pop();
      await expect(deployContract(owner, Splitter, [beneficiaries, feeCollector.address, token.address])).to.be.eventually.rejected;
    });
  });
  describe('split test', () => {
    it('fails if spender splits less tokens than number of people to split', async () => {
      await expect (contractForSeller.split(1)).to.be.eventually.rejected;
    });
    it('fails if spender splits more tokens than he has', async () => {
      await expect (contractForSeller.split(10001)).to.be.eventually.rejected;
    });
    it('should succed to split 1000 tokens', async () => {
      await expect (contractForSeller.split(1000)).to.be.eventually.fulfilled;
    });
    it('should succed to split 1001 tokens', async () => {
      await expect (contractForSeller.split(1001)).to.be.eventually.fulfilled;
    });
  });
});
