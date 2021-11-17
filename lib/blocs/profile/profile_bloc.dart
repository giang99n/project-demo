import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectbnk/models/user_res.dart';
import 'package:projectbnk/network/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_events.dart';
part 'profile_state.dart';

class ProFileBloc extends Bloc<ProFileEvents, ProFileState> {
  ProFileBloc() : super(ProFileLoadingState());


  @override
  Stream<ProFileState> mapEventToState(ProFileEvents event) async* {
    final pref = await SharedPreferences.getInstance();
    final apiRepository = Api();

    String token = (pref.getString('token') ?? "");
    String userId = (pref.getString('userId') ?? "");
      if (event is StartEvent) {
        print("start_bloc");
        yield ProFileInitState();
      } else if (event is ProFileEventStated) {
        print("start_bloc2");
        yield ProFileLoadingState();
        var data = await apiRepository.getUser(token, userId);
        print("start_bloc21 $token");
        print("start_bloc22 $userId");
        if (data != null) {
          if (data!.status ==  "success") {
            print("start_bloc3");
            yield ProFileLoadedState(listProfile: data);
          } else if (data!.status ==  "error") {
            //
          }
        } else {
          yield ProFileErrorState();
        }
    }
  }
}
