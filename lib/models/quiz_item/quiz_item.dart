import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_item.freezed.dart';
part 'quiz_item.g.dart';

@freezed
class QuizItem with _$QuizItem {
  const factory QuizItem({
    required String id,
    required String title,
    String? desc,
  }) = _QuizItem;

  factory QuizItem.fromJson(Map<String, Object?> json) => _$QuizItemFromJson(json);
}
