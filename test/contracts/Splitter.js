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
<<<<<<< HEAD
  let contractForSeller;
  let contractForBuyer;

  let token;
  let equalAmount;
  let owner;
  let feeCollector;
  let beneficiaries;

=======
  const price = utils.parseUnits('1', 'ether');
  const doublePrice = price.mul(2);
  let contractForSeller;
  let contractForBuyer;

>>>>>>> 54814f441f1a98d94d1b8fa10523e3beb259711d
  before(async () => {
    provider = createMockProvider();
    [sellerWallet, buyerWallet] = await getWallets(provider);
  });

  beforeEach(async () => {
<<<<<<< HEAD
    // constructor(address[] _beneficiaries, address _feeCollector, ERC20 _token)
    contractForSeller = await deployContract(sellerWallet, Splitter, []);
=======
    contractForSeller = await deployContract(sellerWallet, Splitter, [], {value: doublePrice});
>>>>>>> 54814f441f1a98d94d1b8fa10523e3beb259711d
    contractForBuyer = contractWithWallet(contractForSeller, buyerWallet);
  });

  describe('construction', () => {
<<<<<<< HEAD
    it('fails if there is less than 2 people to splitt', async () => {
      expect(await contractForSeller.beneficiaries()).to.be.equal(1);
      // console.log(price);
    });
  });
=======
    it('stores the price as half of the payed amount', async () => {
      expect(await contractForSeller.price()).to.deep.equal(price);
    });

    it('fails if odd amount is payed', async () => {
      await expect(deployContract(sellerWallet, Splitter, [], {value: doublePrice.sub(1)})).to.be.eventually.rejected;
    });
  });

  describe('contract cancelation', () => {
    it('fails if contract is tryed to be canceled by not seller', async () => {
      await expect(contractForBuyer.cancel()).to.eventually.be.rejected;
    });
    it('fails if contract is tryed to be canceled by buyer but is in progress', async () => {
      contractForBuyer.confirmPurchase({value: doublePrice});
      await expect(contractForSeller.cancel()).to.be.eventually.rejected;
    });
  });

  it('fails if the buyer pays a incorrect amount while confirming purchase', async () => {
    await expect(contractForBuyer.confirmPurchase({value: 0})).to.eventually.be.rejected;
    await expect(contractForBuyer.confirmPurchase({value: doublePrice.add(2)})).to.eventually.be.rejected;
    await expect(contractForBuyer.confirmPurchase({value: price})).to.eventually.be.rejected;
  });
>>>>>>> 54814f441f1a98d94d1b8fa10523e3beb259711d
});
