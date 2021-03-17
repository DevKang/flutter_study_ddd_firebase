import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd_firebase/presentation/sign_in/sign_in_page.dart';
import 'package:flutter_ddd_firebase/presentation/splash/splash_page.dart';

Handler splashRouteHandler = Handler(handlerFunc: (
  BuildContext? context,
  Map<String, List<String>> params,
) {
  return SplashPage();
});

Handler signInRouteHandler = Handler(handlerFunc: (
  BuildContext? context,
  Map<String, List<String>> params,
) {
  return SignInPage();
});
