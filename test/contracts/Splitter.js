import chai, {expect} from 'chai';
import chaiAsPromised from 'chai-as-promised';
import {createMockProvider, deployContract, getWallets, contractWithWallet} from 'ethereum-waffle';
import {utils} from 'ethers';

import Escrow from '../../build/Escrow.json';

chai.use(chaiAsPromised);

describe('Escrow', () => {});
