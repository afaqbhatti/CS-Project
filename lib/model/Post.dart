
import 'package:connect_social/model/NpDateTime.dart';
import 'package:connect_social/model/User.dart';

class Post {
  final int? id;
  final int? user_id;
  final String? details;
  final List<String>? privacy;
  final String? type;
  final int? comments;
  final int? is_liked;
  final int? likes;
  final int? is_requested;
  final NpDateTime? createdat;
  final User? user;
  final PostAsset? assets;

  Post({
    this.id,
    this.user_id,
    this.details,
    this.privacy,
    this.type,
    this.comments,
    this.likes,
    this.is_requested,
    this.is_liked,
    this.createdat,
    this.assets,
    this.user
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id:json['id'] as int?,
        user_id:json['user_id'] as int?,
        details:json['details'] as String?,
        privacy:json['privacy'] as List<String>?,
        type:json['type'] as String?,
        likes:json['total-likes'] as int?,
        is_liked:json['is-liked'] as int?,
        comments:json['total-comments'] as int?,
        is_requested:json['is_requested'] as int?,
        createdat:json['createdat'] as NpDateTime?,
        user:json['user'] as User?,
        assets:json['assets'] as PostAsset?
    );
  }
}

class PostAsset {
  final int? id;
  final int? post_id;
  final String? type;
  final String? file;
  final NpDateTime? createdat;

  PostAsset({
    this.id,
    this.post_id,
    this.type,
    this.file,
    this.createdat,
  });

  factory PostAsset.fromJson(Map<String, dynamic> json) {
    return PostAsset(
        id:json['id'] as int?,
        post_id:json['post_id'] as int?,
        type:json['type'] as String?,
        file:json['file'] as String?,
        createdat:json['createdat'] as NpDateTime?,
    );
  }
}
