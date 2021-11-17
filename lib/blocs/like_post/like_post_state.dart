part of 'like_post_bloc.dart';

class LikePostState extends Equatable {
  @override
  List<Object> get props => [];
}

class LikePostInitState extends LikePostState {}

class LikePostLoadingState extends LikePostState {}

class LikePostSuccessState extends LikePostState {}

class LikePostErrorState extends LikePostState {
  final String message;

  LikePostErrorState({required this.message});
}
