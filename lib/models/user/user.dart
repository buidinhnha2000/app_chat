import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class ChatUser with _$ChatUser {
  const factory ChatUser({
    required String id,
    required String image,
    required String about,
    required String name,
    required String createdAt,
    required String lastActive,
    required String email,
    required String pushToken,
    required bool isOnline,
  }) = _ChatUser;

  factory ChatUser.fromJson(Map<String, Object?> json) => _$ChatUserFromJson(json);
}
