import 'package:flutter_bloc/flutter_bloc.dart';

extension CubitExtensions<T> on BlocBase<T> {
  void updateCurrentState() {
    if (isClosed) return;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    emit(state);
  }

  void update(T state) {
    if (isClosed) return;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    emit(state);
  }
}
