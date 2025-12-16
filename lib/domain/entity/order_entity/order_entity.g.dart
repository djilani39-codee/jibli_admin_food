// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) => OrderEntity(
      id: json['id'],
      elapsed: json['elapsed'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      status: json['status'] as String?,
      hint: json['hint'] as String?,
      market: json['market'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Orders.fromJson(e as Map<String, dynamic>))
          .toList(),
      wallet: (json['wallet'] as num?)?.toInt(),
      deliveryFee: (json['deliveryFee'] as num?)?.toInt(),
      paidCash: json['paid_cash'],
      client: json['client'] as String?,
      address: json['address'] as String?,
      distance: json['distance'] as String?,
      googleMaps: json['googleMaps'] as String?,
    );

Map<String, dynamic> _$OrderEntityToJson(OrderEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'elapsed': instance.elapsed,
      'date': instance.date,
      'time': instance.time,
      'status': instance.status,
      'hint': instance.hint,
      'market': instance.market,
      'orders': instance.orders,
      'wallet': instance.wallet,
      'deliveryFee': instance.deliveryFee,
      'paid_cash': instance.paidCash,
      'client': instance.client,
      'address': instance.address,
      'distance': instance.distance,
      'googleMaps': instance.googleMaps,
    };

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      name: json['name'],
      options: json['options'] as List<dynamic>?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: json['price'],
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'name': instance.name,
      'options': instance.options,
      'quantity': instance.quantity,
      'price': instance.price,
    };
