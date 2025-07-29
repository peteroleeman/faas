

import 'package:firedart/firestore/models.dart';
import 'package:uuid/uuid.dart';

const kBellModelId = 'id';
const kBellModelType = "type"; //false = plain, true = select qty
const kBellModelInfo = "info";
const kBellModelTitle = "title";
const kBellModelCount = "count";
const kBellModelTableId = "tableid";

class BellModel {
  String id;
  String type;
  String info;
  String title;
  String count;
  String tableId;

  BellModel({
    required this.id,
    required this.type,
    required this.info,
    required this.title,
    required this.count,
     required this.tableId,
  });

  String getCount() {
    if (count == "null") {
      return "";
    }

    return count;
  }

  String getServiceInfo() {
    String serviceInfo = info ?? "";
    if (serviceInfo == "") {
      serviceInfo = title ?? "";
    }

    return serviceInfo;
  }

  factory BellModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kBellModelId] ?? "";
    } catch (ex) {}

    var type = "false";
    try {
      type = doc[kBellModelType] ?? "false"; //false = plain, true = select qty
    } catch (ex) {}

    var title = "";
    try {
      title = doc[kBellModelTitle] ?? "";
    } catch (ex) {}

    var info = "";
    try {
      info = doc[kBellModelInfo] ?? "";
    } catch (ex) {}

    var count = "1";
    try {
      count = doc[kBellModelCount] ?? "1";
    } catch (ex) {}

    var tableId = "";
    try {
      tableId = doc[kBellModelTableId] ?? "";
    } catch (ex) {}

    return BellModel(
      id: id,
      type: type, //false = plain, true = select qty
      title: title,
      info: info,
      count: count,
      tableId: tableId,
    );
  }

  factory BellModel.newBell(String sType, String sTitle, String sInfo) {
    return BellModel(
      id: Uuid().v4(),
      type: sType,
      title: sTitle,
      info: sInfo,
      count: "1",
      tableId: "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kBellModelId: id ?? "",
      kBellModelType: type ?? "false", //false = plain, true = select qty
      kBellModelTitle: title ?? "",
      kBellModelInfo: info ?? "",
      kBellModelCount: count ?? "1",
      kBellModelTableId: tableId ?? "",
    };
  }

  BellModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kBellModelId].toString(),
        type = map[kBellModelType].toString(),
        title = map[kBellModelTitle].toString(),
        info = map[kBellModelInfo].toString(),
        tableId = map[kBellModelTableId].toString() ?? "",
        count = map[kBellModelCount].toString() ?? "1";
}
