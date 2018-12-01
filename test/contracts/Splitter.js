import chai, {expect} from 'chai';
import chaiAsPromised from 'chai-as-promised';
import {createMockProvider, deployContract, getWallets, contractWithWallet} from 'ethereum-waffle';
import {utils} from 'ethers';

import Splitter from '../../build/Splitter.json';

chai.use(chaiAsPromised);

describe('Splitter', () => {
  let provider;
  let sellerWallet;
  let buyerWallet;
  let contractForSeller;
  let contractForBuyer;

  let token;
  let equalAmount;
  let owner;
  let feeCollector;
  let beneficiaries;

  before(async () => {
    provider = createMockProvider();
    [sellerWallet, buyerWallet] = await getWallets(provider);
  });

  beforeEach(async () => {
    // constructor(address[] _beneficiaries, address _feeCollector, ERC20 _token)
    contractForSeller = await deployContract(sellerWallet, Splitter, []);
    contractForBuyer = contractWithWallet(contractForSeller, buyerWallet);
  });

  describe('construction', () => {
    it('fails if there is less than 2 people to splitt', async () => {
      expect(await contractForSeller.beneficiaries()).to.be.equal(1);
      // console.log(price);
    });
  });
});
