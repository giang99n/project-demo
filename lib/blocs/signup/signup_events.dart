part of 'signup_bloc.dart';

abstract class SignupEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends SignupEvents {}

class SignupButtonPressed extends SignupEvents {
  final String email;
  final String password;
  final String name;

  SignupButtonPressed(
      {required this.email, required this.password, required this.name});
}
