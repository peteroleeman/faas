

import 'package:firedart/firestore/models.dart';
import 'package:helloworld/constant.dart';
import 'package:uuid/uuid.dart';

const kKDSStatusModelId = 'id';
const kKDSStatusModelTerminalId =
    "terminalid"; //false = plain, true = select qty
const kKDSStatusModelStatus = "status";

class KDSStatusModel {
  String id;
  String terminalId;
  int status = kStatusStart;

  KDSStatusModel({
    required this.id,
    required this.terminalId,
    required this.status,
  });

  factory KDSStatusModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kKDSStatusModelId] ?? "";
    } catch (ex) {}

    var terminalId = "";
    try {
      terminalId = doc[kKDSStatusModelTerminalId] ??
          ""; //false = plain, true = select qty
    } catch (ex) {}

    var status = kStatusStart;
    try {
      status = int.parse(
              doc[kKDSStatusModelStatus]?.toString() ?? "$kStatusStart") ??
          kStatusStart;
    } catch (ex) {}

    return KDSStatusModel(
      id: id,
      terminalId: terminalId, //false = plain, true = select qty
      status: status,
    );
  }

  factory KDSStatusModel.newStatus(String terminalId) {
    return KDSStatusModel(
      id: Uuid().v4(),
      terminalId: terminalId,
      status: kStatusStart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKDSStatusModelId: id ?? Uuid().v4(),
      kKDSStatusModelTerminalId:
          terminalId ?? "", //false = plain, true = select qty
      kKDSStatusModelStatus: status ?? kStatusStart,
    };
  }

  KDSStatusModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kKDSStatusModelId].toString(),
        terminalId = map[kKDSStatusModelTerminalId].toString(),
        status = map[kKDSStatusModelStatus];


}
