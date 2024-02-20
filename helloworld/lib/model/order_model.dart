

import 'dart:collection';
import 'package:firedart/firedart.dart';
import 'package:helloworld/constant.dart';
import 'package:helloworld/model/kds_status_model.dart';
import 'package:helloworld/model/orderitem_model.dart';
import 'package:helloworld/util_datetime.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const kOrderModelId = 'id'; //generated from uuid
const kOrderModelStoreId = 'storeid';
const kOrderModelStoreImg = 'storeimg';
const kOrderModelStoreTitle = 'storetitle';
const kOrderModelStoreAddress = 'storeaddress';
const kOrderModelStoreIsOpen = 'storeisopen';
const kOrderModelTotalQty = "totalqty";
const kOrderModelTotalPrice = "totalprice";
const kOrderModelTotalPaid = "totalpaid";
const kOrderModelRounding = "roundng";
const kOrderModelTax = "tax";
const kOrderModelTaxInclusive = "taxinclusive";
const kOrderModelServiceCharge = "servicecharge";
const kOrderModelTotalChanged = "totalchanged";
const kOrderModelTotalDiscount = "totaldiscount";
const kOrderModelReceiptDiscount = "receiptdiscount";
const kOrderModelOrderId = 'orderid'; //generated from timestamp unix
const kOrderModelStatus = "status";
const kOrderModelPaymentStatus = "paymentstatus"; //0 paid, -1 void -2 refunded
const kOrderModelOrderDateTime = "orderdatetime";
const kOrderModelTransactionDetail = "transactiondetail";
const kOrderModelPaymentType = "paymenttype";
const kOrderModelTimeSlot = "timeslot";
const kOrderModelDeliveryOption = "deliveryoption"; // "" if self pickup
const kOrderModelMobileAssignedTable = "mobileassignedtable";
const kOrderModelOrderYear = "orderyear";
const kOrderModelOrderMonth = "ordermonth";
const kOrderModelOrderDay = "orderday";
const kOrderModelOrderHour = "orderhour";

const kOrderModelOrderItems = "orderitems";
//juz4payment v2
const kOrderModelTransactionId = "transactionid";
const kOrderModelVoucher = "voucher";

//pax
const kOrderModelPax = "pax";

//v3 combined order
const kOrderModelOrders = "orders";

//v4
const kOrderModelUserPhoneNumber = "userphonenumber";
const kOrderModelName = "name";
const kOrderModelEmail = "email";
const kOrderModelEPaymentType = "epaymenttype";
const kOrderModelEPaymentDetail = "epaymentdetail";

//v5
const kOrderModelIsOnHold = "isonhold";
const kOrderModelServerId = "serverid";

//v6
const kOrderModelOrderCollectedDateTime = "collecteddatetime";

//v7
const kOrderModelPaymentVouchers = "paymentvouchers";

const kOrderModelKDSStatusList = "kdsstatuslist";
const kOrderModelType = "ordertype"; //dine in or take away
//v8
const kOrderModelCashAmount = "cashamount";
const kOrderModelEPayAmount = "epayamount";
const kOrderModelCashVoucherAmount = "cashvoucheramount";

//v9
const kOrderModeliPayTransId = "ipaytransid";

//v10
const kOrderModelVariant = "ordervariant"; //0 prime, 1 copy use for order slip
//v11
const kOrderModelRecentOrderItems =
    "recentorderitems"; //this is to keep the last save order items , used in order on hold

//v12
const kOrderModelFromOnline = "orderfromonline";
const kOrderModelOnlineOrderId = "onlineorderid";

//ticket type
const kOrderTypeDineIn = 0;
const kOrderTypeTakeAway = 1;
const kOrderNoSelection = -1;

class OrderModel {
  late String id;
   String? storeId;
  late String storeTitle;
  late String storeAddress;
  late String storeImg;
  late bool storeIsOpen;
  late String orderDateTime;
   String? orderId;
  late String totalQty;
  late String
      totalPrice; //final pricing after all discount, receipt discount and rounding
  late String totalRounding;
  late String totalTax;
  late String totalTaxInclusive;
  late String totalServiceCharge;
  late String totalDiscount;
  late  String totalPaid;
  late String totalChanged;
  late double receiptDiscount;
  late String paymentType;
  late String transactionDetail;
  late String timeSlot;
  late int status = kStatusStart; //this is order status
  late int paymentStatus = kPaid;
  late String deliveryOption;
  late String mobileAssignedTable; //table assigned with foodio mobile

  late String transactionId;
  late String voucher;

  late String orderYear;
  late String orderMonth;
  late String orderDay;
  late String orderHour;
  late List<dynamic> orderItems = [];
  late List<dynamic> orders = [];
  //List<OrderItemModel> orderItemList = [];

  late  int pax;

  //v4
  late String name;
  late String userPhoneNumber;
  late String email;
  late String ePaymentType;
  late String ePaymentDetail;

  //v5
  late bool isOrderOnHold;
  late String serverId;

  //v6
  late  String collectedDateTime;

  //v7
  late String paymentVouchers;
  late int orderType = kOrderTypeTakeAway;
  late List<dynamic> kdsStatusList = [];

  //v8
  late String cashAmount;
  late String ePayAmount;
  late String cashVoucherAmount;

  //v9
  late String iPayTransId;

  //v10
  late int orderVariant;

  //v11
  late List<dynamic> orderItemsRecent = [];

  //v13
  late bool orderFromOnline;
  late String onlineOrderId;

  OrderModel({
     required this.id,
    required this.storeId,
    required this.storeTitle,
    required this.storeAddress,
    required this.storeImg,
    required  this.storeIsOpen,
    required  this.orderId,
    required  this.orderDateTime,
    required  this.totalQty,
    required this.totalPrice,
    required this.totalRounding,
    required this.totalTax,
    required this.totalTaxInclusive,
    required this.totalServiceCharge,
    required  this.totalPaid,
    required this.totalChanged,
    required this.totalDiscount,
    required  this.receiptDiscount,
    required  this.paymentType,
    required  this.transactionDetail,
    required  this.timeSlot,
    required  this.status,
    required  this.paymentStatus,
    required  this.deliveryOption,
    required  this.transactionId,
    required  this.mobileAssignedTable,
    required  this.voucher,
    required  this.orderYear,
    required  this.orderMonth,
    required  this.orderDay,
    required  this.orderHour,
    required  this.orderItems,
    required  this.orders,
    required  this.pax,

    //v4
    required  this.userPhoneNumber,
    required  this.name,
    required  this.email,
    required  this.ePaymentType,
    required  this.ePaymentDetail,

    //v5
    required  this.isOrderOnHold,
    required  this.serverId,

    //v6
    required  this.collectedDateTime,

    //v7
    required  this.paymentVouchers,
    required   this.orderType,
    required  this.kdsStatusList,

    //v8
    required  this.cashAmount,
    required  this.ePayAmount,
    required  this.cashVoucherAmount,

    //v9
    required  this.iPayTransId,

    //v10
    required  this.orderVariant,

    //v11
    required  this.orderItemsRecent,

    //v13
    required  this.orderFromOnline,
    required  this.onlineOrderId,
  });

  factory OrderModel.newVariant(OrderModel orderModel, List<dynamic> itemList) {
    return OrderModel(
      id: "O_" + Uuid().v4(),
      storeId: orderModel.storeId,
      storeTitle: orderModel.storeTitle,
      storeAddress: orderModel.storeAddress,
      storeImg: orderModel.storeImg,
      storeIsOpen: orderModel.storeIsOpen,
      orderId: orderModel.orderId,
      orderDateTime: DateTime.now().toString(),
      orderYear: DateTime.now().year.toString(),
      orderMonth: DateTime.now().month.toString(),
      orderDay: DateTime.now().day.toString(),
      orderHour: DateTime.now().hour.toString(),
      timeSlot: orderModel.timeSlot,
      mobileAssignedTable: orderModel.mobileAssignedTable,
      status: orderModel.status,
      deliveryOption: orderModel.deliveryOption,
      paymentStatus: orderModel.paymentStatus,
      transactionId: orderModel.transactionId,
      voucher: orderModel.voucher,
      pax: orderModel.pax,
      ePaymentType: orderModel.ePaymentType,
      ePaymentDetail: orderModel.ePaymentDetail,
      userPhoneNumber: orderModel.userPhoneNumber,
      name: orderModel.name,
      email: orderModel.email,
      receiptDiscount: orderModel.receiptDiscount,
      //v5
      isOrderOnHold: orderModel.isOrderOnHold,
      serverId: orderModel.serverId,
      //v6
      collectedDateTime: orderModel.collectedDateTime,
      //v7
      paymentVouchers: orderModel.paymentVouchers,
      transactionDetail: orderModel.transactionDetail,
      orderType: orderModel.orderType,
      //v8
      cashAmount: orderModel.cashAmount,
      ePayAmount: orderModel.ePayAmount,
      cashVoucherAmount: orderModel.cashVoucherAmount,
      //v9
      iPayTransId: orderModel.iPayTransId,

      //v10
      orderVariant: 1, //1 as variant

      orderItems: itemList,
      orderItemsRecent: [],
      //v13
      orderFromOnline: orderModel.orderFromOnline ?? false,
      onlineOrderId: orderModel.onlineOrderId ?? "",


      totalChanged: '0', totalRounding: '0', totalTax: '0', paymentType: '$kPayByCash', totalPaid: '0', totalServiceCharge: '0', totalPrice: '0', totalQty: '0', totalTaxInclusive: '0', totalDiscount: '0', orders: [], kdsStatusList: [],
    );
  }



  factory OrderModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kOrderModelId] ?? "";
    } catch (ex) {}

    var storeId = "";
    try {
      storeId = doc[kOrderModelStoreId] ?? "";
    } catch (ex) {}

    var storeTitle = "";
    try {
      storeTitle = doc[kOrderModelStoreTitle] ?? "";
    } catch (ex) {}

    var storeAddress = "";
    try {
      storeAddress = doc[kOrderModelStoreAddress] ?? "";
    } catch (ex) {}

    var storeImg = "";
    try {
      storeImg = doc[kOrderModelStoreImg] ?? "";
    } catch (ex) {}

    var storeIsOpen = false;
    try {
      storeIsOpen = doc[kOrderModelStoreIsOpen] ?? false;
    } catch (ex) {}

    var orderId = "";
    try {
      orderId = doc[kOrderModelOrderId] ?? "";
    } catch (ex) {}

    var totalQty = "0";
    try {
      totalQty = doc[kOrderModelTotalQty] ?? "0";
    } catch (ex) {}

    var totalPrice = "0.0";
    try {
      totalPrice = doc[kOrderModelTotalPrice] ?? "0.0";
    } catch (ex) {}

    var totalRounding = "0.0";
    try {
      totalRounding = doc[kOrderModelRounding] ?? "0.0";
    } catch (ex) {}

    var totalTax = "0.0";
    try {
      totalTax = doc[kOrderModelTax] ?? "0.0";
    } catch (ex) {}

    var totalTaxInclusive = "0.0";
    try {
      totalTaxInclusive = doc[kOrderModelTaxInclusive] ?? "0.0";
    } catch (ex) {}

    var totalServiceCharge = "0.0";
    try {
      totalServiceCharge = doc[kOrderModelServiceCharge] ?? "0.0";
    } catch (ex) {}

    var totalPaid = "0.0";
    try {
      totalPaid = doc[kOrderModelTotalPaid] ?? "0.0";
    } catch (ex) {}

    var totalChanged = "0.0";
    try {
      totalChanged = doc[kOrderModelTotalChanged] ?? "0.0";
    } catch (ex) {}

    var totalDiscount = "0.0";
    try {
      totalDiscount = doc[kOrderModelTotalDiscount] ?? "0.0";
    } catch (ex) {}

    var receiptDiscount = 0.0;
    try {
      receiptDiscount = double.tryParse(
              doc[kOrderModelReceiptDiscount]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var status = kStatusStart;
    try {
      status = doc[kOrderModelStatus] ?? kStatusStart;
    } catch (ex) {}

    var orderDateTime = "";
    try {
      orderDateTime = doc[kOrderModelOrderDateTime] ?? "";
    } catch (ex) {}

    var timeSlot = "";
    try {
      timeSlot = doc[kOrderModelTimeSlot] ?? "";
    } catch (ex) {}

    var transactionDetail = "";
    try {
      transactionDetail = doc[kOrderModelTransactionDetail] ?? "";
    } catch (ex) {}

    var mobileAssignedTable = "";
    try {
      mobileAssignedTable = doc[kOrderModelMobileAssignedTable] ?? "";
    } catch (ex) {}

    var paymentType = "";
    try {
      paymentType = doc[kOrderModelPaymentType] ?? "";
    } catch (ex) {}

    var deliveryOption = "";
    try {
      deliveryOption = doc[kOrderModelDeliveryOption] ?? "";
    } catch (ex) {}

    var orderYear = "";
    try {
      orderYear = doc[kOrderModelOrderYear] ?? "";
    } catch (ex) {}

    var orderMonth = "";
    try {
      orderMonth = doc[kOrderModelOrderMonth] ?? "";
    } catch (ex) {}

    var orderDay = "";
    try {
      orderDay = doc[kOrderModelOrderDay] ?? "";
    } catch (ex) {}

    var orderHour = "";
    try {
      orderHour = doc[kOrderModelOrderHour] ?? "";
    } catch (ex) {}

    var paymentStatus = kUnPaid;
    try {
      paymentStatus = doc[kOrderModelPaymentStatus] ?? kUnPaid;
    } catch (ex) {}

    var transactionId = "";
    try {
      transactionId = doc[kOrderModelTransactionId] ?? "";
    } catch (ex) {}

    var voucher = "";
    try {
      voucher = doc[kOrderModelVoucher] ?? "";
    } catch (ex) {}

    var pax = 1;
    try {
      pax = doc[kOrderModelPax] ?? 1;
    } catch (ex) {}
    //v4
    var ePaymentType = "";
    try {
      ePaymentType = doc[kOrderModelEPaymentType] ?? "";
    } catch (ex) {}

    var ePaymentDetail = "";
    try {
      ePaymentDetail = doc[kOrderModelEPaymentDetail] ?? "";
    } catch (ex) {}

    var userPhoneNumber = "";
    try {
      userPhoneNumber = doc[kOrderModelUserPhoneNumber] ?? "";
    } catch (ex) {}

    var name = "";
    try {
      name = doc[kOrderModelName] ?? "";
    } catch (ex) {}

    var email = "";
    try {
      email = doc[kOrderModelEmail] ?? "";
    } catch (ex) {}
    //v5
    var isOrderOnHold = false;
    try {
      isOrderOnHold = doc[kOrderModelIsOnHold] ?? false;
    } catch (ex) {}

    var serverId = "";
    try {
      serverId = doc[kOrderModelServerId] ?? "";
    } catch (ex) {}

    var orderItems = [];
    try {
      orderItems = (doc[kOrderModelOrderItems] != null)
          ? doc[kOrderModelOrderItems].map((set) {
              return OrderItemModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}

    var orders = [];
    try {
      orders = (doc[kOrderModelOrders] != null)
          ? doc[kOrderModelOrders].map((set) {
              return OrderModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}
    //v6
    var collectedDateTime = "";
    try {
      collectedDateTime = doc[kOrderModelOrderCollectedDateTime] ?? "";
    } catch (ex) {}
    //v7
    var paymentVouchers = "";
    try {
      paymentVouchers = doc[kOrderModelPaymentVouchers] ?? "";
    } catch (ex) {}

    var orderType = kOrderTypeTakeAway;
    try {
      orderType = doc[kOrderModelType] ?? kOrderTypeTakeAway;
    } catch (ex) {}

    var kdsStatusList = [];
    try {
      kdsStatusList = (doc[kOrderModelKDSStatusList] != null)
          ? doc[kOrderModelKDSStatusList].map((set) {
              return KDSStatusModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}
    //v8
    var cashAmount = "0.0";
    try {
      cashAmount = doc[kOrderModelCashAmount] ?? "0.0";
    } catch (ex) {}

    var ePayAmount = "0.0";
    try {
      ePayAmount = doc[kOrderModelEPayAmount] ?? "0.0";
    } catch (ex) {}

    var cashVoucherAmount = "0.0";
    try {
      cashVoucherAmount = doc[kOrderModelCashVoucherAmount] ?? "0.0";
    } catch (ex) {}

    //v9
    var iPayTransId = "";
    try {
      iPayTransId = doc[kOrderModeliPayTransId] ?? "";
    } catch (ex) {}

    //v10
    var orderVariant = 0;
    try {
      orderVariant = doc[kOrderModelVariant] ?? 0; //0 as prime by default
    } catch (ex) {}
    //v11
    var orderItemsRecent = [];
    try {
      orderItemsRecent = (doc[kOrderModelRecentOrderItems] != null)
          ? doc[kOrderModelRecentOrderItems].map((set) {
              return OrderItemModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}
    //v13
    var orderFromOnline = false;
    try {
      orderFromOnline = doc[kOrderModelFromOnline] ?? false;
    } catch (ex) {}

    var onlineOrderId = "";
    try {
      onlineOrderId = doc[kOrderModelOnlineOrderId] ?? "";
    } catch (ex) {}

    return OrderModel(
      id: id,
      storeId: storeId,
      storeTitle: storeTitle,
      storeAddress: storeAddress,
      storeImg: storeImg,
      storeIsOpen: storeIsOpen,
      orderId: orderId,
      totalQty: totalQty,
      totalPrice: totalPrice,
      totalRounding: totalRounding,
      totalTax: totalTax,
      totalTaxInclusive: totalTaxInclusive,
      totalServiceCharge: totalServiceCharge,
      totalPaid: totalPaid,
      totalChanged: totalChanged,
      totalDiscount: totalDiscount,
      receiptDiscount: receiptDiscount,

      status: status,
      orderDateTime: orderDateTime,
      timeSlot: timeSlot,
      transactionDetail: transactionDetail,
      mobileAssignedTable: mobileAssignedTable,
      paymentType: paymentType,
      deliveryOption: deliveryOption,
      orderYear: orderYear,
      orderMonth: orderMonth,
      orderDay: orderDay,
      orderHour: orderHour,
      paymentStatus: paymentStatus,
      transactionId: transactionId,
      voucher: voucher,
      pax: pax,
      //v4
      ePaymentType: ePaymentType,
      ePaymentDetail: ePaymentDetail,
      userPhoneNumber: userPhoneNumber,
      name: name,
      email: email,
      //v5
      isOrderOnHold: isOrderOnHold,
      serverId: serverId,

      orderItems: orderItems,
      orders: orders,
      //v6
      collectedDateTime: collectedDateTime,
      //v7
      paymentVouchers: paymentVouchers,

      orderType: orderType,
      kdsStatusList: kdsStatusList,

      //v8
      cashAmount: cashAmount,
      ePayAmount: ePayAmount,
      cashVoucherAmount: cashVoucherAmount,
      //v9
      iPayTransId: iPayTransId,
      //v10
      orderVariant: orderVariant, //0 as prime by default
      //v11
      orderItemsRecent: orderItemsRecent,
      //v13
      orderFromOnline: orderFromOnline,
      onlineOrderId: onlineOrderId,
    );
  }

//  factory OrderModel.formMap(Map<dynamic, dynamic> map) {
//    return OrderModel(
//        id: map[kOrderModelId],
//        storeId: map[kOrderModelStoreId],
//        storeTitle: map[kOrderModelStoreTitle],
//        storeAddress: map[kOrderModelStoreAddress],
//        storeImg: map[kOrderModelStoreImg],
//        storeIsOpen: map[kOrderModelStoreIsOpen],
//        orderId: map[kOrderModelOrderId],
//        totalQty: map[kOrderModelTotalQty],
//        totalPrice: map[kOrderModelTotalPrice],
//        status: map[kOrderModelStatus],
//        orderDateTime: map[kOrderModelOrderDateTime],
//        timeSlot: map[kOrderModelTimeSlot],
//        transactionDetail: map[kOrderModelTransactionDetail],
//        paymentType: map[kOrderModelPaymentType] ?? "",
//        deliveryOption: map[kOrderModelDeliveryOption],
//        orderYear: map[kOrderModelOrderYear],
//        orderMonth: map[kOrderModelOrderMonth],
//        orderDay: map[kOrderModelOrderDay],
//        orderHour: map[kOrderModelOrderHour],
//        paymentStatus: map[kOrderModelPaymentStatus],
//        orderItemList: map[kOrderModelOrderItemList].map((set) {
//      return OrderItemModel.fromMap(set); }).toList(),
//  }

  Map<String, dynamic> toMap() {
    try {
      return {
        kOrderModelId: id,
        kOrderModelStoreId: storeId,
        kOrderModelStoreTitle: storeTitle,
        kOrderModelStoreAddress: storeAddress,
        kOrderModelStoreImg: storeImg,
        kOrderModelStoreIsOpen: storeIsOpen,
        kOrderModelOrderId: orderId,
        kOrderModelTotalQty: getOrderItemCount().toString(),
        kOrderModelTotalPrice: getTotal().toStringAsFixed(2),
        kOrderModelTotalPaid: totalPaid ?? "0.0",
        kOrderModelRounding: totalRounding ?? "0.0",
        kOrderModelTax: totalTax ?? "0.0",
        kOrderModelTaxInclusive: totalTaxInclusive ?? "0.0",
        kOrderModelServiceCharge: totalServiceCharge ?? "0.0",
        kOrderModelTotalChanged: totalChanged ?? "0.0",
        kOrderModelTotalDiscount: getTotalDiscount().toStringAsFixed(2),
        kOrderModelReceiptDiscount: receiptDiscount ?? 0.0,
        kOrderModelStatus: status,
        kOrderModelOrderDateTime: orderDateTime,
        kOrderModelTimeSlot: timeSlot,
        kOrderModelTransactionDetail: transactionDetail,
        kOrderModelMobileAssignedTable: mobileAssignedTable ?? "",
        kOrderModelPaymentType: paymentType ?? "",
        kOrderModelDeliveryOption: deliveryOption,
        kOrderModelOrderYear: orderYear,
        kOrderModelOrderMonth: orderMonth,
        kOrderModelOrderDay: orderDay,
        kOrderModelOrderHour: orderHour,
        kOrderModelPaymentStatus: paymentStatus,
        kOrderModelTransactionId: transactionId ?? "",
        kOrderModelVoucher: voucher ?? "",
        kOrderModelPax: pax ?? 1,
        kOrderModelEPaymentType: ePaymentType ?? "",
        kOrderModelEPaymentDetail: ePaymentDetail ?? "",
        kOrderModelUserPhoneNumber: userPhoneNumber ?? "",
        kOrderModelName: name ?? "",
        kOrderModelEmail: email ?? "",
        kOrderModelIsOnHold: isOrderOnHold ?? false,
        kOrderModelServerId: serverId ?? "",
        kOrderModelOrderItems: firestoreOrderItems(),
        kOrderModelOrders: firestoreOrderSets(),
        //v6
        kOrderModelOrderCollectedDateTime: collectedDateTime ?? "",
        //v7
        kOrderModelPaymentVouchers: paymentVouchers ?? "",

        kOrderModelType: orderType ?? kOrderTypeTakeAway,
        kOrderModelKDSStatusList: firestoreKdsStatusSets(),
        //v8
        kOrderModelCashAmount: cashAmount ?? "0.0",
        kOrderModelEPayAmount: ePayAmount ?? "0.0",
        kOrderModelCashVoucherAmount: cashVoucherAmount ?? "0.0",
        //v9
        kOrderModeliPayTransId: iPayTransId ?? "",
        //v10
        kOrderModelVariant: orderVariant ?? 0, //0 as prime by default
        //v11
        kOrderModelRecentOrderItems: firestoreOrderItemsRecent(),
        //V13
        kOrderModelFromOnline: orderFromOnline ?? false,
        kOrderModelOnlineOrderId: onlineOrderId ?? "",
      };
    } catch (ex) {
      print("orderModer.toMap error:" + ex.toString());
      return {};
    }
  }

  OrderModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kOrderModelId],
        storeId = map[kOrderModelStoreId],
        storeTitle = map[kOrderModelStoreTitle],
        storeAddress = map[kOrderModelStoreAddress],
        storeImg = map[kOrderModelStoreImg],
        storeIsOpen = map[kOrderModelStoreIsOpen],
        orderId = map[kOrderModelOrderId],
        totalQty = map[kOrderModelTotalQty],
        totalPrice = map[kOrderModelTotalPrice],
        totalRounding = map[kOrderModelRounding] ?? "0.0",
        totalTax = map[kOrderModelTax] ?? "0.0",
        totalTaxInclusive = map[kOrderModelTaxInclusive] ?? "0.0",
        totalServiceCharge = map[kOrderModelServiceCharge] ?? "0.0",
        totalPaid = map[kOrderModelTotalPaid] ?? "0.0",
        totalChanged = map[kOrderModelTotalChanged] ?? "0.0",
        totalDiscount = map[kOrderModelTotalDiscount] ?? "0.0",
        receiptDiscount = double.tryParse(
                map[kOrderModelReceiptDiscount]?.toString() ?? "0.0") ??
            0.0,
        status = map[kOrderModelStatus],
        orderDateTime = map[kOrderModelOrderDateTime],
        timeSlot = map[kOrderModelTimeSlot],
        transactionDetail = map[kOrderModelTransactionDetail],
        mobileAssignedTable = map[kOrderModelMobileAssignedTable] ?? "",
        paymentType = map[kOrderModelPaymentType] ?? "",
        deliveryOption = map[kOrderModelDeliveryOption],
        orderYear = map[kOrderModelOrderYear],
        orderMonth = map[kOrderModelOrderMonth],
        orderDay = map[kOrderModelOrderDay],
        orderHour = map[kOrderModelOrderHour],
        paymentStatus = map[kOrderModelPaymentStatus],
        transactionId = map[kOrderModelTransactionId] ?? "",
        voucher = map[kOrderModelVoucher] ?? "",
        pax = map[kOrderModelPax] ?? 1,
        ePaymentDetail = map[kOrderModelEPaymentDetail] ?? "",
        ePaymentType = map[kOrderModelEPaymentType] ?? "",
        userPhoneNumber = map[kOrderModelUserPhoneNumber] ?? "",
        name = map[kOrderModelName] ?? "",
        email = map[kOrderModelEmail] ?? "",
        isOrderOnHold = map[kOrderModelIsOnHold] ?? false,
        serverId = map[kOrderModelServerId] ?? "",
        orderItems = (map[kOrderModelOrderItems] != null)
            ? map[kOrderModelOrderItems].map((set) {
                return OrderItemModel.fromMap(set);
              }).toList()
            : [],
        orders = (map[kOrderModelOrders] != null)
            ? map[kOrderModelOrders].map((set) {
                return OrderModel.fromMap(set);
              }).toList()
            : [],
        //v6
        collectedDateTime = map[kOrderModelOrderCollectedDateTime] ?? "",
        //v7
        paymentVouchers = map[kOrderModelPaymentVouchers] ?? "",
        orderType = map[kOrderModelType] ?? kOrderTypeTakeAway,
        kdsStatusList = (map[kOrderModelKDSStatusList] != null)
            ? map[kOrderModelKDSStatusList].map((set) {
                return KDSStatusModel.fromMap(set);
              }).toList()
            : [],
        //v8
        cashAmount = map[kOrderModelCashAmount] ?? "0.0",
        ePayAmount = map[kOrderModelEPayAmount] ?? "0.0",
        cashVoucherAmount = map[kOrderModelCashVoucherAmount] ?? "0.0",
        iPayTransId = map[kOrderModeliPayTransId] ?? "",
        orderVariant = map[kOrderModelVariant] ?? 0, //0 as prime by default
        orderItemsRecent = (map[kOrderModelRecentOrderItems] != null)
            ? map[kOrderModelRecentOrderItems].map((set) {
                return OrderItemModel.fromMap(set);
              }).toList()
            : [],
        orderFromOnline = map[kOrderModelFromOnline] ?? false,
        onlineOrderId = map[kOrderModelOnlineOrderId] ?? "";

  List<Map<String, dynamic>> firestoreOrderItems() {
    List<Map<String, dynamic>> convertedSets = [];
    if (orderItems == null) {
      orderItems = [];
    }
    for (var set in orderItems) {
      //this.orderItems.forEach((set) {
      //OrderItemModel thisSet = set as OrderItemModel;
      convertedSets.add(set.toMap());
    }

    return convertedSets;
  }

  List<Map<String, dynamic>> firestoreOrderItemsRecent() {
    List<Map<String, dynamic>> convertedSets = [];
    orderItemsRecent ??= [];
    for (var set in orderItemsRecent) {
      // this.orderItemsRecent.forEach((set) {
      //OrderItemModel thisSet = set as OrderItemModel;
      convertedSets.add(set.toMap());
    }
    return convertedSets;
  }

  List<Map<String, dynamic>> firestoreOrderSets() {
    List<Map<String, dynamic>> convertedSets = [];
    orders ??= [];

    for (var set in orders) {
      //this.orders.forEach((set) {
      //OrderItemModel thisSet = set as OrderItemModel;
      try {
        convertedSets.add(set.toMap());
      } catch (ex) {
        print("order set error:" + ex.toString());
      }
    }

    return convertedSets;
  }

  List<Map<String, dynamic>> firestoreKdsStatusSets() {
    List<Map<String, dynamic>> convertedSets = [];
    kdsStatusList ??= [];
    for (var set in kdsStatusList) {
      //OrderItemModel thisSet = set as OrderItemModel;
      convertedSets.add(set.toMap());
    }
    return convertedSets;
  }

  String getPaymentTypeName() {
    String paymentType = "razor";
    if (paymentType == "0") {
      paymentType = "razor";
    } else if (paymentType == "1") {
      paymentType = "ipay";
    } else if (paymentType == "2") {
      paymentType = "COD";
    } else if (paymentType == "3") {
      paymentType = "epayment"; //"epayment";
    }

    return paymentType;
  }

  String getCombinedOrderId() {
    if (orders == null) {
      return "";
    }

    String returnValue = "";
    int iCount = 0;
    for (var order in orders) {
      if (iCount == 0) {
        returnValue = order.orderId;
      } else {
        returnValue = "$returnValue + ${order.orderId}";
      }
      iCount++;
    }

    return returnValue;
  }

  void setStatus(int status) {
    this.status = status;
  }

  int getStatus() {
    return this.status;
  }

  bool isStoreAssigned() {
    if (storeId == null) {
      return false;
    }

    return true;
  }

  bool isOrderValid() {
    if (storeId == null) {
      return false;
    }

    return true;
  }

//  setStoreModel(StoreModel storeModel) {
//    this.storeId = storeModel.id;
//    this.storeTitle = storeModel.title;
//    this.storeAddress = storeModel.address;
//  }

  setCompleted() {
    orderId = null;
    storeId = null;
    totalQty = "0";
    mobileAssignedTable = "";
    orderItems?.clear();
    orders?.clear();
    //orderItemList.clear();
  }

  bool isOnlineOrder() {
    if ((onlineOrderId ?? "") != "") {
      return true;
    }

    return false;
  }

  // double getMenuAddedWeight(MenuModel menuModel) {
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   double totalWeight = 0.0;
  //   for (int i = 0; i < orderItems.length; i++) {
  //     if (orderItems[i].menuId == menuModel.id) {
  //       //if ((orderItems[i]?.modInfo ?? "") == "") {
  //       totalWeight = totalWeight + orderItems[i].weight;
  //       //}
  //     }
  //   }
  //
  //   return totalWeight;
  // }

//   int isMenuAdded(MenuModel menuModel) {
//     if (orderItems == null) {
//       orderItems = [];
//     }
//
// //    if (orders == null) {
// //      orders = [];
// //    }
// //
// //    var orderList = orderItems;
// //    for (var orderElement in orders) {
// //      try {
// //        final order = orderElement as OrderModel;
// //        for (var itemElement in order.getOrderItems()) {
// //          orderList.add(itemElement);
// //        }
// //      } catch (ex) {
// //        print(ex.toString());
// //      }
// //    }
//
//     int totalQty = 0;
//     for (int i = 0; i < orderItems.length; i++) {
//       if (orderItems[i].menuId == menuModel.id) {
//         //if ((orderItems[i]?.modInfo ?? "") == "") {
//         totalQty = totalQty + orderItems[i].qty;
//         //}
//       }
//     }
//
//     return totalQty;
//   }

  //add order, for combined receipt
  String getChildOrderId() {
    String orderId = "";
    orders ??= [];

    for (var element in orders) {
      final order = element as OrderModel;
      if (orderId == "") {
        orderId = order?.orderId ?? "";
      } else {
        orderId = orderId + "," + (order?.orderId ?? "");
      }
    }

    return orderId;
  }

  addOrder(OrderModel orderModel) {
    orders ??= [];

    bool bFound = false;
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].id == orderModel.id) {
        bFound = true;
        break;
      }
    }

    if (bFound == false) {
      orders.add(orderModel);
    }
  }

  removeOrder(OrderModel orderModel) {
    orders ??= [];

    bool bFound = false;
    for (int i = orders.length - 1; i >= 0; i--) {
      if (orders[i].id == orderModel.id) {
        bFound = true;
        break;
      }
    }
  }

  //order items
  List<dynamic> getOrderItems() {
    orderItems ??= [];

    return orderItems;
  }

  addOrderWeightItem(OrderItemModel orderItemModel) {
    orderItems ??= [];

    bool bFound = false;
    for (int i = 0; i < orderItems.length; i++) {
      if (orderItems[i].menuId == orderItemModel.menuId) {
        orderItems[i].weight = orderItemModel.weight;
        orderItems[i].price = orderItemModel.price;
        bFound = true;
        break;
      }
    }

    if (bFound == false) {
      orderItems.add(orderItemModel);
    }
  }

  //use for on hold order
  //to keep track of the last order items saved in fs
  updateRecentOrderItems() {
    orderItemsRecent.clear();
    for (var orderItem in orderItems) {
      print("updateRecentOrderItems orderitem.id ${orderItem.id}");
      orderItemsRecent.add(orderItem);
    }
  }

  //use for on hold order
  //to retrieve the newly added order item
  List<dynamic> getNewlyAddedOrderItem() {
    List<dynamic> itemList = [];

    orderItemsRecent ??= [];

    for (var orderItem in orderItems) {
      //compare with old item
      var cItem = orderItem as OrderItemModel;
      var newItem = OrderItemModel.fromMap(cItem.toMap());
      newItem.id = "I_" + Uuid().v4(); //give a new id for newly added item
      bool bFound = false;

      for (var oldItem in orderItemsRecent) {
        var oItem = oldItem as OrderItemModel;
        print("recent item ${oItem.menuId} vs orders item ${cItem.menuId}");
        if (oItem.menuId == cItem.menuId) {
          if (cItem.qty != oItem.qty) {
            bFound = false;
            newItem.qty = cItem.qty - oItem.qty;
            break;
          } else {
            if ((cItem.modInfo == oItem.modInfo)) {
              bFound = true;
              break;
            }
          }
        }
      }

      if (bFound == false) {
        newItem.orderId = orderId ?? "";
        itemList.add(newItem);
      }
    }

    return itemList;
  }

  List<dynamic> getNewlyRemovedOrderItem() {
    List<dynamic> itemList = [];

    orderItemsRecent ??= [];

    for (var orderItem in orderItemsRecent) {
      //compare with old item
      var cItem = orderItem as OrderItemModel;
      var recentItem = OrderItemModel.fromMap(cItem.toMap());
      recentItem.id = "I_" + Uuid().v4(); //give a new id for newly added item
      bool bFound = false;

      for (var oldItem in orderItems) {
        var oItem = oldItem as OrderItemModel;
        //print("recent item ${oItem.id} vs orders item ${cItem.id}");
        if (oItem.menuId == cItem.menuId) {
          bFound = true;
          break;
        }
      }

      if (bFound == false) {
        recentItem.orderId = orderId ?? "";
        recentItem.qty = recentItem.qty * -1;
        itemList.add(recentItem);
      }
    }

    return itemList;
  }

  // addOrderItem(OrderItemModel orderItemModel) {
  //   orderItems ??= [];
  //
  //   bool bFound = false;
  //   //if this is not set, then you can combile the order into same menu, if it is set then
  //   //appear as different item
  //   if (orderItemModel.isSet() == false) {
  //     for (int i = 0; i < orderItems.length; i++) {
  //       if (orderItems[i].menuId == orderItemModel.menuId) {
  //         if (((orderItems[i]?.modInfo ?? "") == "") ||
  //             ((orderItems[i]?.modInfo ?? "") == "null")) {
  //           orderItems[i].qty =
  //               orderItems[i].qty + orderItemModel.qty; //previously only add 1
  //           bFound = true;
  //           break;
  //         }
  //       }
  //     }
  //   }
  //
  //   if (bFound == false) {
  //     orderItems.add(orderItemModel);
  //
  //     //print("addOrderItem ${orderItemModel.id}");
  //   }
  //
  //   //orderItemList = orderItems;
  //   int count = 0;
  //   orderItems.forEach((order) {
  //     count = count + order.qty;
  //     //print("addOrderItem list ${order.id}");
  //   });
  //
  //   totalQty = "$count";
  // }

  // removeOrderItem(OrderItemModel orderItemModel) {
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   bool bFound = false;
  //   for (int i = orderItems.length - 1; i >= 0; i--) {
  //     if (orderItems[i].menuId == orderItemModel.menuId) {
  //       orderItems[i].qty = orderItems[i].qty - 1;
  //       if (orderItems[i].qty <= 0) {
  //         orderItems.removeAt(i);
  //       }
  //       bFound = true;
  //       break;
  //     }
  //   }
  //
  //   int count = 0;
  //   orderItems.forEach((order) {
  //     count = count + order.qty;
  //   });
  //
  //   totalQty = "$count";
  // }

  // wipeOrderItem(OrderItemModel orderItemModel) {
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   bool bFound = false;
  //   for (int i = orderItems.length - 1; i >= 0; i--) {
  //     if (orderItems[i].menuId == orderItemModel.menuId) {
  //       orderItems[i].qty = 0;
  //       if (orderItems[i].qty <= 0) {
  //         orderItems.removeAt(i);
  //       }
  //       bFound = true;
  //       break;
  //     }
  //   }
  //
  //   int count = 0;
  //   orderItems.forEach((order) {
  //     count = count + order.qty;
  //   });
  //
  //   totalQty = "$count";
  // }

  // OrderItemModel convertFromMenu(MenuModel menuModel) {
  //   final orderItemModel = OrderItemModel.fromMenuOrder(
  //       menuModel, 1, orderId, timeSlot, deliveryOption);
  //   return orderItemModel;
  // }

  autoGroupOrderItem(OrderItemModel orderItemModel) {
    bool bFound = false;
    orderItems ??= [];

    for (int i = 0; i < orderItems.length; i++) {
      if (orderItems[i].menuId == orderItemModel.menuId) {
        final currentItemMod = orderItemModel.modInfo ?? "";
        final itemMod = orderItems[i].modInfo ?? "";

        if (currentItemMod != "") {
          if (currentItemMod == itemMod) {
            bFound = true;
            orderItems[i].qty = orderItems[i].qty + orderItemModel.qty;
            break;
          }
        } else {
          //if same menu already exist, but no modifier set
          //if same order item found?
          if (currentItemMod == itemMod) {
            bFound = true;
            orderItems[i].qty = orderItems[i].qty + orderItemModel.qty;
            break;
          }
        }

//        if (orderItems[i].qty == 0) {
//          orderItems.removeAt(i);
//        }

      }
    }

    if (bFound == false) {
      orderItems.add(orderItemModel);
    }

    int count = 0;
    for (var order in orderItems) {
      OrderItemModel orderItemModel = order as OrderItemModel;
      count = count + (orderItemModel?.qty ?? 0);
    }

    totalQty = "$count";
  }

  // updateOrderItem(OrderItemModel orderItemModel) {
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   for (int i = 0; i < orderItems.length; i++) {
  //     if (orderItems[i].id == orderItemModel.id) {
  //       orderItems[i].qty = orderItemModel.qty;
  //
  //       //TODO: confirm that delete is working
  //       if (orderItems[i].qty == 0) {
  //         orderItems.removeAt(i);
  //       }
  //
  //       break;
  //     }
  //   }
  //
  //   int count = 0;
  //   orderItems.forEach((order) {
  //     count = count + order.qty;
  //   });
  //
  //   totalQty = "$count";
  // }

  // addMenuItem(MenuModel menuModel, int qty, Map<int, MenuModel> setMap) {
  //   final orderItemModel = OrderItemModel.fromMenuOrder(
  //       menuModel, qty, orderId, timeSlot, deliveryOption);
  //
  //   orderItemModel.addMenu(1, setMap[0]);
  //   orderItemModel.addMenu(2, setMap[1]);
  //   orderItemModel.addMenu(3, setMap[2]);
  //   orderItemModel.addMenu(4, setMap[3]);
  //   orderItemModel.addMenu(5, setMap[4]);
  //
  //   if (menuModel.getWeight() <= 0) {
  //     addOrderItem(orderItemModel);
  //   } else {
  //     addOrderWeightItem(orderItemModel);
  //   }
  // }

  //different than addMenuItem, addMenuItem will check whether the same menu id already exist. If yes, then any modifier ? if no modifier then increate qty value
  //add unique meaning to add additional one without checking, this is used to add item with special notes.
  // OrderItemModel addUniqMenuItem(MenuModel menuModel, int qty) {
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   final orderItemModel = OrderItemModel.fromMenuOrder(
  //       menuModel, qty, orderId, timeSlot, deliveryOption);
  //   orderItems.add(orderItemModel);
  //
  //   return orderItemModel;
  // }

  // wipeMenuItem(MenuModel menuModel) {
  //   final orderItemModel = OrderItemModel.fromMenuOrder(
  //       menuModel, 1, orderId, timeSlot, deliveryOption);
  //   wipeOrderItem(orderItemModel);
  // }

  // minusMenuItem(MenuModel menuModel) {
  //   //create a temporaly orderItemModel
  //   final orderItemModel = OrderItemModel.fromMenuOrder(
  //       menuModel, 1, orderId, timeSlot, deliveryOption);
  //
  //   removeOrderItem(orderItemModel);
  // }

  // refreshDeliveryNTimeSlotOption() {
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   orderItems.forEach((element) {
  //     element.deliveryOption = deliveryOption;
  //     element.timeSlot = timeSlot;
  //     element.orderDateTime = orderDateTime;
  //   });
  // }

  int getOrderItemCount() {
    orderItems ??= [];

    final totalQtyValue = int.tryParse(totalQty ?? "0") ?? 0;
    if (totalQtyValue > 0) {
      return totalQtyValue;
    }

    int count = 0;
    for (var order in orderItems) {
      OrderItemModel orderItemModel = order as OrderItemModel;
      count = count + (orderItemModel?.qty ?? 0);
    }

    return count;
  }

  // int getMenuItemCount(MenuModel menuModel) {
  //   int count = 0;
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   OrderItemModel returnItem;
  //   orderItems.forEach((element) {
  //     if (element.menuId == (menuModel?.id ?? "")) {
  //       count = count + element.qty;
  //     }
  //   });
  //
  //   return count;
  // }

  // OrderItemModel getOrderItem(MenuModel menuModel) {
  //   if (orderItems == null) {
  //     orderItems = [];
  //   }
  //
  //   OrderItemModel returnItem;
  //   orderItems.forEach((element) {
  //     if (element.menuId == menuModel.id) {
  //       returnItem = element;
  //     }
  //   });
  //
  //   return returnItem;
  // }

  double getTotal({bool withReceiptDiscount = false}) {
    if (orderItems == null) {
      orderItems = [];
    }

    double receiptLevelDiscount = 0.0;
    if (withReceiptDiscount) {
      receiptLevelDiscount = receiptDiscount;
    }

    final totalValue = double.tryParse(totalPrice ?? "0.0") ?? 0;
    if (totalValue > 0) {
      return totalValue;
    }

    double value = 0;
    orderItems.forEach((orderItem) {
      value = value + (orderItem.getTotalPrice());
    });

    value = value - receiptLevelDiscount;
    if (value < 0) {
      value = 0;
    }

    return value;
  }

  double calculateTotalWithAnyDiscount() {
    if (orderItems == null) {
      orderItems = [];
    }

    double value = 0;
    for (var orderItem in orderItems) {
      //orderItems.forEach((orderItem) {
      value = value + (orderItem.getTotalPriceWithoutDiscount());
    }

    return value;
  }

  setReceiptLevelDiscount(double value) {
    receiptDiscount = value;
  }

  //get total menu item discount, excluding receipt level discount which get applied using voucher
  double getTotalDiscount() {
    if (orderItems == null) {
      orderItems = [];
    }

    final totalValue = double.tryParse(totalDiscount ?? "0.0") ?? 0;
    if (totalValue > 0) {
      return totalValue;
    }

    double value = 0;
    orderItems.forEach((orderItem) {
      value = value + orderItem.getDiscount();
    });

    return value;
  }

  double calculateNetTotal() //total prior to tax, service charge and rounding
  {
    orderItems ??= [];

    double value = 0;
    for (var item in orderItems) {
      //orderItems.forEach((orderItem) {
      try {
        final orderItem = item as OrderItemModel;
        var itemPrice = orderItem.getTotalPrice();
        value = value + itemPrice;
      } catch (ex) {}
    }

    if (value < 0) {
      value = 0.0;
    }

    return value;
  }

  double getEPaymentTotal() {
    return double.tryParse(ePayAmount ?? "0.0") ?? 0.0;
  }

  double calculateTotal(bool isRoundingOnlyForCash) {
    double value = calculateNetTotal();

    //print("total net price from payment mode ${value}");

    //v2 added rounding
    double rounding = 0.0;
    //print('check rounding $isRoundingOnlyForCash $isPaymentTypeEPayment()');
    if ((isRoundingOnlyForCash == true) && (isPaymentTypeEPayment() == false)) {
      //print('apply rounding');
      rounding = double.tryParse(totalRounding ?? "0.0") ?? 0.0;
    } else {
      rounding = double.tryParse(totalRounding ?? "0.0") ?? 0.0;
    }
    //v3 added tax
    double tax = double.tryParse(totalTax ?? "0.0") ?? 0.0;
    //v3 added service charge
    double serviceCharge = double.tryParse(totalServiceCharge ?? "0.0") ?? 0.0;

    value = value + tax + serviceCharge;

    value = value -
        receiptDiscount +
        rounding; //adding rounding because rounding it self already with negative

    if (value < 0) {
      value = 0.0;
    }

    totalPrice = value.toStringAsFixed(2);

    return value;
  }

  double calculateGTOSalesTotal(bool isRoundingOnlyForCash) {
    double value = calculateNetTotal();

    //print("total net price from payment mode ${value}");

    //v2 added rounding
    double rounding = 0.0;
    //print('check rounding $isRoundingOnlyForCash $isPaymentTypeEPayment()');
    if ((isRoundingOnlyForCash == true) && (isPaymentTypeEPayment() == false)) {
      //print('apply rounding');
      rounding = double.tryParse(totalRounding ?? "0.0") ?? 0.0;
    } else {
      rounding = double.tryParse(totalRounding ?? "0.0") ?? 0.0;
    }
    //v3 added tax
    double tax = double.tryParse(totalTax ?? "0.0") ?? 0.0;
    //v3 added service charge
    double serviceCharge = double.tryParse(totalServiceCharge ?? "0.0") ?? 0.0;

    value = value + serviceCharge; //value + tax + serviceCharge;

    value = value -
        receiptDiscount +
        rounding; //adding rounding because rounding it self already with negative

    if (value < 0) {
      value = 0.0;
    }

    totalPrice = value.toStringAsFixed(2);

    return value;
  }

  String getOrderType() {
    if (deliveryOption?.contains(gDineIn) ?? false) {
      return gDineIn;
    }

    if (deliveryOption?.contains(gTakeAway) ?? false) {
      return gTakeAway;
    }

    if (deliveryOption?.contains(gSelfPickup) ?? false) {
      return gSelfPickup;
    }

    return gDineIn;
  }

  //for juz4payments

  String getTID(String openDate, String openTime) {
    String ddMMYY = UtilDateTime.getDateTimeString("ddMMyyyy");
    String HHmm = UtilDateTime.getDateTimeString("HHmm");
    if (openDate != null && openDate != "") {
      final openDateValue = UtilDateTime.stringDateTimeToDateTimeWithFormat(
          openDate, "yyyy-MM-dd");
      DateFormat dateFormat = DateFormat("ddMMyyyy");
      final openDateString = dateFormat.format(openDateValue);
      ddMMYY = openDateString;

      if (openTime != null && openTime != "") {
        final openTimeValue = UtilDateTime.stringDateTimeToDateTimeWithFormat(
            openTime, "hh:mm a");
        DateFormat timeFormat = DateFormat("HHmm");
        final openTimeString = timeFormat.format(openTimeValue);
        HHmm = openTimeString;
      }
    }
    String ticketNo = orderId ?? "";
    String sPad = "0";
    String uid = DateTime.now().millisecondsSinceEpoch.toString();

    //print("get TID now ");
    return "$ddMMYY$HHmm$ticketNo";
  }

  final kPaymentTypeRazor = 'razor';
  final kPaymentTypIPay = 'ipay';
  final kPaymentTypeCOD = 'COD';
  final kPaymentTypeEPayment = 'epayment';

  bool isPaymentTypeEPayment() {
    //print("payment type $paymentType");

    if (paymentType == "") {
      return false;
    } else if (paymentType == null) {
      return false;
    } else if (paymentType == kPaymentTypeCOD) {
      return false;
    }

    return true;
  }

  //v7
  setPaymentVouchers(Map<String, double> inputMap) {
    paymentVouchers = "";
    inputMap.forEach((key, value) {
      final keyValue = "$key;$value";
      if (paymentVouchers == "") {
        paymentVouchers = keyValue;
      } else {
        paymentVouchers = paymentVouchers + "," + keyValue;
      }
    });
  }

  Map<String, double> getPaymentVouchers() {
    Map<String, double> returnMap = Map<String, double>();
    final commaSplit = paymentVouchers.split(",");

    if (commaSplit.length > 0) {
      for (var commaItem in commaSplit) {
        if (commaItem != "") {
          final keyValueSplit = commaItem.split(";");
          if (keyValueSplit.length > 1) {
            returnMap[keyValueSplit[0]] =
                double.tryParse(keyValueSplit[1] ?? "0.0") ?? 0.0;
          }
        }
      }
    }

    return returnMap;
  }
}
