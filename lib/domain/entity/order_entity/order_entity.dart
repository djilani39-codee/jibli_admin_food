import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jibli_admin_food/core/use_case/use_case.dart';

part 'order_entity.g.dart';

@JsonSerializable()
class OrderEntity extends Params {
  OrderEntity(
      {required this.id,
      required this.elapsed,
      required this.date,
      required this.time,
      required this.status,
      required this.hint,
      required this.market,
      required this.orders,
      required this.wallet,
      required this.deliveryFee,
      required this.paidCash,
      required this.client,
      required this.address,
      required this.distance,
      required this.googleMaps});

  final dynamic id;
  final String? elapsed;
  final String? date;
  final String? time;
  final String? status;
  final String? hint;
  final String? market;
  final List<Orders>? orders;
  final int? wallet;
  final int? deliveryFee;
  @JsonKey(name: 'paid_cash')
  final dynamic paidCash;
  final String? client;
  final String? address;
  final String? distance;
  final String? googleMaps;
  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);
  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

@JsonSerializable()
class Orders {
  Orders(
      {required this.name,
      required this.options,
      required this.quantity,
      required this.price});

  final dynamic name;
  final List<dynamic>? options;
  final int? quantity;
  final dynamic price;
  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
