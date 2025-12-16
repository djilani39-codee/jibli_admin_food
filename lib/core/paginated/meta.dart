import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta.freezed.dart';

@freezed
class Meta with _$Meta {
  const factory Meta(
      {final int? total,
      final int? currentPage,
      final int? nextPage,
      final int? perPage,
      final int? lastPage}) = _Meta;
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] as int?,
      currentPage: json['currentPage'] as int?,
      nextPage: json['nextPage'] as int?,
      perPage: json['perPage'] as int?,
      lastPage: json['lastPage'] as int?,
    );
  }
}
