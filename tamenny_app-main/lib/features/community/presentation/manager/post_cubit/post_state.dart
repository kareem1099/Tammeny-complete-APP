abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {}

class AddPostFailure extends AddPostState {
  final String error;

  AddPostFailure({required this.error});
}
