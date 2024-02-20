

import 'package:firedart/firedart.dart';
import 'package:uuid/uuid.dart';

const kVoucherModelId = 'id';
const kVoucherModelTitle = "title";
const kVoucherModelValue = "value";

class VoucherModel {
  String id;
  String title;
  String value;

  VoucherModel({
    required  this.id,
    required this.title,
    required this.value,
  });


  factory VoucherModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kVoucherModelId] ?? "";
    } catch (ex) {}

    var title = "";
    try {
      title = doc[kVoucherModelTitle] ?? "";
    } catch (ex) {}

    var value = "0.0";
    try {
      value = doc[kVoucherModelValue] ?? "0.0";
    } catch (ex) {}

    return VoucherModel(
      id: id,
      title: title,
      value: value,
    );
  }

  factory VoucherModel.newVoucherModel() {
    return VoucherModel(
      id: "V_" + Uuid().v4(),
      title: "A new voucher",
      value: "0.0",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kVoucherModelId: id,
      kVoucherModelTitle: title ?? "",
      kVoucherModelValue: value ?? "0.0",
    };
  }

  VoucherModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kVoucherModelId].toString(),
        title = map[kVoucherModelTitle].toString(),
        value = map[kVoucherModelValue].toString();
}
