
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:helloworld/constant.dart';
import 'package:helloworld/model/order_model.dart';
import 'package:helloworld/model/store_model.dart';
import 'package:helloworld/model/summary_day_model.dart';
import 'package:helloworld/model/summary_hour_model.dart';
import 'package:helloworld/model/summary_model.dart';
import 'package:helloworld/model/zreport_model.dart';
import 'package:helloworld/util_datetime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

const apiKey = 'AIzaSyDxlXL3fKbnibpOTUsOnIGkdFE5MXxennE';
const projectId = 'foodio-ab3b2';


Router app = Router(

)

  //perkd related
//   ..get("/perkd/checkin/<storeid>", (Request request, String storeid){
//     return Response.ok('checkin $storeid');
//   })

//   ..get("/perkd/pay/<storeid>", (Request request, String storeid){
//     return Response.ok('pay $storeid');
//   })

//  ..get("/perkd/order/<storeid>", (Request request, String storeid){
//     return Response.ok('order $storeid');
//   })

//    ..get("/perkd/pickup/<storeid>", (Request request, String storeid){
//     return Response.ok('pickup $storeid');
//   })



//foodio related
  ..get('/health', (Request request) {
    return Response.ok('i am good, v1.6');
  })

  ..get('/result/<storeId>', (Request request, String storeId)  async {

    final result = await performClosing(storeId);//"S_5aca69dd-e964-45ea-ae6d-e1061e28f737"

    var header = {
      'Access-Control-Allow-Origin': '*'
    };

    return Response.ok(result, headers: header );
  })

  ..get('/clear/<storeId>', (Request request, String storeId)  async {

    final result = await clearOnline(storeId);//"S_5aca69dd-e964-45ea-ae6d-e1061e28f737"

    var header = {
      'Access-Control-Allow-Origin': '*'
    };

    return Response.ok(result, headers: header );
  })

  ..get('/user/<user>', (Request request, String user) {
    // fetch the user... (probably return as json)
    return Response.ok('hello $user');
  })
  ..post('/user', (Request request) {
    // convert request body to json and persist... (probably return as json)
    return Response.ok('saved the user');
  });


int add2Values(int value1, int value2)
{
  return value1 + value2;
}

Future<String> readData() async
{
  try {
    Firestore.initialize(projectId);
  }
  catch(ex)
  {
    print(ex.toString());
  }
  var refs = await Firestore.instance.collection('store').document("S_5aca69dd-e964-45ea-ae6d-e1061e28f737").collection("order").get();
  for (var element in refs) {
    print(element.toString());
  }

  return refs.toString();
}

Future<String> performClosing(String storeId) async
{

  try {
    Firestore.initialize(projectId);
  }
  catch(ex)
  {
    print(ex.toString());

  }

  final storeRef = Firestore.instance.collection("store").document(storeId);
  final psevRef = Firestore.instance.collection("pserver").document(storeId);
  final pFCRef = Firestore.instance.collection("fcollector").document(storeId);

  final orderRef = storeRef.collection("order");
  final orderTempRef = storeRef.collection("order_temp");
  final orderHoldRef = storeRef.collection("order_hold");
  final todayOrderRef = storeRef.collection("today_order");
  final itemOrderRef = storeRef.collection("itemorder");
  final bellServiceRef = storeRef.collection("bell_service");
  final counterOrderRef = storeRef.collection("counter_order");
  final counterOrderPlacedRef = storeRef.collection("counter_order_placed");
  final kdsRef = storeRef.collection("kds");
  final qPrintRef =psevRef.collection("qprint");
  final qOrderRef = psevRef.collection("qorder");
  final pKDSDoneRef = psevRef.collection("pkds_done");
  final collectNowRef = pFCRef.collection("collect_now");

  //get store model
  final storeResult = await storeRef.get();

  if(storeResult == null)
    {
      return "error: store not found";
    }

  StoreModel storeModel = StoreModel.formDocument(storeResult);
  print("store detected: ${storeModel.title}");

  //get order and generate summary
  //save the summary orders
  SummaryModel summaryModel = SummaryModel.newSummary();
  summaryModel.id =
  "SM_${UtilDateTime.getCurrentDate()}${UtilDateTime.getCurrentTime()}"; //+ Uuid().v4();
  summaryModel.openDate = storeModel?.openDate ?? "";
  summaryModel.closeDate = storeModel?.closeDate ?? "";
  summaryModel.addStore(storeModel);
  summaryModel.orders = [];

  Map<int, double> hourlySalesMap = {};
  Map<int, int> hourlyQtyMap = {};
  Map<int, int> hourlyReceiptTotalMap = {};
  Map<int, double> hourlyGTOSalesTotalMap = {};
  Map<int, double> hourlyGstTotalMap = {};
  Map<int, double> hourlyDiscountTotalMap = {};
  Map<int, int> hourlyPaxTotalMap = {};

  double totalPrice = 0.0;
  int totalQty = 0;
  double totalVoidPrice = 0.0;
  int totalVoidQty = 0;

  double totalDiscountPrice = 0.0;
  double totalReceiptLevelDiscountPrice = 0.0;
  double subTotalPrice = 0.0;
  int totalOrders = 0;
  double totalTax = 0.0;
  double totalTaxInclusive = 0.0;
  double totalSC = 0.0;
  double totalRounding = 0.0;



  List<OrderModel> orderList = [];
  var refs = await todayOrderRef.limit(300).get();
  for(var element in refs)
  {
    try {
      final orderModel = OrderModel.formDocument(element);

      print("order model id ${orderModel.id}");
      orderList.add(orderModel);
    }
    catch(ex)
  {
    print("order model error: ${ex.toString()}");
  }
     await element.reference.delete();
  }

  while((refs.length ?? 0) > 0)
    {
       refs = await todayOrderRef.limit(300).get();
       for(var element in refs)
         {
           try {
             final orderModel = OrderModel.formDocument(element);

             print("order model id ${orderModel.id}");
             orderList.add(orderModel);
           }
           catch(ex)
           {
             print("order model error: ${ex.toString()}");
           }
            await element.reference.delete();
         }
    }

  print("now proceed");

  int todayOrderCount = 0;
  for (var orderModel in orderList) {
    //final orderModel = OrderModel.formDocument(element);

    var price = orderModel.calculateTotal(
        storeModel?.isRoundingForCashOnly ?? false) ??
        0.0;
    var gtoPrice = orderModel.calculateGTOSalesTotal(
       storeModel?.isRoundingForCashOnly ?? false) ??
        0.0;

    var subTotal = orderModel.calculateNetTotal();
    var discount = orderModel.getTotalDiscount();
    var tax = double.tryParse(orderModel.totalTax ?? "0.0") ?? 0.0;
    var taxInclusive =
        double.tryParse(orderModel.totalTaxInclusive ?? "0.0") ?? 0.0;
    var sc =
        double.tryParse(orderModel.totalServiceCharge ?? "0.0") ?? 0.0;
    var rounding =
        double.tryParse(orderModel.totalRounding ?? "0.0") ?? 0.0;
    var receiptLevelDiscount = orderModel.receiptDiscount;
    var quantity = (int.parse(orderModel.totalQty) ?? 0);
    var pax = orderModel.pax ?? 1;

    if (orderModel.paymentStatus == kVoid) {
      totalVoidPrice = totalVoidPrice + price;
      totalVoidQty = totalVoidQty + quantity;
    } else if (orderModel.paymentStatus == kPaid) {
      totalPrice = totalPrice + price;
      totalQty = totalQty + quantity;
    }

    totalDiscountPrice = totalDiscountPrice + discount;
    totalReceiptLevelDiscountPrice =
        totalReceiptLevelDiscountPrice + receiptLevelDiscount;
    subTotalPrice = subTotalPrice + subTotal;
    totalOrders = totalOrders + 1;
    totalTax = totalTax + tax;
    totalTaxInclusive = totalTaxInclusive + taxInclusive;
    totalSC = totalSC + sc;
    totalRounding = totalRounding + rounding;

    //set hourly sales
    DateTime orderDateTime =
    UtilDateTime.stringDateTimeToDateTimeWithFormat(
        orderModel?.orderDateTime?.trim() ?? "",
        kPrefDateTimeFormat);
    String orderTime = UtilDateTime.dateTimeToStringWithFormat(
        orderDateTime, "hh:mm a");

    int hourlyIndex = UtilDateTime.getHourlyIndex(orderTime);
    //print("hour index for $orderTime is $hourlyIndex");

    //set hourly sales
    hourlySalesMap[hourlyIndex] =
        (hourlySalesMap[hourlyIndex] ?? 0.0) + price;

    //set hourly qty
    hourlyQtyMap[hourlyIndex] =
        (hourlyQtyMap[hourlyIndex] ?? 0) + quantity;

    //set hourly gto
    hourlyReceiptTotalMap[hourlyIndex] =
        (hourlyReceiptTotalMap[hourlyIndex] ?? 0) + 1;
    hourlyGTOSalesTotalMap[hourlyIndex] =
        (hourlyGTOSalesTotalMap[hourlyIndex] ?? 0.0) + gtoPrice;
    hourlyGstTotalMap[hourlyIndex] =
        (hourlyGstTotalMap[hourlyIndex] ?? 0.0) + tax + taxInclusive;
    hourlyDiscountTotalMap[hourlyIndex] =
        (hourlyDiscountTotalMap[hourlyIndex] ?? 0.0) +
            discount +
            receiptLevelDiscount;
    hourlyPaxTotalMap[hourlyIndex] =
        (hourlyPaxTotalMap[hourlyIndex] ?? 0) + pax;

    //write orders
    await storeRef
        .collection("summary")
        .document(summaryModel.id)
        .collection("orders")
        .document(orderModel.id)
        .set(orderModel.toMap());

    print("writing ${orderModel.id} to summary->orders");

      todayOrderCount++;
  }

  print("$todayOrderCount copied");

  ZReportModel zReportModel = ZReportModel();
  zReportModel.totalQty = totalQty;
  zReportModel.totalPrice = totalPrice;
  zReportModel.voidPrice = totalVoidPrice;
  zReportModel.voidQty = totalVoidQty;
  zReportModel.discountPrice = totalDiscountPrice;
  zReportModel.totalTax = totalTax;
  zReportModel.totalTaxInclusive = totalTaxInclusive;
  zReportModel.totalRounding = totalRounding;
  zReportModel.totalSC = totalSC;
  zReportModel.subTotalPrice = subTotalPrice;
  zReportModel.receiptLevelDiscountPrice = totalReceiptLevelDiscountPrice;

  //opening float
  zReportModel.openingFloat = storeModel?.openFloat ?? 0.0;
  //cash out
  zReportModel.totalCashOut = storeModel?.getTotalCashOut() ?? 0.0;

  summaryModel.addReportDetail(zReportModel);

  //save the summary
  storeRef

      .collection("summary")
      .document(summaryModel.id)
      .set(summaryModel.toMap());

  SummaryDayModel summaryDay = SummaryDayModel.newSummary();
  summaryDay.id = "SD_" +
      UtilDateTime.getCurrentDate() +
      "_" +
      UtilDateTime.getCurrentTime();
  summaryDay.dateValue = UtilDateTime.getCurrentDate();
  summaryDay.hours = [];

  List<dynamic> hourList = [];
  for (var i = 0; i < 24; i++) {
    var title = hourlyMap[i] ?? "";
    var receiptNumberTotal = hourlyReceiptTotalMap[i] ?? 0;
    var gtoSalesTotal = hourlyGTOSalesTotalMap[i] ?? 0.0;
    var gstTotal = hourlyGstTotalMap[i] ?? 0.0;
    var discountTotal = hourlyDiscountTotalMap[i] ?? 0.0;
    var paxTotal = hourlyPaxTotalMap[i] ?? 0;

    var salesTotal = hourlySalesMap[i] ?? 0.0;
    var qtyTotal = hourlyQtyMap[i] ?? 0;

    if (title != "") {
      SummaryHourModel summaryHourModel = SummaryHourModel.newSummary();
      summaryHourModel.id = "SH_" + title;
      summaryHourModel.indexValue = i;
      summaryHourModel.title = title;
      summaryHourModel.receiptNumberTotal = receiptNumberTotal;
      summaryHourModel.gtoSalesTotal = gtoSalesTotal;
      summaryHourModel.gstTotal = gstTotal;
      summaryHourModel.discountTotal = discountTotal;
      summaryHourModel.paxTotal = paxTotal;

      summaryHourModel.salesTotal = salesTotal;
      summaryHourModel.qtyTotal = qtyTotal;

      hourList.add(summaryHourModel);
      summaryDay.hours.add(summaryHourModel);
    }
  }

  //summaryDay.hours = hourList;

  storeRef
      //.doc(widget.storeModel.id)
      .collection("daysummary")
      .document(summaryDay.id)
      .set(summaryDay.toMap());



  //order
 
  try {

    var snapshot = await orderRef.get();
    for(Document doc in snapshot)
      {
        await doc.reference.delete();
      }

    print("${snapshot.length} delete order");
    while((snapshot.length ?? 0) > 0)
      {
        snapshot = await orderRef.get();
        for(Document doc in snapshot)
        {
          await doc.reference.delete();
        }
        print("${snapshot.length} delete order");
      }

    //print("${snapshot.length} delete order");
    // orderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //
    //       }
    //     }
    // );

    //order temp
    var snapshotTempRef = await orderTempRef.get();
    for(Document doc in snapshotTempRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotTempRef.length} delete order temp");
    while((snapshotTempRef.length ?? 0) > 0)
      {
         snapshotTempRef = await orderTempRef.get();
        for(Document doc in snapshotTempRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotTempRef.length} delete order temp");
      }

    //print("${snapshotTempRef.length} delete order temp");

    // orderTempRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //order hold

    var snapshotHoldRef = await orderHoldRef.get();
    for(Document doc in snapshotHoldRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotHoldRef.length} delete order hold");
    while((snapshotHoldRef.length ?? 0 ) > 0)
      {
         snapshotHoldRef = await orderHoldRef.get();
        for(Document doc in snapshotHoldRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotHoldRef.length} delete order hold");
      }

    //print("${snapshotHoldRef.length} delete order hold");

    // orderHoldRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //today order

    var snapshotTodayOrderRef = await todayOrderRef.get();
    for(Document doc in snapshotTodayOrderRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotTodayOrderRef.length} delete today order");

    while((snapshotTodayOrderRef.length ?? 0) > 0)
      {
         snapshotTodayOrderRef = await todayOrderRef.get();
        for(Document doc in snapshotTodayOrderRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotTodayOrderRef.length} delete today order");
      }

    //print("${snapshotTodayOrderRef.length} delete today order");
    // todayOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //bell service

    var snapshotBellServiceRef = await bellServiceRef.get();
    for(Document doc in snapshotBellServiceRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotBellServiceRef.length} delete bell service");
    while((snapshotBellServiceRef.length ?? 0) > 0)
    {
     snapshotBellServiceRef = await bellServiceRef.get();
    for(Document doc in snapshotBellServiceRef)
    {
    await doc.reference.delete();
    }
     print("${snapshotBellServiceRef.length} delete bell service");
    }
   // print("${snapshotBellServiceRef.length} delete bell service");

    // bellServiceRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //item order

    var snapshotItemOrderRef = await itemOrderRef.get();
    for(Document doc in snapshotItemOrderRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotItemOrderRef.length} delete item order");
    while((snapshotItemOrderRef.length ?? 0 ) > 0)
      {
         snapshotItemOrderRef = await itemOrderRef.get();
        for(Document doc in snapshotItemOrderRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotItemOrderRef.length} delete item order");
      }
    //print("${snapshotItemOrderRef.length} delete item order");
    // itemOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //counter order

    var snapshotCounterOrderRef = await counterOrderRef.get();
    for(Document doc in snapshotCounterOrderRef)
    {
      await doc.reference.delete();

    }

    print("${snapshotCounterOrderRef.length} delete counter order");

    while((snapshotCounterOrderRef.length ?? 0) > 0)
      {
         snapshotCounterOrderRef = await counterOrderRef.get();
        for(Document doc in snapshotCounterOrderRef)
        {
          await doc.reference.delete();

        }

         print("${snapshotCounterOrderRef.length} delete counter order");
      }

    //print("${snapshotCounterOrderRef.length} delete counter order");
    // counterOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //counter order placed

    var snapshotCounterOrderPlacedRef = await counterOrderPlacedRef.get();
    for(Document doc in snapshotCounterOrderPlacedRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotCounterOrderPlacedRef.length} delete counter order placed");
    while((snapshotCounterOrderPlacedRef.length ?? 0) > 0)
      {
         snapshotCounterOrderPlacedRef = await counterOrderPlacedRef.get();
        for(Document doc in snapshotCounterOrderPlacedRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotCounterOrderPlacedRef.length} delete counter order placed");
      }
    //print("${snapshotCounterOrderPlacedRef.length} delete counter order placed");
    // counterOrderPlacedRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //kds

    var snapshotKDSRef = await kdsRef.get();
    for(Document doc in snapshotKDSRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotKDSRef.length} delete kds");
    while((snapshotKDSRef.length ?? 0) > 0)
      {
         snapshotKDSRef = await kdsRef.get();
        for(Document doc in snapshotKDSRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotKDSRef.length} delete kds");
      }
   // print("${snapshotKDSRef.length} delete kds");

    // kdsRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //qprint

    var snapshotQPrintRef = await qPrintRef.get();
    for(Document doc in snapshotQPrintRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotQPrintRef.length} delete qprint");
    while((snapshotQPrintRef.length ?? 0) > 0)
      {
         snapshotQPrintRef = await qPrintRef.get();
        for(Document doc in snapshotQPrintRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotQPrintRef.length} delete qprint");
      }
    //print("${snapshotQPrintRef.length} delete qprint");
    // qPrintRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //qorder

    var snapshotQOrderRef = await qOrderRef.get();
    for(Document doc in snapshotQOrderRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotQOrderRef.length} delete qorder");
    while((snapshotQOrderRef.length ?? 0) > 0)
      {
         snapshotQOrderRef = await qOrderRef.get();
        for(Document doc in snapshotQOrderRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotQOrderRef.length} delete qorder");
      }
    //print("${snapshotQOrderRef.length} delete qorder");
    // qOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //kds done

    var snapshotKDSDoneRef = await pKDSDoneRef.get();
    for(Document doc in snapshotKDSDoneRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotKDSDoneRef.length} delete kds done");
    while((snapshotKDSDoneRef.length ?? 0) > 0)
      {
         snapshotKDSDoneRef = await pKDSDoneRef.get();
        for(Document doc in snapshotKDSDoneRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotKDSDoneRef.length} delete kds done");
      }
   // print("${snapshotKDSDoneRef.length} delete kds done");
    // pKDSDoneRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //collect now

    var snapshotCollectNowRef = await collectNowRef.get();
    for(Document doc in snapshotCollectNowRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotCollectNowRef.length} delete collect now");
    while((snapshotCollectNowRef.length ?? 0) > 0)
      {
         snapshotCollectNowRef = await collectNowRef.get();
        for(Document doc in snapshotCollectNowRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotCollectNowRef.length} delete collect now");
      }
    //print("${snapshotCollectNowRef.length} delete collect now");
    // collectNowRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    print("delete command");
    storeRef
        .collection("command")
        .document(storeId)
        .delete();
  }
  catch(ex)
  {
    return ex.toString();
  }

   return "success: $todayOrderCount orders today, ${summaryModel.id}";
}


Future<String> clearOnline(String storeId) async
{

  try {
    Firestore.initialize(projectId);
  }
  catch(ex)
  {
    print(ex.toString());

  }

  final storeRef = Firestore.instance.collection("store").document(storeId);
  final psevRef = Firestore.instance.collection("pserver").document(storeId);
  final pFCRef = Firestore.instance.collection("fcollector").document(storeId);

  final orderRef = storeRef.collection("order");
  final orderTempRef = storeRef.collection("order_temp");
  final orderHoldRef = storeRef.collection("order_hold");
  final todayOrderRef = storeRef.collection("today_order");
  final itemOrderRef = storeRef.collection("itemorder");
  final bellServiceRef = storeRef.collection("bell_service");
  final counterOrderRef = storeRef.collection("counter_order");
  final counterOrderPlacedRef = storeRef.collection("counter_order_placed");
  final kdsRef = storeRef.collection("kds");
  final qPrintRef =psevRef.collection("qprint");
  final qOrderRef = psevRef.collection("qorder");
  final pKDSDoneRef = psevRef.collection("pkds_done");
  final collectNowRef = pFCRef.collection("collect_now");

  //get store model
  final storeResult = await storeRef.get();

  if(storeResult == null)
    {
      return "error: store not found";
    }

  StoreModel storeModel = StoreModel.formDocument(storeResult);
  print("store detected: ${storeModel.title}");

  //get order and generate summary
  //save the summary orders
  /*
  SummaryModel summaryModel = SummaryModel.newSummary();
  summaryModel.id =
  "SM_${UtilDateTime.getCurrentDate()}${UtilDateTime.getCurrentTime()}"; //+ Uuid().v4();
  summaryModel.openDate = storeModel?.openDate ?? "";
  summaryModel.closeDate = storeModel?.closeDate ?? "";
  summaryModel.addStore(storeModel);
  summaryModel.orders = [];

  Map<int, double> hourlySalesMap = {};
  Map<int, int> hourlyQtyMap = {};
  Map<int, int> hourlyReceiptTotalMap = {};
  Map<int, double> hourlyGTOSalesTotalMap = {};
  Map<int, double> hourlyGstTotalMap = {};
  Map<int, double> hourlyDiscountTotalMap = {};
  Map<int, int> hourlyPaxTotalMap = {};

  double totalPrice = 0.0;
  int totalQty = 0;
  double totalVoidPrice = 0.0;
  int totalVoidQty = 0;

  double totalDiscountPrice = 0.0;
  double totalReceiptLevelDiscountPrice = 0.0;
  double subTotalPrice = 0.0;
  int totalOrders = 0;
  double totalTax = 0.0;
  double totalTaxInclusive = 0.0;
  double totalSC = 0.0;
  double totalRounding = 0.0;

  */

  List<OrderModel> orderList = [];
  var refs = await todayOrderRef.limit(300).get();
  for(var element in refs)
  {
    try {
      final orderModel = OrderModel.formDocument(element);

      print("order model id ${orderModel.id}");
      orderList.add(orderModel);
    }
    catch(ex)
  {
    print("order model error: ${ex.toString()}");
  }
     await element.reference.delete();
  }

  while((refs.length ?? 0) > 0)
    {
       refs = await todayOrderRef.limit(300).get();
       for(var element in refs)
         {
           try {
             final orderModel = OrderModel.formDocument(element);

             print("order model id ${orderModel.id}");
             orderList.add(orderModel);
           }
           catch(ex)
           {
             print("order model error: ${ex.toString()}");
           }
            await element.reference.delete();
         }
    }

  print("now proceed");
  /*
  int todayOrderCount = 0;
  for (var orderModel in orderList) {
    //final orderModel = OrderModel.formDocument(element);

    var price = orderModel.calculateTotal(
        storeModel?.isRoundingForCashOnly ?? false) ??
        0.0;
    var gtoPrice = orderModel.calculateGTOSalesTotal(
       storeModel?.isRoundingForCashOnly ?? false) ??
        0.0;

    var subTotal = orderModel.calculateNetTotal();
    var discount = orderModel.getTotalDiscount();
    var tax = double.tryParse(orderModel.totalTax ?? "0.0") ?? 0.0;
    var taxInclusive =
        double.tryParse(orderModel.totalTaxInclusive ?? "0.0") ?? 0.0;
    var sc =
        double.tryParse(orderModel.totalServiceCharge ?? "0.0") ?? 0.0;
    var rounding =
        double.tryParse(orderModel.totalRounding ?? "0.0") ?? 0.0;
    var receiptLevelDiscount = orderModel.receiptDiscount;
    var quantity = (int.parse(orderModel.totalQty) ?? 0);
    var pax = orderModel.pax ?? 1;

    if (orderModel.paymentStatus == kVoid) {
      totalVoidPrice = totalVoidPrice + price;
      totalVoidQty = totalVoidQty + quantity;
    } else if (orderModel.paymentStatus == kPaid) {
      totalPrice = totalPrice + price;
      totalQty = totalQty + quantity;
    }

    totalDiscountPrice = totalDiscountPrice + discount;
    totalReceiptLevelDiscountPrice =
        totalReceiptLevelDiscountPrice + receiptLevelDiscount;
    subTotalPrice = subTotalPrice + subTotal;
    totalOrders = totalOrders + 1;
    totalTax = totalTax + tax;
    totalTaxInclusive = totalTaxInclusive + taxInclusive;
    totalSC = totalSC + sc;
    totalRounding = totalRounding + rounding;

    //set hourly sales
    DateTime orderDateTime =
    UtilDateTime.stringDateTimeToDateTimeWithFormat(
        orderModel?.orderDateTime?.trim() ?? "",
        kPrefDateTimeFormat);
    String orderTime = UtilDateTime.dateTimeToStringWithFormat(
        orderDateTime, "hh:mm a");

    int hourlyIndex = UtilDateTime.getHourlyIndex(orderTime);
    //print("hour index for $orderTime is $hourlyIndex");

    //set hourly sales
    hourlySalesMap[hourlyIndex] =
        (hourlySalesMap[hourlyIndex] ?? 0.0) + price;

    //set hourly qty
    hourlyQtyMap[hourlyIndex] =
        (hourlyQtyMap[hourlyIndex] ?? 0) + quantity;

    //set hourly gto
    hourlyReceiptTotalMap[hourlyIndex] =
        (hourlyReceiptTotalMap[hourlyIndex] ?? 0) + 1;
    hourlyGTOSalesTotalMap[hourlyIndex] =
        (hourlyGTOSalesTotalMap[hourlyIndex] ?? 0.0) + gtoPrice;
    hourlyGstTotalMap[hourlyIndex] =
        (hourlyGstTotalMap[hourlyIndex] ?? 0.0) + tax + taxInclusive;
    hourlyDiscountTotalMap[hourlyIndex] =
        (hourlyDiscountTotalMap[hourlyIndex] ?? 0.0) +
            discount +
            receiptLevelDiscount;
    hourlyPaxTotalMap[hourlyIndex] =
        (hourlyPaxTotalMap[hourlyIndex] ?? 0) + pax;

    //write orders
    await storeRef
        .collection("summary")
        .document(summaryModel.id)
        .collection("orders")
        .document(orderModel.id)
        .set(orderModel.toMap());

    print("writing ${orderModel.id} to summary->orders");

      todayOrderCount++;
  }


  print("$todayOrderCount copied");

  ZReportModel zReportModel = ZReportModel();
  zReportModel.totalQty = totalQty;
  zReportModel.totalPrice = totalPrice;
  zReportModel.voidPrice = totalVoidPrice;
  zReportModel.voidQty = totalVoidQty;
  zReportModel.discountPrice = totalDiscountPrice;
  zReportModel.totalTax = totalTax;
  zReportModel.totalTaxInclusive = totalTaxInclusive;
  zReportModel.totalRounding = totalRounding;
  zReportModel.totalSC = totalSC;
  zReportModel.subTotalPrice = subTotalPrice;
  zReportModel.receiptLevelDiscountPrice = totalReceiptLevelDiscountPrice;

  //opening float
  zReportModel.openingFloat = storeModel?.openFloat ?? 0.0;
  //cash out
  zReportModel.totalCashOut = storeModel?.getTotalCashOut() ?? 0.0;

  summaryModel.addReportDetail(zReportModel);

  //save the summary
  storeRef

      .collection("summary")
      .document(summaryModel.id)
      .set(summaryModel.toMap());

  SummaryDayModel summaryDay = SummaryDayModel.newSummary();
  summaryDay.id = "SD_" +
      UtilDateTime.getCurrentDate() +
      "_" +
      UtilDateTime.getCurrentTime();
  summaryDay.dateValue = UtilDateTime.getCurrentDate();
  summaryDay.hours = [];

  List<dynamic> hourList = [];
  for (var i = 0; i < 24; i++) {
    var title = hourlyMap[i] ?? "";
    var receiptNumberTotal = hourlyReceiptTotalMap[i] ?? 0;
    var gtoSalesTotal = hourlyGTOSalesTotalMap[i] ?? 0.0;
    var gstTotal = hourlyGstTotalMap[i] ?? 0.0;
    var discountTotal = hourlyDiscountTotalMap[i] ?? 0.0;
    var paxTotal = hourlyPaxTotalMap[i] ?? 0;

    var salesTotal = hourlySalesMap[i] ?? 0.0;
    var qtyTotal = hourlyQtyMap[i] ?? 0;

    if (title != "") {
      SummaryHourModel summaryHourModel = SummaryHourModel.newSummary();
      summaryHourModel.id = "SH_" + title;
      summaryHourModel.indexValue = i;
      summaryHourModel.title = title;
      summaryHourModel.receiptNumberTotal = receiptNumberTotal;
      summaryHourModel.gtoSalesTotal = gtoSalesTotal;
      summaryHourModel.gstTotal = gstTotal;
      summaryHourModel.discountTotal = discountTotal;
      summaryHourModel.paxTotal = paxTotal;

      summaryHourModel.salesTotal = salesTotal;
      summaryHourModel.qtyTotal = qtyTotal;

      hourList.add(summaryHourModel);
      summaryDay.hours.add(summaryHourModel);
    }
  }

  //summaryDay.hours = hourList;

  storeRef
      //.doc(widget.storeModel.id)
      .collection("daysummary")
      .document(summaryDay.id)
      .set(summaryDay.toMap());

  */

  //order
 
  try {

    var snapshot = await orderRef.get();
    for(Document doc in snapshot)
      {
        await doc.reference.delete();
      }

    print("${snapshot.length} delete order");
    while((snapshot.length ?? 0) > 0)
      {
        snapshot = await orderRef.get();
        for(Document doc in snapshot)
        {
          await doc.reference.delete();
        }
        print("${snapshot.length} delete order");
      }

    //print("${snapshot.length} delete order");
    // orderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //
    //       }
    //     }
    // );

    //order temp
    var snapshotTempRef = await orderTempRef.get();
    for(Document doc in snapshotTempRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotTempRef.length} delete order temp");
    while((snapshotTempRef.length ?? 0) > 0)
      {
         snapshotTempRef = await orderTempRef.get();
        for(Document doc in snapshotTempRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotTempRef.length} delete order temp");
      }

    //print("${snapshotTempRef.length} delete order temp");

    // orderTempRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //order hold

    var snapshotHoldRef = await orderHoldRef.get();
    for(Document doc in snapshotHoldRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotHoldRef.length} delete order hold");
    while((snapshotHoldRef.length ?? 0 ) > 0)
      {
         snapshotHoldRef = await orderHoldRef.get();
        for(Document doc in snapshotHoldRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotHoldRef.length} delete order hold");
      }

    //print("${snapshotHoldRef.length} delete order hold");

    // orderHoldRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //today order

    var snapshotTodayOrderRef = await todayOrderRef.get();
    for(Document doc in snapshotTodayOrderRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotTodayOrderRef.length} delete today order");

    while((snapshotTodayOrderRef.length ?? 0) > 0)
      {
         snapshotTodayOrderRef = await todayOrderRef.get();
        for(Document doc in snapshotTodayOrderRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotTodayOrderRef.length} delete today order");
      }

    //print("${snapshotTodayOrderRef.length} delete today order");
    // todayOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //bell service

    var snapshotBellServiceRef = await bellServiceRef.get();
    for(Document doc in snapshotBellServiceRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotBellServiceRef.length} delete bell service");
    while((snapshotBellServiceRef.length ?? 0) > 0)
    {
     snapshotBellServiceRef = await bellServiceRef.get();
    for(Document doc in snapshotBellServiceRef)
    {
    await doc.reference.delete();
    }
     print("${snapshotBellServiceRef.length} delete bell service");
    }
   // print("${snapshotBellServiceRef.length} delete bell service");

    // bellServiceRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //item order

    var snapshotItemOrderRef = await itemOrderRef.get();
    for(Document doc in snapshotItemOrderRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotItemOrderRef.length} delete item order");
    while((snapshotItemOrderRef.length ?? 0 ) > 0)
      {
         snapshotItemOrderRef = await itemOrderRef.get();
        for(Document doc in snapshotItemOrderRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotItemOrderRef.length} delete item order");
      }
    //print("${snapshotItemOrderRef.length} delete item order");
    // itemOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //counter order

    var snapshotCounterOrderRef = await counterOrderRef.get();
    for(Document doc in snapshotCounterOrderRef)
    {
      await doc.reference.delete();

    }

    print("${snapshotCounterOrderRef.length} delete counter order");

    while((snapshotCounterOrderRef.length ?? 0) > 0)
      {
         snapshotCounterOrderRef = await counterOrderRef.get();
        for(Document doc in snapshotCounterOrderRef)
        {
          await doc.reference.delete();

        }

         print("${snapshotCounterOrderRef.length} delete counter order");
      }

    //print("${snapshotCounterOrderRef.length} delete counter order");
    // counterOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //counter order placed

    var snapshotCounterOrderPlacedRef = await counterOrderPlacedRef.get();
    for(Document doc in snapshotCounterOrderPlacedRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotCounterOrderPlacedRef.length} delete counter order placed");
    while((snapshotCounterOrderPlacedRef.length ?? 0) > 0)
      {
         snapshotCounterOrderPlacedRef = await counterOrderPlacedRef.get();
        for(Document doc in snapshotCounterOrderPlacedRef)
        {
          await doc.reference.delete();
        }

         print("${snapshotCounterOrderPlacedRef.length} delete counter order placed");
      }
    //print("${snapshotCounterOrderPlacedRef.length} delete counter order placed");
    // counterOrderPlacedRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //kds

    var snapshotKDSRef = await kdsRef.get();
    for(Document doc in snapshotKDSRef)
    {
      await doc.reference.delete();
    }

    print("${snapshotKDSRef.length} delete kds");
    while((snapshotKDSRef.length ?? 0) > 0)
      {
         snapshotKDSRef = await kdsRef.get();
        for(Document doc in snapshotKDSRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotKDSRef.length} delete kds");
      }
   // print("${snapshotKDSRef.length} delete kds");

    // kdsRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //qprint

    var snapshotQPrintRef = await qPrintRef.get();
    for(Document doc in snapshotQPrintRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotQPrintRef.length} delete qprint");
    while((snapshotQPrintRef.length ?? 0) > 0)
      {
         snapshotQPrintRef = await qPrintRef.get();
        for(Document doc in snapshotQPrintRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotQPrintRef.length} delete qprint");
      }
    //print("${snapshotQPrintRef.length} delete qprint");
    // qPrintRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //qorder

    var snapshotQOrderRef = await qOrderRef.get();
    for(Document doc in snapshotQOrderRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotQOrderRef.length} delete qorder");
    while((snapshotQOrderRef.length ?? 0) > 0)
      {
         snapshotQOrderRef = await qOrderRef.get();
        for(Document doc in snapshotQOrderRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotQOrderRef.length} delete qorder");
      }
    //print("${snapshotQOrderRef.length} delete qorder");
    // qOrderRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //kds done

    var snapshotKDSDoneRef = await pKDSDoneRef.get();
    for(Document doc in snapshotKDSDoneRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotKDSDoneRef.length} delete kds done");
    while((snapshotKDSDoneRef.length ?? 0) > 0)
      {
         snapshotKDSDoneRef = await pKDSDoneRef.get();
        for(Document doc in snapshotKDSDoneRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotKDSDoneRef.length} delete kds done");
      }
   // print("${snapshotKDSDoneRef.length} delete kds done");
    // pKDSDoneRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    //collect now

    var snapshotCollectNowRef = await collectNowRef.get();
    for(Document doc in snapshotCollectNowRef)
    {
      await doc.reference.delete();
    }
    print("${snapshotCollectNowRef.length} delete collect now");
    while((snapshotCollectNowRef.length ?? 0) > 0)
      {
         snapshotCollectNowRef = await collectNowRef.get();
        for(Document doc in snapshotCollectNowRef)
        {
          await doc.reference.delete();
        }
         print("${snapshotCollectNowRef.length} delete collect now");
      }
    //print("${snapshotCollectNowRef.length} delete collect now");
    // collectNowRef.get().then(
    //         (snapshot) {
    //       for (Document doc in snapshot) {
    //         doc.reference.delete();
    //         //OrderModel orderModel = OrderModel.formDocument(doc);
    //         //print(orderModel.orderId);
    //       }
    //     }
    // );

    print("delete command");
    storeRef
        .collection("command")
        .document(storeId)
        .delete();
  }
  catch(ex)
  {
    return ex.toString();
  }

   return "Data cleared";
}


@CloudFunction()
Future<Response> function(Request request) => app.call(request);