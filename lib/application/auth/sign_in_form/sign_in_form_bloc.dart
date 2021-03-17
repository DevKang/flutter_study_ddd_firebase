import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ddd_firebase/domain/auth/auth_failure.dart';
import 'package:flutter_ddd_firebase/domain/auth/i_auth_facade.dart';
import 'package:flutter_ddd_firebase/domain/auth/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

@Injectable()
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccess: null,
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccess: null,
        );
      },
      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.registerWithEmailAndPassword,
        );
      },
      signInWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.signInWithEmailAndPassword,
        );
      },
      signInWithGooglePressed: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccess: null,
        );
        final result = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccess: result,
        );
      },
    );
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function(
      EmailAddress emailAddress,
      Password password,
    )
        forwardedCall,
  ) async* {
    Either<AuthFailure, Unit>? result;
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccess: null,
      );
      result = await forwardedCall(
        state.emailAddress,
        state.password,
      );
    }

    yield state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccess: result,
    );
  }
}
