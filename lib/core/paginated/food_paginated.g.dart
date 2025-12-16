// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodPaginatedImpl _$$FoodPaginatedImplFromJson(Map<String, dynamic> json) =>
    _$FoodPaginatedImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FoodEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$$FoodPaginatedImplToJson(_$FoodPaginatedImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
    };
