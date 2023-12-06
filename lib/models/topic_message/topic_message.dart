import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_message.freezed.dart';
part 'topic_message.g.dart';

@freezed
class TopicMessage with _$TopicMessage {
  const factory TopicMessage({
    required String id,
    required int image,
  }) = _TopicMessage;

  factory TopicMessage.fromJson(Map<String, Object?> json) => _$TopicMessageFromJson(json);
}
