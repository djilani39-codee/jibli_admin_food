// ignore_for_file: one_member_abstracts

import 'package:jibli_admin_food/core/filter.dart';

import '../../core/excptions/exceptions.dart';
import '../../core/result/result.dart';

abstract class OtherRepository {
  Future<Result<dynamic, Exceptions>> updateWorkDays(Filter params);
  Future<Result<dynamic, Exceptions>> login(Filter params);
  Future<Result<dynamic, Exceptions>> onVacation(Filter params);
}
