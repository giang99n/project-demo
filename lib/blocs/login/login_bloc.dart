import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectbnk/network/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_events.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  Api apiRepository;

  LoginBloc(LoginState initialState, this.apiRepository) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    final pref = await SharedPreferences.getInstance();
    if (event is StartEvent) {
      yield LoginInitState();
    } else if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      var data = await apiRepository.login(event.email, event.password);
      if (data != null) {
        if (data!.status == 1) {
          pref.setString('token', data!.result ?? "");
          pref.setString('status', data!.status.toString() ?? "");
          yield LoginSuccessState();
        } else if (data.status == 0) {
          yield LoginErrorState(
              message: data.message ??
                  "đăng nhập thất bại"); /////////////////////////
        }
      } else {
        print('data null');
      }
    }
  }
}
