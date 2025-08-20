part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeGetAllUsersEvent extends HomeEvent {
  HomeGetAllUsersEvent(this.userList);

  final List<UserDataModel> userList;
}

class CurrentUserDataEvent extends HomeEvent {
  CurrentUserDataEvent(this.value);

  final UserDataModel value;
}
