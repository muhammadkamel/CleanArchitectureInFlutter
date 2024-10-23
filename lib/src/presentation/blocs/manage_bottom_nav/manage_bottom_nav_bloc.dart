import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manage_bottom_nav_event.dart';
part 'manage_bottom_nav_state.dart';

class ManageBottomNavBloc
    extends Bloc<ManageBottomNavEvent, ManageBottomNavState> {
  ManageBottomNavBloc()
      : super(ManageBottomNavState(
          status: ManageBottomNavStatus.initial,
        )) {
    on<UpdateIndexEvent>(_updateIndexHandler);
  }

  FutureOr<void> _updateIndexHandler(
      UpdateIndexEvent event, Emitter<ManageBottomNavState> emit) async {
    emit(state.copyWith(index: event.index));
  }
}
