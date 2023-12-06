import 'package:freezed_annotation/freezed_annotation.dart';

import '../../user/user.dart';

part 'post_entity.freezed.dart';
part 'post_entity.g.dart';

@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    required String id,
    required String userId,
    required String title,
    required String image,
    required String createdAt,
    required int favorite,
    required int like,
    required int message,
    ChatUser? user,
  }) = _PostEntity;

  factory PostEntity.fromJson(Map<String, Object?> json) => _$PostEntityFromJson(json);
}
