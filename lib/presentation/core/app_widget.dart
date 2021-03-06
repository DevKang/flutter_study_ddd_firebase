import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_firebase/application/auth/sign_out/auth_bloc.dart';
import 'package:flutter_ddd_firebase/injection.dart';
import 'package:flutter_ddd_firebase/presentation/routes/application.dart';
import 'package:flutter_ddd_firebase/presentation/routes/router.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested())),
      ],
      child: MaterialApp(
        onGenerateRoute: Application.router!.generator,
        title: "Notes",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.green[800],
          accentColor: Colors.blueAccent,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue[900],
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
