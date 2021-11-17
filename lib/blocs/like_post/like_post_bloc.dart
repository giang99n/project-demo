import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectbnk/network/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'like_post_state.dart';
part 'like_post_event.dart';

class LikePostBloc extends Bloc<LikePostEvents, LikePostState> {
  Api apiRepository;


  LikePostBloc(LikePostState initialState, this.apiRepository) : super(initialState);

  @override
  Stream<LikePostState> mapEventToState(LikePostEvents event) async* {
    final pref = await SharedPreferences.getInstance();
    String token = (pref.getString('token') ?? "");
    if (event is StartEvent) {
      yield LikePostInitState();
    } else if (event is LikePostButtonPressed) {
      yield LikePostLoadingState();
      var data = await apiRepository.LikePost(event.token, event.postId);
      print(data.toString());
      if (data != null) {
        if (data!.status == "success") {
          await pref.remove('errorLikePost');
          yield LikePostSuccessState();
        } else if (data!.status == "error") {
          print("LikePost error");
          yield LikePostErrorState(
              message: "đăng nhập thất bại");
        }
      } else {
        yield LikePostErrorState(
            message:pref.getString('errorLikePost') ?? "đăng nhập thất bại");
      }
    }
  }
}
