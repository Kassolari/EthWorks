import chai, {expect} from 'chai';
import chaiAsPromised from 'chai-as-promised';
import {createMockProvider, deployContract, getWallets, contractWithWallet} from 'ethereum-waffle';
import {utils} from 'ethers';


import Splitter from '../../build/Splitter.json';

chai.use(chaiAsPromised);

describe('Escrow', () => {});
