// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../sign_in/sign_in_page.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SignInPageRoute.name: (entry) {
      return _i1.CupertinoPageX(entry: entry, child: _i2.SignInPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig<SignInPageRoute>(SignInPageRoute.name,
            path: '/sign-in-page',
            routeBuilder: (match) => SignInPageRoute.fromMatch(match))
      ];
}

class SignInPageRoute extends _i1.PageRouteInfo {
  const SignInPageRoute() : super(name, path: '/sign-in-page');

  SignInPageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'SignInPageRoute';
}
