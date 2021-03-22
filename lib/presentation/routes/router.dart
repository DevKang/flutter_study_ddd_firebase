import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd_firebase/presentation/routes/route_handlers.dart';

class Routes {
  static String signIn = "/signin";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (
      BuildContext? context,
      Map<String, List<String>> params,
    ) {
      return const Center(
        child: Text("Not Found~!"),
      );
    });
    router.define("/", handler: splashRouteHandler);
    router.define(
      "/signin",
      handler: signInRouteHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/notes_overview',
      handler: notesOverviewRouteHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}

class $AppRouter {}
