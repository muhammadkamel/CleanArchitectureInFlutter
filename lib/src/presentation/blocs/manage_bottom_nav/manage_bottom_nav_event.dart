part of 'manage_bottom_nav_bloc.dart';

sealed class ManageBottomNavEvent extends Equatable {
  const ManageBottomNavEvent();

  @override
  List<Object> get props => [];
}

class UpdateIndexEvent extends ManageBottomNavEvent {
  final int index;

  const UpdateIndexEvent(this.index);

  @override
  List<Object> get props => [index];
}
