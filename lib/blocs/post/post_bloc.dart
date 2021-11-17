import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectbnk/network/apis.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_events.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvents, PostState> {
  Api apiRepository;

  PostBloc(PostState initialState, this.apiRepository) : super(initialState);

  @override
  Stream<PostState> mapEventToState(PostEvents event) async* {
    if (event is StartEvent) {
      yield PostInitState();
    } else if (event is PostButtonPressed) {
      yield PostLoadingState();
      var data = await apiRepository.post(event.token,event.name,event.title,event.price,event.text,event.job,event.rankname);
      print(data.toString());
      if (data != null) {
        if (data!.status == "success") {
          yield PostSuccessState();
        } else if (data!.status == "error") {
          print("login error");
          yield PostErrorState(
              message: "thất bại");
        }
      } else {
        yield PostErrorState(
            message: "thất bại");
      }
    }
  }
}
