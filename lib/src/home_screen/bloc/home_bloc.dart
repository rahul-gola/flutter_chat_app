import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.getUsersUseCase) : super(const HomeState()) {
    on<HomeGetAllUsersEvent>((event, emit) async {
      emit(state.copyWith(userList: event.userList));
    });

    init();
  }

  final GetUsersUseCase getUsersUseCase;

  void init() {
    getUsersUseCase.execute().listen((value) {
      value.fold(
        (error) {},
        (data) {
          add(HomeGetAllUsersEvent(data));
        },
      );
    });
  }
}
