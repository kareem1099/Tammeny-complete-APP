import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';

abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunitySuccess extends CommunityState {
  final List<PostEntity> posts;

  CommunitySuccess(this.posts);
}

class CommunityFailure extends CommunityState {
  final String message;

  CommunityFailure(this.message);
}
