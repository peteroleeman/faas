

import 'package:firedart/firestore/models.dart';
import 'package:helloagain/util_datetime.dart';
import 'package:uuid/uuid.dart';

const kCashOutModelId = 'id';
const kCashOutModelDate = 'datevalue';
const kCashOutModelTime = 'timevalue';
const kCashOutModelMiliCreated = "milicreated";
const kCashOutModelCashTotal = 'cashtotal';
const kCashOutModelCashOut = 'cashout';
const kCashOutModelReason = 'reason';
const kCashOutModelUsername = 'username';
const kCashOutModelPhoneNumber = 'phonenumber';

class CashOutModel {
  String id;
  String dateValue;
  String timeValue;
  int createdMillis;
  double cashTotal;
  double cashOut;
  String reason;
  String username;
  String phoneNumber;

  CashOutModel({
   required this.id,
     required this.dateValue,
    required this.timeValue,
     required this.createdMillis,
     required this.cashTotal,
     required this.cashOut,
     required this.reason,
    required this.username,
    required this.phoneNumber,
  });

  factory CashOutModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kCashOutModelId] ?? "";
    } catch (ex) {}

    var dateValue = UtilDateTime.getCurrentDate();
    try {
      dateValue = doc[kCashOutModelDate] ?? UtilDateTime.getCurrentDate();
    } catch (ex) {}

    var timeValue = UtilDateTime.getCurrentTime();
    try {
      timeValue = doc[kCashOutModelTime] ?? UtilDateTime.getCurrentTime();
    } catch (ex) {}

    var createdMillis = DateTime.now().millisecondsSinceEpoch;
    try {
      createdMillis =
          doc[kCashOutModelTime] ?? DateTime.now().millisecondsSinceEpoch;
    } catch (ex) {}

    var cashTotal = 0.0;
    try {
      cashTotal =
          double.tryParse(doc[kCashOutModelCashTotal]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    var cashOut = 0.0;
    try {
      cashOut =
          double.tryParse(doc[kCashOutModelCashOut]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    var reason = "";
    try {
      reason = doc[kCashOutModelReason] ?? "";
    } catch (ex) {}

    var username = "";
    try {
      username = doc[kCashOutModelUsername] ?? "";
    } catch (ex) {}

    var phoneNumber = "";
    try {
      phoneNumber = doc[kCashOutModelPhoneNumber] ?? "";
    } catch (ex) {}

    return CashOutModel(
      id: id,
      dateValue: dateValue,
      timeValue: timeValue,
      createdMillis: createdMillis,
      cashTotal: cashTotal,
      cashOut: cashOut,
      reason: reason,
      username: username,
      phoneNumber: phoneNumber,
    );
  }

  factory CashOutModel.newCashOut(String userName, String phoneNumber,
      String reason, double cashTotal, double cashOut) {
    return CashOutModel(
      id: Uuid().v4(),
      dateValue: UtilDateTime.getCurrentDate(),
      timeValue: UtilDateTime.getCurrentTime(),
      createdMillis: DateTime.now().millisecondsSinceEpoch,
      cashTotal: cashTotal,
      cashOut: cashOut,
      reason: reason,
      username: userName,
      phoneNumber: phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kCashOutModelId: id ?? "",
      kCashOutModelDate: dateValue ?? UtilDateTime.getCurrentDate(),
      kCashOutModelTime: timeValue ?? UtilDateTime.getCurrentTime(),
      kCashOutModelMiliCreated:
          createdMillis ?? DateTime.now().millisecondsSinceEpoch,
      kCashOutModelCashTotal: cashTotal ?? 0.0,
      kCashOutModelCashOut: cashOut ?? 0.0,
      kCashOutModelReason: reason ?? "",
      kCashOutModelUsername: username ?? "",
      kCashOutModelPhoneNumber: phoneNumber ?? "",
    };
  }

  CashOutModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kCashOutModelId] ?? "",
        dateValue = map[kCashOutModelDate] ?? UtilDateTime.getCurrentDate(),
        timeValue = map[kCashOutModelTime] ?? UtilDateTime.getCurrentTime(),
        createdMillis = map[kCashOutModelMiliCreated] ??
            DateTime.now().millisecondsSinceEpoch,
        cashTotal =
            double.tryParse(map[kCashOutModelCashTotal]?.toString() ?? "0.0") ??
                0.0,
        cashOut =
            double.tryParse(map[kCashOutModelCashOut]?.toString() ?? "0.0") ??
                0.0,
        reason = map[kCashOutModelReason] ?? "",
        username = map[kCashOutModelUsername] ?? "",
        phoneNumber = map[kCashOutModelPhoneNumber] ?? "";
}
