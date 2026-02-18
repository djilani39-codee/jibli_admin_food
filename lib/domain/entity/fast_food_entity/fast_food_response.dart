import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jibli_admin_food/domain/entity/food_entity/food_entity.dart';

part 'fast_food_response.g.dart';

@JsonSerializable()
@HiveType(typeId: 29)
class FastFoodResponse {
  FastFoodResponse(this.success, this.data);
  @HiveField(0)
  final bool success;
  @HiveField(1)
  final FastFoodEntity? data;

  factory FastFoodResponse.fromJson(Map<String, dynamic> json) =>
      _$FastFoodResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FastFoodResponseToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 23)
class FastFoodEntity {
  @HiveField(0)
  @JsonKey(name: "user_id")
  final int? userId;
  @HiveField(1)
  @JsonKey(name: "user_name")
  final String? userName;
  @HiveField(2)
  @JsonKey(name: "user_email")
  final String? userEmail;
  @HiveField(3)
  @JsonKey(name: "user_phone")
  @HiveField(4)
  final String? userPhone;
  @HiveField(5)
  @JsonKey(name: "user_phone2")
  @HiveField(6)
  final String? userPhone2;
  @HiveField(7)
  @JsonKey(name: "api_token")
  final String? apiToken;
  @HiveField(8)
  final List<Markets>? markets;
 
  factory FastFoodEntity.fromJson(Map<String, dynamic> json) =>
      _$FastFoodEntityFromJson(json);

  FastFoodEntity(
      {required this.markets,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.userPhone,
      required this.userPhone2,
      required this.apiToken,});
  Map<String, dynamic> toJson() => _$FastFoodEntityToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 25)
class Markets {
  Markets(
      this.marketId,
      this.marketName,
      this.workHours,
      this.address,
      this.latitude,
      this.longitude,
      this.marketPhone,
      this.marketMobile,
      this.onVacation,
      this.topicNotification,
      this.image);
  @HiveField(0)
  @JsonKey(name: "market_id")
  final String? marketId;
  @HiveField(1)
  @JsonKey(name: "market_name")
  @HiveField(2)
  final String? marketName;
  @HiveField(3)
  @JsonKey(name: "work_hours")
  String? workHours;
  @HiveField(4)
  final String? address;
  @HiveField(5)
  final String? latitude;
  @HiveField(6)
  final String? longitude;
  @HiveField(7)
  @JsonKey(name: "market_phone")
  final String? marketPhone;
  @HiveField(8)
  @JsonKey(name: "market_mobile")
  final String? marketMobile;
  @HiveField(9)
  @JsonKey(name: "on_vacation")
  bool? onVacation;
  @HiveField(10)
  @JsonKey(name: "topic_notification")
  final String? topicNotification;
  @HiveField(11)
  final Image? image;
  factory Markets.fromJson(Map<String, dynamic> json) =>
      _$MarketsFromJson(json);
  Map<String, dynamic> toJson() => _$MarketsToJson(this);
}

@JsonSerializable()
class WorkDaysEntity {
  WorkDaysEntity(this.openingHour, this.openingMinute, this.closingHour,
      this.closingMinute, this.openingDays);
  final String? openingHour;
  final String? openingMinute;
  final String? closingHour;
  final String? closingMinute;
  final List? openingDays;

  factory WorkDaysEntity.fromJson(Map<String, dynamic> json) =>
      _$WorkDaysEntityFromJson(json);
  Map<String, dynamic> toJson() => _$WorkDaysEntityToJson(this);
}
