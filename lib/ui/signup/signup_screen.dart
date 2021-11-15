
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbnk/blocs/signup/signup_bloc.dart';
import 'package:projectbnk/network/apis.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc(SignupInitState(), Api()))
      ],
      child: Container(),
    );
  }
}
