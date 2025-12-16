// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileEntityAdapter extends TypeAdapter<ProfileEntity> {
  @override
  final int typeId = 23;

  @override
  ProfileEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileEntity(
      id: fields[0] as int?,
      firstName: fields[1] as String?,
      lastName: fields[3] as String?,
      email: fields[4] as String?,
      createdAt: fields[2] as String?,
      completed: fields[8] as bool?,
      emailVerified: fields[9] as bool?,
      gender: fields[6] as String?,
      image: fields[7] as String?,
      phone: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.completed)
      ..writeByte(9)
      ..write(obj.emailVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) =>
    ProfileEntity(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] as String?,
      completed: json['completed'] as bool?,
      emailVerified: json['email_verified'] as bool?,
      gender: json['gender'] as String?,
      image: json['image'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ProfileEntityToJson(ProfileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'created_at': instance.createdAt,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'image': instance.image,
      'completed': instance.completed,
      'email_verified': instance.emailVerified,
    };
