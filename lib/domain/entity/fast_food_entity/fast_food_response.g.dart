// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_food_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FastFoodResponseAdapter extends TypeAdapter<FastFoodResponse> {
  @override
  final int typeId = 29;

  @override
  FastFoodResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FastFoodResponse(
      fields[0] as bool,
      fields[1] as FastFoodEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, FastFoodResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FastFoodResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FastFoodEntityAdapter extends TypeAdapter<FastFoodEntity> {
  @override
  final int typeId = 23;

  @override
  FastFoodEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FastFoodEntity(
      markets: (fields[8] as List?)?.cast<Markets>(),
      userId: fields[0] as int?,
      userName: fields[1] as String?,
      userEmail: fields[2] as String?,
      userPhone: fields[3] as String?,
      userPhone2: fields[5] as String?,
      apiToken: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FastFoodEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.userEmail)
      ..writeByte(3)
      ..write(obj.userPhone)
      ..writeByte(5)
      ..write(obj.userPhone2)
      ..writeByte(7)
      ..write(obj.apiToken)
      ..writeByte(8)
      ..write(obj.markets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FastFoodEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MarketsAdapter extends TypeAdapter<Markets> {
  @override
  final int typeId = 25;

  @override
  Markets read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Markets(
      fields[0] as String?,
      fields[1] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as String?,
      fields[9] as bool?,
      fields[10] as String?,
      fields[11] as Image?,
    );
  }

  @override
  void write(BinaryWriter writer, Markets obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.marketId)
      ..writeByte(1)
      ..write(obj.marketName)
      ..writeByte(3)
      ..write(obj.workHours)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude)
      ..writeByte(7)
      ..write(obj.marketPhone)
      ..writeByte(8)
      ..write(obj.marketMobile)
      ..writeByte(9)
      ..write(obj.onVacation)
      ..writeByte(10)
      ..write(obj.topicNotification)
      ..writeByte(11)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FastFoodResponse _$FastFoodResponseFromJson(Map<String, dynamic> json) =>
    FastFoodResponse(
      json['success'] as bool,
      json['data'] == null
          ? null
          : FastFoodEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FastFoodResponseToJson(FastFoodResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

FastFoodEntity _$FastFoodEntityFromJson(Map<String, dynamic> json) =>
    FastFoodEntity(
      markets: (json['markets'] as List<dynamic>?)
          ?.map((e) => Markets.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: (json['user_id'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
      userEmail: json['user_email'] as String?,
      userPhone: json['user_phone'] as String?,
      userPhone2: json['user_phone2'] as String?,
      apiToken: json['api_token'] as String?,
    );

Map<String, dynamic> _$FastFoodEntityToJson(FastFoodEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_email': instance.userEmail,
      'user_phone': instance.userPhone,
      'user_phone2': instance.userPhone2,
      'api_token': instance.apiToken,
      'markets': instance.markets,
    };

Markets _$MarketsFromJson(Map<String, dynamic> json) => Markets(
      json['market_id'] as String?,
      json['market_name'] as String?,
      json['work_hours'] as String?,
      json['address'] as String?,
      json['latitude'] as String?,
      json['longitude'] as String?,
      json['market_phone'] as String?,
      json['market_mobile'] as String?,
      json['on_vacation'] as bool?,
      json['topic_notification'] as String?,
      json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MarketsToJson(Markets instance) => <String, dynamic>{
      'market_id': instance.marketId,
      'market_name': instance.marketName,
      'work_hours': instance.workHours,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'market_phone': instance.marketPhone,
      'market_mobile': instance.marketMobile,
      'on_vacation': instance.onVacation,
      'topic_notification': instance.topicNotification,
      'image': instance.image,
    };

WorkDaysEntity _$WorkDaysEntityFromJson(Map<String, dynamic> json) =>
    WorkDaysEntity(
      json['openingHour'] as String?,
      json['openingMinute'] as String?,
      json['closingHour'] as String?,
      json['closingMinute'] as String?,
      json['openingDays'] as List<dynamic>?,
    );

Map<String, dynamic> _$WorkDaysEntityToJson(WorkDaysEntity instance) =>
    <String, dynamic>{
      'openingHour': instance.openingHour,
      'openingMinute': instance.openingMinute,
      'closingHour': instance.closingHour,
      'closingMinute': instance.closingMinute,
      'openingDays': instance.openingDays,
    };
