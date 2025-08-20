part of 'home_bloc.dart';

@immutable
class HomeState {
  const HomeState({
    this.userList = const <UserDataModel>[],
  });

  final List<UserDataModel> userList;

  HomeState copyWith({
    List<UserDataModel>? userList,
  }) {
    return HomeState(
      userList: userList ?? this.userList,
    );
  }
}
