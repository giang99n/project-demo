import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbnk/blocs/login/login_bloc.dart';
import 'package:projectbnk/network/apis.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginBloc(LoginInitState(), Api()))
      ],
      child: Container(),
    );
  }
}
