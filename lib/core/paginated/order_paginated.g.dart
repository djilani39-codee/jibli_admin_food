// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderPaginatedImpl _$$OrderPaginatedImplFromJson(Map<String, dynamic> json) =>
    _$OrderPaginatedImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      more: json['more'] as bool,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$$OrderPaginatedImplToJson(
        _$OrderPaginatedImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'more': instance.more,
      'success': instance.success,
    };
