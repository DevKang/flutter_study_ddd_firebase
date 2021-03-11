// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_route/auto_route.dart';
import 'package:flutter_ddd_firebase/presentation/sign_in/sign_in_page.dart';

@CupertinoAutoRouter(routes: <AutoRoute>[
  CupertinoRoute(
    page: SignInPage,
  )
])
class $AppRouter {}
