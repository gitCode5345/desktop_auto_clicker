import 'package:desktop_auto_clicker/src/features/main_page/di/main_page_dependency.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  MainPageDependency.init();
}
