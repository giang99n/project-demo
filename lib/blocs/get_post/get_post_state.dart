part of 'get_post_bloc.dart';

class GetPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPostInitState extends GetPostState {}

class GetPostLoadingState extends GetPostState {}

class GetPostErrorState extends GetPostState {}

class GetPostLoadedState extends GetPostState {
  final HomeGetPostResponse listPost;

  GetPostLoadedState({required this.listPost});

  @override
  List<Object> get props => [listPost];
}
