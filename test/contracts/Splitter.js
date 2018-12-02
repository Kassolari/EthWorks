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
  let splitter3;
  let splitter4;
  let feeCollector;
  let contractForSeller;
  let beneficiaries = [];
  // let equalAmount;
  before(async () => {
    provider = createMockProvider();
    [owner, splitter1, splitter2, splitter3, splitter4, feeCollector] = await getWallets(provider);
    token = await deployContract(owner, BasicToken, [owner.address, 10000]);
  });

  beforeEach(async () => {
    // constructor(address[] _beneficiaries, address _feeCollector, ERC20 _token)
    beneficiaries.push(splitter1.address);
    beneficiaries.push(splitter2.address);
    contractForSeller = await deployContract(owner, Splitter, [beneficiaries, feeCollector.address, token.address]);
  });

  describe('construction', () => {
    it('fails if there is less than 2 people to splitt', async () => {
      // expect(await contractForSeller.beneficiaries()).to.be.equal(1);
      // console.log(price);
    });
  });
});
