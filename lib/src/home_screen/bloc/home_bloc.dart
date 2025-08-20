import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/util/request_controller.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> with RequestController {
  HomeBloc(
    this.getUsersUseCase,
    this.signOutUser,
    this.currentUserUsecase,
  ) : super(const HomeState()) {
    on<HomeGetAllUsersEvent>((event, emit) async {
      emit(state.copyWith(userList: event.userList));
    });

    on<CurrentUserDataEvent>((event, emit) async {
      emit(state.copyWith(currentUser: event.value));
    });

    init();
  }

  final GetUsersUseCase getUsersUseCase;
  final UserSignOutUseCase signOutUser;
  final CurrentUserUsecase currentUserUsecase;

  void init() {
    getData<UserDataModel>(
      currentUserUsecase,
      onSuccess: (s) {
        add(CurrentUserDataEvent(s));
      },
    );

    getUsersUseCase.execute().listen((value) {
      value.fold(
        (error) {},
        (data) {
          add(HomeGetAllUsersEvent(data));
        },
      );
    });
  }

  void signOut(VoidCallback success) {
    getData<bool>(signOutUser, onSuccess: (s) => success());
  }
}
