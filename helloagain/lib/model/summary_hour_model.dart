
import 'package:firedart/firedart.dart';
import 'package:helloagain/constant.dart';
import 'package:helloagain/model/kds_status_model.dart';
import 'package:helloagain/model/orderitem_model.dart';
import 'package:helloagain/util_datetime.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const kSummaryHourModelId = 'id';
const kSummaryHourModelIndex = 'index';
const kSummaryHourModelTitle = "title";
const kSummaryHourModelTotalReceiptNumber = "totalreceipt";
const kSummaryHourModelGTOSales = "totalgtosales";
const kSummaryHourModelGST = "totalgst";
const kSummaryHourModelDiscount = "totaldiscount";
const kSummaryHourModelPax = "totalpax";

const kSummaryHourModelSales = "sales";
const kSummaryHourModelQty = "qty";

class SummaryHourModel {
  String id;
  String title;
  int indexValue;
  int receiptNumberTotal;
  double gtoSalesTotal;
  double gstTotal;
  double discountTotal;
  int paxTotal;

  double salesTotal;
  int qtyTotal;

  SummaryHourModel({
    required this.id,
    required this.title,
    required this.indexValue,
    required this.receiptNumberTotal,
    required this.gtoSalesTotal,
    required this.gstTotal,
    required this.discountTotal,
    required this.paxTotal,
    required this.salesTotal,
    required this.qtyTotal,
  });

  factory SummaryHourModel.newSummary(){
    return SummaryHourModel(id: "", title: "", indexValue: 0, receiptNumberTotal: 0, gtoSalesTotal: 0.0, gstTotal: 0.0, discountTotal: 0.0, paxTotal: 0, salesTotal: 0.0, qtyTotal: 0);
  }

  addHourModel(SummaryHourModel hourModel) {
    if (hourModel == null) {
      return;
    }

    receiptNumberTotal = receiptNumberTotal + hourModel.receiptNumberTotal;
    gtoSalesTotal = gtoSalesTotal + hourModel.gtoSalesTotal;
    gstTotal = gstTotal + hourModel.gstTotal;
    discountTotal = discountTotal + hourModel.discountTotal;
    paxTotal = paxTotal + hourModel.paxTotal;
    salesTotal = salesTotal + hourModel.salesTotal;
    qtyTotal = qtyTotal + hourModel.qtyTotal;
  }

  String getSummaryText(String machineId, String batchId) {
    return "$machineId|${UtilDateTime.getDateTimeString("ddMMyyyy")}|$batchId|${hourlyShortMap[indexValue]}|${receiptNumberTotal.toString()}|${gtoSalesTotal.toStringAsFixed(2)}|${gstTotal.toStringAsFixed(2)}|${discountTotal.toStringAsFixed(2)}|${paxTotal.toString()}";
  }

  factory SummaryHourModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kSummaryHourModelId] ?? "";
    } catch (ex) {}

    var title = "";
    try {
      title = doc[kSummaryHourModelTitle] ?? "";
    } catch (ex) {}

    var indexValue = 0;
    try {
      indexValue = doc[kSummaryHourModelIndex] ?? 0;
    } catch (ex) {}

    var receiptNumberTotal = 0;
    try {
      receiptNumberTotal = doc[kSummaryHourModelTotalReceiptNumber] ?? 0;
    } catch (ex) {}

    var gtoSalesTotal = 0.0;
    try {
      gtoSalesTotal = double.tryParse(
              doc[kSummaryHourModelGTOSales]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var gstTotal = 0.0;
    try {
      gstTotal =
          double.tryParse(doc[kSummaryHourModelGST]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    var discountTotal = 0.0;
    try {
      discountTotal = double.tryParse(
              doc[kSummaryHourModelDiscount]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var paxTotal = 0;
    try {
      paxTotal = doc[kSummaryHourModelPax] ?? 0;
    } catch (ex) {}

    var salesTotal = 0.0;
    try {
      salesTotal =
          double.tryParse(doc[kSummaryHourModelSales]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    var qtyTotal = 0;
    try {
      qtyTotal = doc[kSummaryHourModelQty] ?? 0;
    } catch (ex) {}

    return SummaryHourModel(
      id: id,
      title: title,
      indexValue: indexValue,
      receiptNumberTotal: receiptNumberTotal,
      gtoSalesTotal: gtoSalesTotal,
      gstTotal: gstTotal,
      discountTotal: discountTotal,
      paxTotal: paxTotal,
      salesTotal: salesTotal,
      qtyTotal: qtyTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kSummaryHourModelId: id,
      kSummaryHourModelTitle: title ?? "",
      kSummaryHourModelIndex: indexValue ?? 0,
      kSummaryHourModelTotalReceiptNumber: receiptNumberTotal ?? 0,
      kSummaryHourModelGTOSales: gtoSalesTotal ?? 0.0,
      kSummaryHourModelGST: gstTotal ?? 0.0,
      kSummaryHourModelDiscount: discountTotal ?? 0.0,
      kSummaryHourModelPax: paxTotal ?? 0,
      kSummaryHourModelSales: salesTotal ?? 0.0,
      kSummaryHourModelQty: qtyTotal ?? 0,
    };
  }

  SummaryHourModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kSummaryHourModelId].toString(),
        title = map[kSummaryHourModelTitle].toString(),
        indexValue = map[kSummaryHourModelIndex] ?? 0,
        receiptNumberTotal = map[kSummaryHourModelTotalReceiptNumber] ?? 0,
        gtoSalesTotal = map[kSummaryHourModelGTOSales] ?? 0.0,
        gstTotal = map[kSummaryHourModelGST] ?? 0.0,
        discountTotal = map[kSummaryHourModelDiscount] ?? 0.0,
        paxTotal = map[kSummaryHourModelPax] ?? 0,
        salesTotal = map[kSummaryHourModelSales] ?? 0.0,
        qtyTotal = map[kSummaryHourModelQty] ?? 0;
}
