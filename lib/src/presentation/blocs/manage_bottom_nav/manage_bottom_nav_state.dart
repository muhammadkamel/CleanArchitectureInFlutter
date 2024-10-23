part of 'manage_bottom_nav_bloc.dart';

enum ManageBottomNavStatus {
  initial,
  loading,
  success,
  failure,
}

final class ManageBottomNavState extends Equatable {
  final ManageBottomNavStatus status;
  final int index;

  const ManageBottomNavState({
    required this.status,
    this.index = 0,
  });

  @override
  List<Object> get props => [
        status,
        index,
      ];

  ManageBottomNavState copyWith({
    ManageBottomNavStatus? status,
    int? index,
  }) {
    return ManageBottomNavState(
      status: status ?? this.status,
      index: index ?? this.index,
    );
  }
}
