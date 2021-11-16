
import 'package:equatable/equatable.dart';
import 'package:projectbnk/models/home_get_post_res.dart';
import 'package:projectbnk/network/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_post_events.dart';
part 'get_post_state.dart';

class GetPostBloc extends Bloc<GetPostEvents, GetPostState> {
  GetPostBloc() : super(GetPostLoadingState());

  @override
  Stream<GetPostState> mapEventToState(GetPostEvents event) async* {
    final apiRepository = Api();
    final pref = await SharedPreferences.getInstance();
    String token = (pref.getString('token') ?? "");
    if (event is StartEvent) {
      yield GetPostInitState();
    } else if (event is GetPostEventStated) {
      yield GetPostLoadingState();
      var data = await apiRepository.getListPost(token);
      if (data != null) {
        if (data!.status ==  "success") {
          yield GetPostLoadedState(listPost: data);
        } else if (data.status ==  "error") {
          //
        }
      } else {
        yield GetPostErrorState();
      }
    }
  }
}
