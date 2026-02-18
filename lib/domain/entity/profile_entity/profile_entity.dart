import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
@HiveType(typeId: 23)
class ProfileEntity {
  ProfileEntity(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.createdAt,
      this.completed,
      this.emailVerified,
      this.gender,
      this.image,
      this.phone,
      });

  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'first_name')
  final String? firstName;
  @HiveField(2)
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @HiveField(3)
  @JsonKey(name: "last_name")
  final String? lastName;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? phone;
  @HiveField(6)
  final String? gender;
  @HiveField(7)
  String? image;
  @HiveField(8)
  final bool? completed;
  @HiveField(9)
  @JsonKey(name: "email_verified")
  final bool? emailVerified;


  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);
}




