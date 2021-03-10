# Flutter DDD 강의 노트
## Source
[Reco Coder](https://resocoder.com/2020/03/09/flutter-firebase-ddd-course-1-domain-driven-design-principles/)

## Lecture Notes
### Lecture 02 ~ 03
  1. Dart 에서 null safety 가 적용되면서 중괄호를 사용한 contsructor 들이 단순화 가능해졌다.
  ```dart
  // failures.dart를 예로 들면
  @freezed
  abstract class ValueFailure<T> with _$ValueFailure<T> {
    // const factory ValueFailure.invalidEmail({ @required String failedValue }) = InvalidEmail<T>; 이런 형식이
    const factory ValueFailure.invalidEmail(String failedValue) = InvalidEmail<T>; // 이렇게 표현 가능함.
    const factory ValueFailure.shortPassword(String failedValue) =
        ShortPassword<T>;
  }
  ```
### Lecture 04
  1. 강의에서는 bloc extension으로 생성되는 코드와 강의에서 사용하는 코드가 달라서 수정하는 부분이 있지만, 최근 버전의 extension은 reco coder 에서 진행하는 코드와 동일한 패턴의 코드임
  2. sign_in_form_state 에서 authFailureOrSuccess를 Option 타입으로 선언하지만, null-safety를 활용하면, `Either<AuthFailure, Unit>? authFailureOrSuccess,`로 표현 가능함.