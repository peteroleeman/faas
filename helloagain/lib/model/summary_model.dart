

import 'package:firedart/firedart.dart';
import 'package:helloagain/constant.dart';
import 'package:helloagain/model/kds_status_model.dart';
import 'package:helloagain/model/order_model.dart';
import 'package:helloagain/model/orderitem_model.dart';
import 'package:helloagain/model/store_model.dart';
import 'package:helloagain/model/zreport_model.dart';
import 'package:helloagain/util_datetime.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const kSummaryModelId = 'id';
const kSummaryModelOrders = "orders";
const kSummaryModelStores = "stores";
const kSummaryModelOpenDate = "opendate";
const kSummaryModelCloseDate = "closedate";

//detail report
const kSummaryModelStoreTitle = "storetile";
const kSummaryModelStoreTotalQty = "totalqty";
const kSummaryModelStoreTotalPrice = "totalprice";
const kSummaryModelStoreVoidQty = "voidqty";
const kSummaryModelStoreVoidPrice = "voidprice";
const kSummaryModelStoreDiscountPrice = "discountprice";
const kSummaryModelStoreTotalTax = "totaltax";
const kSummaryModelStoreTotalTaxInclusive = "totaltaxinclusive";
const kSummaryModelStoreTotalRounding = "totalrounding";
const kSummaryModelStoreTotalSC = "totalsc";
const kSummaryModelStoreSubTotalPrice = "subtotalprice";
const kSummaryModelStoreReceiptLevelDiscountPrice = "receiptleveldiscountprice";
const kSummaryModelStoreOpeningFloat = "openingfloat";
const kSummaryModelStoreTotalCashOut = "totalcashout";

class SummaryModel {
  String id;
  List<dynamic> orders = [];
  List<dynamic> stores = [];

  String openDate;
  String closeDate;

  //detail report
  String storeTitle;
  int totalQty;
  double totalPrice;
  int voidQty;
  double voidPrice;
  double discountPrice;
  double totalTax;
  double totalTaxInclusive;
  double totalRounding;
  double totalSC;
  double subTotalPrice; //price without any discount
  double receiptLevelDiscountPrice; //this is the receipt level discount

  //opening float
  double openingFloat;

  //total cashout
  double totalCashOut;

  SummaryModel({
    required this.id,
    required this.orders,
    required this.stores,
    required this.openDate,
    required this.closeDate,

    //detail report
    required this.storeTitle,
    required this.totalQty,
    required this.totalPrice,
    required this.voidQty,
    required this.voidPrice,
    required this.discountPrice,
    required this.totalTax,
    required this.totalTaxInclusive,
    required this.totalRounding,
    required this.totalSC,
    required this.subTotalPrice, //price without any discount
    required this.receiptLevelDiscountPrice, //this is the receipt level discount

    //opening float
    required  this.openingFloat,

    //total cashout
    required this.totalCashOut,
  });

  factory SummaryModel.newSummary()
  {
    return SummaryModel(
         id: "",
    orders : [],
       stores : [],

         openDate : "",
     closeDate: "",

    //detail report
    storeTitle : "",
     totalQty : 0,
     totalPrice: 0.0,
     voidQty: 0,
     voidPrice: 0.0,
         discountPrice: 0.0,
         totalTax : 0.0,
         totalTaxInclusive: 0.0,
         totalRounding : 0.0,
     totalSC : 0.0,
     subTotalPrice: 0.0, //price without any discount
     receiptLevelDiscountPrice : 0.0, //this is the receipt level discount

        //opening float
         openingFloat : 0.0,

        //total cashout
         totalCashOut: 0.0,
    );
  }

  factory SummaryModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kSummaryModelId] ?? "";
    } catch (ex) {}

    var openDate = "";
    try {
      openDate = doc[kSummaryModelOpenDate] ?? "";
    } catch (ex) {}

    var closeDate = "";
    try {
      closeDate = doc[kSummaryModelCloseDate] ?? "";
    } catch (ex) {}

    var orders = [];
    try {
      orders = (doc[kSummaryModelOrders] != null)
          ? doc[kSummaryModelOrders].map((set) {
              return OrderModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}

    var stores = [];
    try {
      stores = (doc[kSummaryModelStores] != null)
          ? doc[kSummaryModelStores].map((set) {
              return StoreModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}

    //report detail
    var storeTitle = "";
    try {
      storeTitle = doc[kSummaryModelStoreTitle] ?? "";
    } catch (ex) {}

    var totalQty = 0;
    try {
      totalQty = doc[kSummaryModelStoreTotalQty] ?? 0;
    } catch (ex) {}

    var totalPrice = 0.0;
    try {
      totalPrice = double.tryParse(
              doc[kSummaryModelStoreTotalPrice]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var voidQty = 0;
    try {
      voidQty = doc[kSummaryModelStoreVoidQty] ?? 0;
    } catch (ex) {}

    var voidPrice = 0.0;
    try {
      voidPrice = double.tryParse(
              doc[kSummaryModelStoreVoidPrice]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var discountPrice = 0.0;
    try {
      discountPrice = double.tryParse(
              doc[kSummaryModelStoreDiscountPrice]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var totalTax = 0.0;
    try {
      totalTax = double.tryParse(
              doc[kSummaryModelStoreTotalTax]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var totalTaxInclusive = 0.0;
    try {
      totalTaxInclusive = double.tryParse(
              doc[kSummaryModelStoreTotalTaxInclusive]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var totalRounding = 0.0;
    try {
      totalRounding = double.tryParse(
              doc[kSummaryModelStoreTotalRounding]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var totalSC = 0.0;
    try {
      totalSC = double.tryParse(
              doc[kSummaryModelStoreTotalSC]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var subTotalPrice = 0.0;
    try {
      subTotalPrice = double.tryParse(
              doc[kSummaryModelStoreSubTotalPrice]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var receiptLevelDiscountPrice = 0.0;
    try {
      receiptLevelDiscountPrice = double.tryParse(
              doc[kSummaryModelStoreReceiptLevelDiscountPrice]?.toString() ??
                  "0.0") ??
          0.0;
    } catch (ex) {}

    var openingFloat = 0.0;
    try {
      openingFloat = double.tryParse(
              doc[kSummaryModelStoreOpeningFloat]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var totalCashOut = 0.0;
    try {
      totalCashOut = double.tryParse(
              doc[kSummaryModelStoreTotalCashOut]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    return SummaryModel(
        id: id,
        openDate: openDate,
        closeDate: closeDate,
        orders: orders,
        stores: stores,

        //report detail
        storeTitle: storeTitle,
        totalQty: totalQty,
        totalPrice: totalPrice,
        voidQty: voidQty,
        voidPrice: voidPrice,
        discountPrice: discountPrice,
        totalTax: totalTax,
        totalTaxInclusive: totalTaxInclusive,
        totalRounding: totalRounding,
        totalSC: totalSC,
        subTotalPrice: subTotalPrice,
        receiptLevelDiscountPrice: receiptLevelDiscountPrice,
        openingFloat: openingFloat,
        totalCashOut: totalCashOut);
  }

  Map<String, dynamic> toMap() {
    return {
      kSummaryModelId: id,
      kSummaryModelOpenDate: openDate ?? "",
      kSummaryModelCloseDate: closeDate ?? "",
      kSummaryModelOrders: firestoreOrderSets(),
      kSummaryModelStores: firestoreStoreSets(),
      kSummaryModelStoreTitle: storeTitle ?? "",
      kSummaryModelStoreTotalQty: totalQty ?? 0,
      kSummaryModelStoreTotalPrice: totalPrice ?? 0.0,
      kSummaryModelStoreVoidQty: voidQty ?? 0,
      kSummaryModelStoreVoidPrice: voidPrice ?? 0.0,
      kSummaryModelStoreDiscountPrice: discountPrice ?? 0.0,
      kSummaryModelStoreTotalTax: totalTax ?? 0.0,
      kSummaryModelStoreTotalTaxInclusive: totalTaxInclusive ?? 0.0,
      kSummaryModelStoreTotalRounding: totalRounding ?? 0.0,
      kSummaryModelStoreTotalSC: totalSC ?? 0.0,
      kSummaryModelStoreSubTotalPrice: subTotalPrice ?? 0.0,
      kSummaryModelStoreReceiptLevelDiscountPrice:
          receiptLevelDiscountPrice ?? 0.0,
      kSummaryModelStoreOpeningFloat: openingFloat ?? 0.0,
      kSummaryModelStoreTotalCashOut: totalCashOut ?? 0.0,
    };
  }

  List<Map<String, dynamic>> firestoreOrderSets() {
    List<Map<String, dynamic>> convertedSets = [];
    orders ??= [];
    for (var set in orders) {
      //OrderItemModel thisSet = set as OrderItemModel;
      try {
        convertedSets.add(set.toMap());
      } catch (ex) {
        print("order set error:" + ex.toString());
      }
    }
    return convertedSets;
  }

  List<Map<String, dynamic>> firestoreStoreSets() {
    List<Map<String, dynamic>> convertedSets = [];
    stores ??= [];
    for (var set in stores) {
      //OrderItemModel thisSet = set as OrderItemModel;
      try {
        convertedSets.add(set.toMap());
      } catch (ex) {
        print("order set error:" + ex.toString());
      }
    }
    return convertedSets;
  }

  addOrder(OrderModel order) {
    orders ??= [];
    orders.add(order);
  }

  addStore(StoreModel storeModel) {
    stores ??= [];
    stores.clear();
    stores.add(storeModel);
  }

  addReportDetail(ZReportModel zReport) {
    storeTitle = zReport?.storeTitle ?? "";
    totalQty = zReport?.totalQty ?? 0;
    totalPrice = zReport?.totalPrice ?? 0.0;
    voidQty = zReport?.voidQty ?? 0;
    voidPrice = zReport?.voidPrice ?? 0.0;
    discountPrice = zReport?.discountPrice ?? 0.0;
    totalTax = zReport?.totalTax ?? 0.0;
    totalTaxInclusive = zReport?.totalTaxInclusive ?? 0.0;
    totalRounding = zReport?.totalRounding ?? 0.0;
    totalSC = zReport?.totalSC ?? 0.0;
    subTotalPrice = zReport?.subTotalPrice ?? 0.0;
    receiptLevelDiscountPrice = zReport?.receiptLevelDiscountPrice ?? 0.0;
    openingFloat = zReport?.openingFloat ?? 0.0;
    totalCashOut = zReport?.totalCashOut ?? 0.0;
  }
}
