import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/products/products_bloc.dart';
import 'routes.dart';
import 'themes.dart';
import 'repositories/repositories.dart';
import 'bloc/carts/carts_bloc.dart';
import 'bloc/categories/categories_bloc.dart';
import 'bloc/settings/settings_bloc.dart';
import 'pages/home_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (context) {
            return ProductsBloc(Repositories())..add(ProductLoader());
          },
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) {
            return CategoriesBloc()..add(CategoriesLoader());
          },
        ),
        BlocProvider<CartsBloc>(
          create: (context) {
            return CartsBloc(Repositories())..add(CartLoader());
          },
        ),
        BlocProvider<SettingsBloc>(create: (context) {
          return SettingsBloc()..add(SettingStarted());
        })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsSuccess) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode:
                state.setting.darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: Themes.theme(),
            darkTheme: Themes.themeDark(),
            routes: Routes.routes,
            home: HomePage(),
          );
        } else if (state is SettingsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print("Event: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("Transition: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print("Error: $error");
    super.onError(bloc, error, stackTrace);
  }
}
