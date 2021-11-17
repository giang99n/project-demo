part of 'like_post_bloc.dart';

abstract class LikePostEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends LikePostEvents {}

class LikePostButtonPressed extends LikePostEvents {
  final String token;
  final String postId;

  LikePostButtonPressed({required this.token, required this.postId});
}
