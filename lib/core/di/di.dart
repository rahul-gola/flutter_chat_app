import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_chat_app/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(initializerName: 'init')
Future<void> initDependencyInjection() async {
  getIt.init();
  await $initDomainModule(getIt);
  await $initDataModule(getIt);
}
