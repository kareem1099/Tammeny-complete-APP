part of 'signin_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInFailure extends SignInState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class SignInSuccess extends SignInState {
  final UserEntity userEntity;

  SignInSuccess({required this.userEntity});
}
