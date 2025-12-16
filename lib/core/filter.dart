import 'package:jibli_admin_food/core/use_case/use_case.dart';

class Filter extends Params {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (setPrice != null) {
      json.addEntries([MapEntry("set_price", setPrice)]);
    }
    if (setDescription != null) {
      json.addEntries([MapEntry("set_description", setDescription)]);
    }
    if (setName != null) {
      json.addEntries([MapEntry("set_name", setName)]);
    }
    if (setAvailable != null) {
      json.addEntries([MapEntry("set_available", setAvailable)]);
    }
    if (setAvailableTimeBool != null) {
      json.addEntries([MapEntry("set_available_time", setAvailableTime)]);
    }
    if (acceptorder != null) {
      json.addEntries([MapEntry("accept_order", acceptorder)]);
    }
    if (rejectOrder != null) {
      json.addEntries([MapEntry("reject_order", rejectOrder)]);
    }
    if (reason != null) {
      json.addEntries([MapEntry("reason", reason)]);
    }
    if (workHour != null) {
      json.addEntries([MapEntry("work_hours", workHour)]);
    }
    if (marketId != null) {
      json.addEntries([MapEntry("market_id", marketId)]);
    }
    if (productId != null) {
      json.addEntries([MapEntry("product_id", productId)]);
    }
    if (email != null) {
      json.addEntries([MapEntry("email", email)]);
    }
    if (password != null) {
      json.addEntries([MapEntry("password", password)]);
    }

    if (type != null) {
      json.addEntries([MapEntry("type", type)]);
    }
    if (page != null) {
      json.addEntries([MapEntry("page", page)]);
    }
    if (onVaction != null) {
      json.addEntries([MapEntry("on_vacation", onVaction)]);
    }
    if (id != null) {
      json.addEntries([MapEntry("id", id)]);
    }
    if (status != null) {
      json.addEntries([MapEntry("status", status)]);
    }
    return json;
  }

  final int? setPrice;
  final String? setDescription;
  final String? setName;
  final bool? setAvailable;
  final bool? setAvailableTimeBool;
  final String? setAvailableTime;
  final int? marketId;
  final String? productId;
  final String? type;
  final int? page;
  final int? id;
  final String? status;
  final String? email;
  final String? password;
  final bool? onVaction;
  final String? reason;
  final int? rejectOrder;
  final int? acceptorder;
  final String? workHour;

  Filter(
      {this.onVaction,
      this.workHour,
      this.reason,
      this.rejectOrder,
      this.acceptorder,
      this.marketId,
      this.productId,
      this.status,
      this.setAvailable,
      this.setAvailableTime,
      this.setAvailableTimeBool,
      this.setDescription,
      this.type,
      this.setPrice,
      this.email,
      this.setName,
      this.password,
      this.id,
      this.page});

  copyWith(
      {int? setPrice,
      String? setDescription,
      String? setName,
      bool? setAvailable,
      String? type,
      bool? onVaction,
      String? q,
      int? page,
      int? id,
      String? status}) {
    return Filter(
        setAvailable: setAvailable ?? this.setAvailable,
        setDescription: setDescription ?? this.setDescription,
        onVaction: onVaction ?? this.onVaction,
        setPrice: setPrice ?? this.setPrice,
        type: type ?? this.type,
        id: id ?? this.id,
        page: page ?? this.page,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        setAvailable,
        setDescription,
        setPrice,
        type,
        status,
        page,
        productId,
        marketId,
        setAvailableTime,
        workHour
      ];
}
