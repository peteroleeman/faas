

import 'package:firedart/firedart.dart';
import 'package:helloagain/constant.dart';
import 'package:uuid/uuid.dart';

const kOrderItemModelId = 'id';
const kOrderItemModelMenuId = "menuid";
const kOrderItemModelQty = "quantity";

const kOrderItemModelImg = "img";
const kOrderItemModelTitle = "title";
const kOrderItemModelSubTitle = "subtitle";
const kOrderItemModelRemark = "remark";
const kOrderItemModelPrice = "price";
const kOrderItemModelDiscount = "discount";
const kOrderItemModelDiscountDetail = "discountdetail";
const kOrderItemModelStore = "store";
const kOrderItemModelStoreId = "storeid";
const kOrderItemModelOrderId = "orderid";
const kOrderItemModelModInfo = "modinfo";
const kOrderItemModelModPrice = "modprice";
const kOrderItemModelTimeSlot = "timeslot";
const kOrderItemModelDeliveryOption = "deliveryoption";
const kOrderItemModelOrderDateTime = "orderdatetime";
const kOrderItemModelOrderYear = "orderyear";
const kOrderItemModelOrderMonth = "ordermonth";
const kOrderItemModelOrderDay = "orderday";
const kOrderItemModelOrderHour = "orderhour";
const kOrderItemModelPaymentStatus =
    "paymentstatus"; //0 paid, -1 void -2 refunded
const kOrderItemModelWeight = "weight";

//set configuration
const kOrderItemModelSubmenu1 = "submenu1";
const kOrderItemModelSubmenu2 = "submenu2";
const kOrderItemModelSubmenu3 = "submenu3";
const kOrderItemModelSubmenu4 = "submenu4";
const kOrderItemModelSubmenu5 = "submenu5";

//set category
const kOrderItemModelCategory = "category";

//helper discount
const kOrderItemModelHelperPromoType = "helperpromotype";
const kOrderItemModelHelperDiscount = "helperdiscount";
const kOrderItemModelHelperDiscountDesc = "helperdiscountdesc";

//menu level price
const kOrderItemModelMenuLevelPrice = "menulevelprice";

const kOrderItemModelSKU = "sku";
const kOrderItemModelLocation = "location";

const kOrderItemModelIsOnHold = "isonhold";

class OrderItemModel {
  String id;
  String menuId;
  int qty; //actual qty
  double price; //single unit price
  double discount; //single unit discount
  String discountDetail; //discount description

  String img;
  String title;
  String subTitle;
  String remark;

  String store;
  String storeId;
  String orderId;
  String modInfo;
  String modPrice;

  String timeSlot;
  String deliveryOption;
  String orderDateTime;
  String orderYear;
  String orderMonth;
  String orderDay;
  String orderHour;
  int paymentStatus = kPaid;

  double weight;

  //helper discount
  int helperPromoType = kPromoTypeDiscount;
  double helperDiscount; //this is helper single qty discount
  String helperDiscountDesc = ""; //this is helper discount desc

  //sub menu
  // List<dynamic> subMenus1 = [];
  // List<dynamic> subMenus2 = [];
  // List<dynamic> subMenus3 = [];
  // List<dynamic> subMenus4 = [];
  // List<dynamic> subMenus5 = [];

  //category
  String category;

  //external meaning below data only exist in programming, not on FS
  // Map<String, List<ModifierModel>> _exModiferDetails =
  //     Map<String, List<ModifierModel>>();
  //
  // Map<String, ModifierGroupModel> _exModiferGroupDetails =
  //     Map<String, ModifierGroupModel>();

  //menu level price
  double menuLevelPrice;

  //sku
  String sku;
  //location
  String location;

  bool isOrderOnHold;

  //----external data function

  double getTotalPrice() {
//    double total = 0.0;
//    _exModiferDetails.forEach((key, value) {
//      if (value != null) {
//        value.forEach((element) {
//          total = total + element.price;
//        });
//      }
//    });

    double total = 0.0;
    if (modPrice != null) {
      final modPriceSplit = modPrice.split(",");
      for (var element in modPriceSplit) {
        final modifierPrice = double.tryParse(element ?? "0.0") ?? 0.0;
        total = total + modifierPrice;
      }
    }

    //print("helperDiscount $helperDiscount");

    return qty *
        (total + price - ((discount ?? 0.0) + (helperDiscount ?? 0.0)));
  }

  double getTotalPriceWithoutDiscount() {
//    double total = 0.0;
//    _exModiferDetails.forEach((key, value) {
//      if (value != null) {
//        value.forEach((element) {
//          total = total + element.price;
//        });
//      }
//    });
    double total = 0.0;
    if (modPrice != null) {
      final modPriceSplit = modPrice.split(",");
      for (var element in modPriceSplit) {
        final modifierPrice = double.tryParse(element ?? "0.0") ?? 0.0;
        total = total + modifierPrice;
      }
    }

    return qty * (total + price);
  }

  double getDiscount() {
    final qtyValue = qty ?? 1;
    final discountValue = discount ?? 0.0;
    final helperDiscountValue = helperDiscount ?? 0.0;

    return qtyValue * (discountValue + helperDiscountValue);
  }

  String getDiscountDetail() {
    return discountDetail;
  }


  //sub menu




  OrderItemModel({
    required this.id,
    required  this.menuId,
    required  this.qty,
    required  this.price,
    required  this.discount,
    required  this.discountDetail,
    required  this.img,
    required  this.title,
    required  this.subTitle,
    required  this.remark,
    required  this.store,
    required  this.storeId,
    required  this.orderId,
    required  this.modInfo,
    required  this.modPrice,
    required  this.timeSlot,
    required  this.deliveryOption,
    required  this.orderDateTime,
    required  this.orderYear,
    required   this.orderMonth,
    required  this.orderDay,
    required  this.orderHour,
    required  this.paymentStatus,
    required  this.weight,

    //helper discount
    required  this.helperPromoType,
    required  this.helperDiscount,
    required  this.helperDiscountDesc,


    //category
    required  this.category,

    //menu level price
    required  this.menuLevelPrice,

    //sku
    required  this.sku,
    //location
    required  this.location,
    required  this.isOrderOnHold,
  });



  factory OrderItemModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kOrderItemModelId] ?? "";
    } catch (ex) {}

    var menuId = "";
    try {
      menuId = doc[kOrderItemModelMenuId] ?? "";
    } catch (ex) {}

    var qty = 0;
    try {
      qty = int.tryParse(doc[kOrderItemModelQty]?.toString() ?? "0") ?? 0;
    } catch (ex) {}

    var price = 0.0;
    try {
      price = double.tryParse(doc[kOrderItemModelPrice]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var discount = 0.0;
    try {
      discount =
          double.tryParse(doc[kOrderItemModelDiscount]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    var discountDetail = "";
    try {
      discountDetail = doc[kOrderItemModelDiscountDetail] ?? "";
    } catch (ex) {}

    var img = "";
    try {
      img = doc[kOrderItemModelImg] ?? "";
    } catch (ex) {}

    var title = "";
    try {
      title = doc[kOrderItemModelTitle] ?? "";
    } catch (ex) {}

    var subTitle = "";
    try {
      subTitle = doc[kOrderItemModelSubTitle] ?? "";
    } catch (ex) {}

    var remark = "";
    try {
      remark = doc[kOrderItemModelRemark] ?? "";
    } catch (ex) {}

    var store = "";
    try {
      store = doc[kOrderItemModelStore] ?? "";
    } catch (ex) {}

    var storeId = "";
    try {
      storeId = doc[kOrderItemModelStoreId] ?? "";
    } catch (ex) {}

    var orderId = "";
    try {
      orderId = doc[kOrderItemModelOrderId] ?? "";
    } catch (ex) {}

    var modInfo = "";
    try {
      modInfo = doc[kOrderItemModelModInfo] ?? "";
    } catch (ex) {}

    Object modPrice = "0.0";
    try {
      modPrice =
          double.tryParse(doc[kOrderItemModelModPrice]?.toString() ?? "0.0") ??
              "0.0";
    } catch (ex) {}

    var timeSlot = "";
    try {
      timeSlot = doc[kOrderItemModelTimeSlot] ?? "";
    } catch (ex) {}

    var deliveryOption = "";
    try {
      deliveryOption = doc[kOrderItemModelDeliveryOption] ?? "";
    } catch (ex) {}

    var orderDateTime = "";
    try {
      orderDateTime = doc[kOrderItemModelOrderDateTime] ?? "";
    } catch (ex) {}

    var orderYear = "";
    try {
      orderYear = doc[kOrderItemModelOrderYear] ?? "";
    } catch (ex) {}

    var orderMonth = "";
    try {
      orderMonth = doc[kOrderItemModelOrderMonth] ?? "";
    } catch (ex) {}

    var orderDay = "";
    try {
      orderDay = doc[kOrderItemModelOrderDay] ?? "";
    } catch (ex) {}

    var orderHour = "";
    try {
      orderHour = doc[kOrderItemModelOrderHour] ?? "";
    } catch (ex) {}

    var paymentStatus = kPaid;
    try {
      paymentStatus = doc[kOrderItemModelPaymentStatus] ?? kPaid;
    } catch (ex) {}

    var weight = 0.0;
    try {
      weight = doc[kOrderItemModelWeight] ?? 0.0;
    } catch (ex) {}

    //helper discount
    var helperPromoType = kPromoTypeDiscount;
    try {
      helperPromoType =
          doc[kOrderItemModelHelperDiscount] ?? kPromoTypeDiscount;
    } catch (ex) {}

    var helperDiscount = 0.0;
    try {
      helperDiscount = double.tryParse(
              doc[kOrderItemModelHelperDiscount]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var helperDiscountDesc = "";
    try {
      helperDiscountDesc = doc[kOrderItemModelHelperDiscountDesc] ?? "";
    } catch (ex) {}

    //sub menu
    // var subMenus1 = [];
    // try {
    //   subMenus1 = (doc[kOrderItemModelSubmenu1] != null)
    //       ? doc[kOrderItemModelSubmenu1].map((set) {
    //           return MenuModel.fromMap(set);
    //         }).toList()
    //       : [];
    // } catch (ex) {}
    //
    // var subMenus2 = [];
    // try {
    //   subMenus2 = (doc[kOrderItemModelSubmenu2] != null)
    //       ? doc[kOrderItemModelSubmenu2].map((set) {
    //           return MenuModel.fromMap(set);
    //         }).toList()
    //       : [];
    // } catch (ex) {}
    //
    // var subMenus3 = [];
    // try {
    //   subMenus3 = (doc[kOrderItemModelSubmenu3] != null)
    //       ? doc[kOrderItemModelSubmenu3].map((set) {
    //           return MenuModel.fromMap(set);
    //         }).toList()
    //       : [];
    // } catch (ex) {}
    //
    // var subMenus4 = [];
    // try {
    //   subMenus4 = (doc[kOrderItemModelSubmenu4] != null)
    //       ? doc[kOrderItemModelSubmenu4].map((set) {
    //           return MenuModel.fromMap(set);
    //         }).toList()
    //       : [];
    // } catch (ex) {}
    //
    // var subMenus5 = [];
    // try {
    //   subMenus5 = (doc[kOrderItemModelSubmenu5] != null)
    //       ? doc[kOrderItemModelSubmenu5].map((set) {
    //           return MenuModel.fromMap(set);
    //         }).toList()
    //       : [];
    // } catch (ex) {}

    var category = "";
    try {
      category = doc[kOrderItemModelCategory] ?? "";
    } catch (ex) {}

    //menu level price
    var menuLevelPrice = 0.0;
    try {
      menuLevelPrice = double.tryParse(
              doc[kOrderItemModelMenuLevelPrice]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    //sku
    var sku = "";
    try {
      sku = doc[kOrderItemModelSKU] ?? "";
    } catch (ex) {}

    var location = "";
    try {
      location = doc[kOrderItemModelLocation] ?? "";
    } catch (ex) {}

    var isOrderOnHold = false;
    try {
      isOrderOnHold = doc[kOrderItemModelIsOnHold] ?? false;
    } catch (ex) {}

    return OrderItemModel(
      id: id,
      menuId: menuId,
      qty: qty,
      price: price,
      discount: discount,
      discountDetail: discountDetail,
      img: img,
      title: title,
      subTitle: subTitle,
      remark: remark,
      store: store,
      storeId: storeId,
      orderId: orderId,
      modInfo: modInfo,
      modPrice: modPrice.toString(),
      timeSlot: timeSlot,
      deliveryOption: deliveryOption,
      orderDateTime: orderDateTime,
      orderYear: orderYear,
      orderMonth: orderMonth,
      orderDay: orderDay,
      orderHour: orderHour,
      paymentStatus: paymentStatus,
      weight: weight,

      //helper discount
      helperPromoType: helperPromoType,
      helperDiscount: helperDiscount,
      helperDiscountDesc: helperDiscountDesc,
      //sub menu
      // subMenus1: subMenus1,
      // subMenus2: subMenus2,
      // subMenus3: subMenus3,
      // subMenus4: subMenus4,
      // subMenus5: subMenus5,

      category: category,

      //menu level price
      menuLevelPrice: menuLevelPrice,
      //sku
      sku: sku,
      location: location,
      isOrderOnHold: isOrderOnHold,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kOrderItemModelId: id,
      kOrderItemModelMenuId: menuId,
      kOrderItemModelQty: qty,
      kOrderItemModelPrice: price,
      kOrderItemModelImg: img,
      kOrderItemModelTitle: title,
      kOrderItemModelSubTitle: subTitle,
      kOrderItemModelRemark: remark,
      kOrderItemModelStore: store,
      kOrderItemModelStoreId: storeId,
      kOrderItemModelOrderId: orderId,
      kOrderItemModelModInfo: modInfo,
      kOrderItemModelModPrice: modPrice,
      kOrderItemModelTimeSlot: timeSlot,
      kOrderItemModelDeliveryOption: deliveryOption,
      kOrderItemModelOrderDateTime: orderDateTime,
      kOrderItemModelOrderYear: orderYear,
      kOrderItemModelOrderMonth: orderMonth,
      kOrderItemModelOrderDay: orderDay,
      kOrderItemModelOrderHour: orderHour,
      kOrderItemModelPaymentStatus: paymentStatus ?? kPaid,

      kOrderItemModelDiscount: discount ?? 0.0,
      kOrderItemModelDiscountDetail: discountDetail ?? "",
      kOrderItemModelWeight: weight ?? 0.0,

      //helper discount
      kOrderItemModelHelperPromoType: helperPromoType ?? kPromoTypeDiscount,
      kOrderItemModelHelperDiscount: helperDiscount ?? 0.0,
      kOrderItemModelHelperDiscountDesc: helperDiscountDesc ?? "",

      //set menu
      // kOrderItemModelSubmenu1: firestoreSubMenuSets(1),
      // kOrderItemModelSubmenu2: firestoreSubMenuSets(2),
      // kOrderItemModelSubmenu3: firestoreSubMenuSets(3),
      // kOrderItemModelSubmenu4: firestoreSubMenuSets(4),
      // kOrderItemModelSubmenu5: firestoreSubMenuSets(5),

      //category
      kOrderItemModelCategory: category ?? "",

      //menu level price
      kOrderItemModelMenuLevelPrice: menuLevelPrice ?? 0.0,
      //sku
      kOrderItemModelSKU: sku ?? "",
      //location
      kOrderItemModelLocation: location ?? "",
      kOrderItemModelIsOnHold: isOrderOnHold ?? false,
    };
  }

  OrderItemModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kOrderItemModelId] ?? "",
        menuId = map[kOrderItemModelMenuId] ?? "",
        qty = map[kOrderItemModelQty].toInt(),
        price = map[kOrderItemModelPrice].toDouble(),
        img = map[kOrderItemModelImg] ?? "",
        title = map[kOrderItemModelTitle] ?? "",
        subTitle = map[kOrderItemModelSubTitle] ?? "",
        remark = map[kOrderItemModelRemark] ?? "",
        store = map[kOrderItemModelStore] ?? "",
        storeId = map[kOrderItemModelStoreId] ?? "",
        orderId = map[kOrderItemModelOrderId] ?? "",
        modInfo = map[kOrderItemModelModInfo] ?? "",
        modPrice = map[kOrderItemModelModPrice] ?? "",
        timeSlot = map[kOrderItemModelTimeSlot] ?? "",
        deliveryOption = map[kOrderItemModelDeliveryOption] ?? "",
        orderDateTime = map[kOrderItemModelOrderDateTime] ?? "",
        orderYear = map[kOrderItemModelOrderYear] ?? "",
        orderMonth = map[kOrderItemModelOrderMonth] ?? "",
        orderDay = map[kOrderItemModelOrderDay] ?? "",
        orderHour = map[kOrderItemModelOrderHour] ?? "",
        paymentStatus = map[kOrderItemModelPaymentStatus] ?? kPaid,
        discount = double.tryParse(
                map[kOrderItemModelDiscount]?.toString() ?? "0.0") ??
            0.0,
        discountDetail = map[kOrderItemModelDiscountDetail] ?? "",
        weight = map[kOrderItemModelWeight] ?? 0.0,
        //helper discount
        helperPromoType =
            map[kOrderItemModelHelperPromoType] ?? kPromoTypeDiscount,
        helperDiscount = double.tryParse(
                map[kOrderItemModelHelperDiscount]?.toString() ?? "0.0") ??
            0.0,
        helperDiscountDesc = map[kOrderItemModelHelperDiscountDesc] ?? "",
        // subMenus1 = (map[kOrderItemModelSubmenu1] != null)
        //     ? map[kOrderItemModelSubmenu1].map((set) {
        //         return MenuModel.fromMap(set);
        //       }).toList()
        //     : [],
        // subMenus2 = (map[kOrderItemModelSubmenu2] != null)
        //     ? map[kOrderItemModelSubmenu2].map((set) {
        //         return MenuModel.fromMap(set);
        //       }).toList()
        //     : [],
        // subMenus3 = (map[kOrderItemModelSubmenu3] != null)
        //     ? map[kOrderItemModelSubmenu3].map((set) {
        //         return MenuModel.fromMap(set);
        //       }).toList()
        //     : [],
        // subMenus4 = (map[kOrderItemModelSubmenu4] != null)
        //     ? map[kOrderItemModelSubmenu4].map((set) {
        //         return MenuModel.fromMap(set);
        //       }).toList()
        //     : [],
        // subMenus5 = (map[kOrderItemModelSubmenu5] != null)
        //     ? map[kOrderItemModelSubmenu5].map((set) {
        //         return MenuModel.fromMap(set);
        //       }).toList()
        //     : [],

        //category
        category = map[kOrderItemModelCategory] ?? "",
        menuLevelPrice = map[kOrderItemModelMenuLevelPrice] ?? 0.0,
        //sku
        sku = map[kOrderItemModelSKU] ?? "",
        location = map[kOrderItemModelLocation] ?? "",
        isOrderOnHold = map[kOrderItemModelIsOnHold] ?? false;
}
