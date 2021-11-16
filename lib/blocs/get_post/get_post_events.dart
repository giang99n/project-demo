part of 'get_post_bloc.dart';

abstract class GetPostEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends GetPostEvents {}

class GetPostEventStated extends GetPostEvents {
  // final String token;
  // ProfileEventStated({required this.token});
}
