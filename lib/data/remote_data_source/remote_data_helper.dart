class RemoteData {
  static const baseUrl = 'https://apigw.vakifbank.com.tr:8443';
  static const baseUrlAuth = 'https://kazachange.alphadev39.com/api';
  static const authenticationPath = '/auth/oauth/v2/token';
  static const bondListPath = '/bondBillEurobondProductList';
  static const bondCalculatorPath = '/bondBillEurobondCalculator';
}

class BondRequest {
  static const productName = 'ProductName';
  static const transactionType = 'TransactionType';
  static const isin = 'ISIN';
  static const item = 'Item';
  static const amount = 'Amount';
}
