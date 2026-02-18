import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jibli_admin_food/core/bloc/error.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/domain/repository/other_repository.dart';

part 'other_state.dart';

part 'other_cubit.freezed.dart';

class OtherCubit extends Cubit<OtherState> {
  OtherCubit(this.otherRepository) : super(OtherState.initial());
  final OtherRepository otherRepository;

  login({required Filter filter}) async {
    emit(const OtherState.loading());
    final result = await otherRepository.login(filter);
    return emit(
      result.when(
        failure: (failure) {
          return failure!.maybeWhen(
            wrongCredentials: (data) => const OtherState.eroor(
              ErrorState.unAuthrized(),
            ),
            other: (data) => OtherState.eroor(
              ErrorState.other(message: "معلومات المستخدم غير صالحة"),
            ),
            orElse: () => const OtherState.eroor(
              ErrorState.other(message: "حدث خطـأ ما"),
            ),
            network: (message) =>
                OtherState.eroor(ErrorState.networkError(message: message)),
          );
        },
        success: (success) => OtherState.logedIn(),
      ),
    );
  }

  updateWorkdays({required Filter filter}) async {
    emit(const OtherState.loading());
    final result = await otherRepository.updateWorkDays(filter);
    return emit(
      result.when(
        failure: (failure) {
          return failure!.maybeWhen(
            wrongCredentials: (data) => const OtherState.eroor(
              ErrorState.unAuthrized(),
            ),
            other: (data) => OtherState.eroor(
              ErrorState.other(message: data),
            ),
            orElse: () => const OtherState.eroor(
              ErrorState.other(message: "حدث خطـأ ما"),
            ),
            network: (message) =>
                OtherState.eroor(ErrorState.networkError(message: message)),
          );
        },
        success: (success) => OtherState.success(),
      ),
    );
  }

  onVacation({required Filter filter}) async {
    emit(const OtherState.loading());
    final result = await otherRepository.onVacation(filter);
    return emit(
      result.when(
        failure: (failure) {
          return failure!.maybeWhen(
            wrongCredentials: (data) => const OtherState.eroor(
              ErrorState.unAuthrized(),
            ),
            orElse: () => const OtherState.eroor(
              ErrorState.other(message: "حدث خطـأ ما"),
            ),
            network: (message) =>
                OtherState.eroor(ErrorState.networkError(message: message)),
          );
        },
        success: (success) => OtherState.success(),
      ),
    );
  }

  Future<void> getMarketDebt({required Filter filter}) async {
    print("🚀 CUBIT: getMarketDebt called!");
    print("🚀 CUBIT: Filter: $filter");
    print("🚀 CUBIT: Emitting loading state...");
    
    emit(const OtherState.loading());
    
    print("🚀 CUBIT: Calling repository.getMarketDebt...");
    final result = await otherRepository.getMarketDebt(filter);
    
    print("🚀 CUBIT: Got result: $result");
    
    emit(
      result.when(
        failure: (failure) {
          print('🚀 CUBIT: failure state');
          return failure!.maybeWhen(
            other: (data) => OtherState.eroor(
              ErrorState.other(message: data ?? "فشل في جلب العمولة"),
            ),
            orElse: () => const OtherState.eroor(
              ErrorState.other(message: "حدث خطـأ ما"),
            ),
            network: (message) =>
                OtherState.eroor(ErrorState.networkError(message: message)),
          );
        },
        success: (data) {
          print('🚀 CUBIT: success state with data: $data');
          double debt = (data is double) ? data : (data as num).toDouble();
          return OtherState.debtLoaded(debt: debt);
        },
      ),
    );
  }
}
