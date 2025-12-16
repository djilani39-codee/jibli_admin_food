part of 'other_cubit.dart';

@freezed
class OtherState with _$OtherState {
  const factory OtherState.initial() = _Initial;
  const factory OtherState.loading() = _loading;
  const factory OtherState.logedIn() = _LogedIn;
  const factory OtherState.success({String? msg}) = _success;
  const factory OtherState.eroor(ErrorState error) = _eroor;
}
