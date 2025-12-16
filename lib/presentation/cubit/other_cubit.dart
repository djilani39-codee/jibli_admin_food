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
}
