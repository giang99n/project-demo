part of 'post_bloc.dart';

abstract class PostEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends PostEvents {}

class PostButtonPressed extends PostEvents {
  final String token;
  final String name;
  final String title;
  final String price;
  final String text;
  final String job;
  final String rankname;

  PostButtonPressed(
      {required this.token,
        required this.price,
      required this.text,
      required this.job,
      required this.rankname,
      required this.name,
      required this.title});
}
