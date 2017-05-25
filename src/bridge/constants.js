const cors = {
  accountAddr: 'dc92a0556fe6586ad7193a2d147dcfef7a42db33',
  contractAddress: '0x45d3ccce031b9f84d082eb38be65dfa3ae642f85',
  vanityContract: [{"constant": false, "inputs":[{"name":"userValue","type":"string"},{"name":"params","type":"string"}],"name":"setParam","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"userAddr","type":"address"},{"name":"keys","type":"string"},{"name":"url","type":"string"}],"name":"pushResult","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_value","type":"uint256"},{"name":"_token","type":"address"},{"name":"_extraData","type":"string"},{"name":"_extraData2","type":"string"}],"name":"receiveApproval","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"launched","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"status","type":"string"},{"name":"user","type":"address"}],"name":"broadcast","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"getResult","outputs":[{"name":"keyz","type":"string"},{"name":"url","type":"string"}],"payable":false,"type":"function"},{"inputs":[{"name":"_iextoken","type":"address"}],"payable":false,"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"value","type":"string"},{"indexed":false,"name":"param","type":"string"},{"indexed":false,"name":"addr","type":"address"}],"name":"Launch","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"status","type":"string"},{"indexed":true,"name":"user","type":"address"}],"name":"Logs","type":"event"}],
};

export default cors;
