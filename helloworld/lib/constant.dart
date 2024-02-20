
final gTakeAway = "Take Away";
final gSelfPickup = "Self Pickup";
final gDineIn = "Dine In";
final gDelivery = "Delivery";
final gOrderNow = "Order Now";

const kTaxInclusive = 0;
const kTaxExclusive = 1;
const kUserDefault = "admin";

//payment type
const kPayByRazer = 0;
const kPayByIpay = 1;
const kPayByCash = 2;
const kPayByOther = 3;
const kPayByVoucher = 4;

const kUnPaid = -999;
const kPaid = 0;
const kVoid = -1;
const kRefund = -2;
const kCombined = -3; //new type for combined

const kStatusVoid = -1;
const kStatusStart = 0;
const kStatusPreparing = 1;
const kStatusReady = 2;
const kStatusCollected = 3;
const kStatusCompleted = 4;
const kStatusAll = 999;


const kStoreAllMode = 0;
const kStoreQOnly = 1;
const kStoreOrderOnly = 2;

//promo type
const kPromoTypeDiscount = 0; //discount type
const kPromoTypeValue = 1; //value type
const kPromoTypeBulk = 2; //bulk discount type: buy certain qty to get discount
const kPromoTypeCombo = 3; //value type


final kPrefDateTimeFormat = "yyyy-MM-dd HH:mm:ss";
final kFCDateTimeFormat = "yyyy-MM-dd HH:mm:ss"; //FC = food collection
final kFCDateFormat = "yyyy-MM-dd";
final kFCTimeFormat = "HH:mm:ss";
final kFCSessionDateFormat = "yyyy-MM-dd";
final kFCSessionDateTimeFormat = "yyyy-MM-dd HH:mm";
final kFCSessionTimeFormat = "HH:mm";

const Map<int, String> hourlyMap = {
  0: "12:00 AM - 12:59 AM",
  1: "01:00 AM - 01:59 AM",
  2: "02:00 AM - 02:59 AM",
  3: "03:00 AM - 03:59 AM",
  4: "04:00 AM - 04:59 AM",
  5: "05:00 AM - 05:59 AM",
  6: "06:00 AM - 06:59 AM",
  7: "07:00 AM - 07:59 AM",
  8: "08:00 AM - 08:59 AM",
  9: "09:00 AM - 09:59 AM",
  10: "10:00 AM - 10:59 AM",
  11: "11:00 AM - 11:59 AM",
  12: "12:00 PM - 12:59 PM",
  13: "01:00 PM - 01:59 PM",
  14: "02:00 PM - 02:59 PM",
  15: "03:00 PM - 03:59 PM",
  16: "04:00 PM - 04:59 PM",
  17: "05:00 PM - 05:59 PM",
  18: "06:00 PM - 06:59 PM",
  19: "07:00 PM - 07:59 PM",
  20: "08:00 PM - 08:59 PM",
  21: "09:00 PM - 09:59 PM",
  22: "10:00 PM - 10:59 PM",
  23: "11:00 PM - 11:59 PM"
};

const Map<int, String> hourlyShortMap = {
  0: "0059",
  1: "0159",
  2: "0259",
  3: "0359",
  4: "0459",
  5: "0559",
  6: "0659",
  7: "0759",
  8: "0859",
  9: "0959",
  10: "1059",
  11: "1159",
  12: "1259",
  13: "1359",
  14: "1459",
  15: "1559",
  16: "1659",
  17: "1759",
  18: "1859",
  19: "1959",
  20: "2059",
  21: "2159",
  22: "2259",
  23: "2359"
};