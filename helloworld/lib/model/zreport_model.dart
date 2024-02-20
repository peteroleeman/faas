

class ZReportModel {
   String storeTitle = "";
  String storeAddress = "";
   String openStoreDate = "";
   String openStoreTime = "";
   String closeStoreDate = "";
   String closeStoreTime = "";
  Map<String, double> paymentMap = {};
  Map<String, int> paymentCountMap = {};

   int totalQty = 0;
   double totalPrice = 0.0;

   int voidQty = 0;
   double voidPrice = 0.0;

   double discountPrice = 0.0;

   double totalTax = 0.0;
   double totalTaxInclusive = 0.0;
   double totalRounding = 0.0;
   double totalSC = 0.0;
   double subTotalPrice = 0.0; //price without any discount
   double receiptLevelDiscountPrice =0.0; //this is the receipt level discount

  //opening float
   double openingFloat = 0.0;

  //total cashout
   double totalCashOut = 0.0;

//sales report
  Map<String, double> catPaidMap = {};
  Map<String, int> catPaidQtyMap = {};
  Map<String, double> catVoidMap = {};
  Map<String, int> catVoidQtyMap = {};

  //hourly info
  Map<int, double> hourlySalesMap = {};
  Map<int, int> hourlyQtyMap = {};

  //summary hourly report
  Map<int, int> hourlyReceiptTotalMap = {};
  Map<int, double> hourlyGTOSalesTotalMap = {};
  Map<int, double> hourlyGstTotalMap = {};
  Map<int, double> hourlyDiscountTotalMap = {};
  Map<int, int> hourlyPaxTotalMap = {};
}
