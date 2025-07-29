

import 'package:firedart/firedart.dart';
import 'package:helloagain/constant.dart';
import 'package:helloagain/model/kds_status_model.dart';
import 'package:helloagain/model/orderitem_model.dart';
import 'package:helloagain/model/summary_hour_model.dart';
import 'package:helloagain/util_datetime.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const kSummaryDayModelId = 'id';
const kSummaryDayModelDate = "date";
const kSummaryDayModelHours = "hours";

class SummaryDayModel {
  String id;
  String dateValue;
  List<dynamic> hours = [];

  SummaryDayModel({
    required this.id,
    required this.dateValue,
    required this.hours,
  });

 factory SummaryDayModel.newSummary(){
   return SummaryDayModel(id: "", dateValue: "", hours: []);
 }


  addDaySummary(SummaryDayModel dayModel) {
    if (dayModel == null) {
      return;
    }

    if (hours.isEmpty) {
      hours = dayModel.hours;
      return;
    }

    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      for (var hourToAdd in dayModel.hours) {
        final hourToAddModel = hourToAdd as SummaryHourModel;
        if (hourToAddModel.indexValue == hourModel.indexValue) {
          hourModel.addHourModel(hourToAddModel);
          break;
        }
      }
    }
  }

  String getSummaryText(String machineId, String batchId) {
    String returnText = "";
    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      if (returnText == "") {
        returnText = hourModel.getSummaryText(machineId, "$batchId");
      } else {
        returnText =
            returnText + "\n" + hourModel.getSummaryText(machineId, "$batchId");
      }
    }

    return returnText;
  }

  /*
  summaryHourModel.receiptNumberTotal = receiptNumberTotal;
            summaryHourModel.gtoSalesTotal = gtoSalesTotal;
            summaryHourModel.gstTotal = gstTotal;
            summaryHourModel.discountTotal = discountTotal;
            summaryHourModel.paxTotal = paxTotal;
            summaryHourModel.salesTotal = salesTotal;
            summaryHourModel.qtyTotal = qtyTotal;
   */
  String getHourSummaryQtyText(String storeId) {
    String returnText = "$storeId,";
    int qty = 0;
    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      returnText = "$returnText${hourModel.qtyTotal},";
      qty = qty + hourModel.qtyTotal;
    }

    return "$qty,$returnText";
  }

  String getHourSummaryReceiptNumberText(String storeId) {
    String returnText = "$storeId,";
    int qty = 0;
    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      returnText = "$returnText${hourModel.receiptNumberTotal},";
      qty = qty + hourModel.receiptNumberTotal;
    }

    return "$qty,$returnText";
  }

  String getHourSummarySalesTotalText(String storeId) {
    String returnText = "$storeId,";
    double total = 0;
    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      returnText = "$returnText${hourModel.salesTotal},";
      total = total + hourModel.salesTotal;
    }

    return "$total,$returnText";
  }

  String getHourSummaryGTOSalesTotalText(String storeId) {
    String returnText = "$storeId,";
    double total = 0;
    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      returnText = "$returnText${hourModel.gtoSalesTotal},";
      total = total + hourModel.gtoSalesTotal;
    }

    return "$total,$returnText";
  }

  String getHourSummaryGSTTotalText(String storeId) {
    String returnText = "$storeId,";
    double total = 0;
    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      returnText = "$returnText${hourModel.gstTotal},";
      total = total + hourModel.gstTotal;
    }

    return "$total,$returnText";
  }

  String getHourSummaryDiscountTotalText(String storeId) {
    String returnText = "$storeId,";
    double total = 0;
    for (var hour in hours) {
      var hourModel = hour as SummaryHourModel;
      returnText = "$returnText${hourModel.discountTotal},";
      total = total + hourModel.discountTotal;
    }

    return "$total,$returnText";
  }

  factory SummaryDayModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kSummaryDayModelId] ?? "";
    } catch (ex) {}

    var dateValue = "";
    try {
      dateValue = doc[kSummaryDayModelDate] ?? "";
    } catch (ex) {}

    var hours = [];
    try {
      hours = doc[kSummaryDayModelHours].map((set) {
            return SummaryHourModel.fromMap(set);
          }).toList() ??
          [];
    } catch (ex) {}

    return SummaryDayModel(
      id: id,
      dateValue: dateValue,
      hours: hours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kSummaryDayModelId: id,
      kSummaryDayModelDate: dateValue ?? "",
      kSummaryDayModelHours: firestoreHours(),
    };
  }

  List<Map<String, dynamic>> firestoreHours() {
    List<Map<String, dynamic>> convertedSets = [];
    if (hours == null) {
      hours = [];
    }
    this.hours.forEach((set) {
      //OrderItemModel thisSet = set as OrderItemModel;
      convertedSets.add(set.toMap());
    });
    return convertedSets;
  }
}
