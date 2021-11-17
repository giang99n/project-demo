part of 'like_post_bloc.dart';

abstract class LikePostEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends LikePostEvents {}

class LikePostButtonPressed extends LikePostEvents {
  final String postId;

  LikePostButtonPressed({ required this.postId});
}
