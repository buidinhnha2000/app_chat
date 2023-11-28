import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String fromId,
    required String toId,
    required String msg,
    required String read,
    required String sent,
    required TypeMessage type,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, Object?> json) => _$ChatMessageFromJson(json);
}

enum TypeMessage { text, image }