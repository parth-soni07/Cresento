require("dotenv").config();

const API_KEY = process.env.API_KEY;
const { Web3 } = require("web3");
const node = `https://go.getblock.io/${API_KEY}/`;
const web3 = new Web3(node);
const accountTo = web3.eth.accounts.create();
console.log("Recipient Account Address:", accountTo);

const private_key = process.env.PRIVATE_KEY;
const accountFrom = web3.eth.accounts.privateKeyToAccount(private_key);
console.log("Sender Account Address:", accountFrom);

const createSignedTx = async (rawTx) => {
  const gasPrice = await web3.eth.getGasPrice();
  rawTx.gasPrice = gasPrice;
  rawTx.gas = 21000;
  return await accountFrom.signTransaction(rawTx);
};

const sendSignedTx = async (signedTx) => {
  const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
  console.log("Transaction Receipt:", receipt);

  // Log the account balances after the transaction
  const senderBalance = await web3.eth.getBalance(accountFrom.address);
  const recipientBalance = await web3.eth.getBalance(accountTo.address);

  console.log(
    "Sender Account Balance:",
    web3.utils.fromWei(senderBalance, "ether")
  );
  console.log(
    "Recipient Account Balance:",
    web3.utils.fromWei(recipientBalance, "ether")
  );};

const executeTransaction = async () => {
  const amountTo = "0.000001";
  const nonce = await web3.eth.getTransactionCount(accountFrom.address);
  const rawTx = {
    to: accountTo.address,
    value: web3.utils.toWei(amountTo, "ether"),
    nonce: web3.utils.toHex(nonce),
    gas: 21000,
    gasPrice: await web3.eth.getGasPrice(),
  };

  const signedTx = await createSignedTx(rawTx);
  await sendSignedTx(signedTx);
};

executeTransaction().catch(console.error);



