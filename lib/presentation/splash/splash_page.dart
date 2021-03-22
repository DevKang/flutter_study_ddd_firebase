import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_firebase/application/auth/sign_out/auth_bloc.dart';
import 'package:flutter_ddd_firebase/presentation/routes/application.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) =>
              Application.router?.navigateTo(context, "/notes_overview"),
          unauthenticated: (_) =>
              Application.router?.navigateTo(context, "/signin"),
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
