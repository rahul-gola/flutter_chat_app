part of 'home_bloc.dart';

@immutable
class HomeState {
  const HomeState({
    this.userList = const <UserDataModel>[],
    this.currentUser,
  });

  final List<UserDataModel> userList;
  final UserDataModel? currentUser;

  HomeState copyWith({
    List<UserDataModel>? userList,
    UserDataModel? currentUser,
  }) {
    return HomeState(
      userList: userList ?? this.userList,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
