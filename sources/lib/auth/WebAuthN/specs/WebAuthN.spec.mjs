import util from 'node:util';
import {
  describe,
  it,
} from 'mocha';
import {
  expect,
} from 'chai';

describe('WebAuthN', () => {
  const debuglog = util.debuglog('WebAuthN:specs');

  it('should run this dummy test', async () => {
    debuglog('WebAuthN');

    return expect(true).to.be.true;
  });
});
