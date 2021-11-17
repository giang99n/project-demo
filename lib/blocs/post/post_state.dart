part of 'post_bloc.dart';

class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostInitState extends PostState {}

class PostLoadingState extends PostState {}

class PostSuccessState extends PostState {}

class PostErrorState extends PostState {
  final String message;
  PostErrorState({required this.message});
}
