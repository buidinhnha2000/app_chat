import 'package:freezed_annotation/freezed_annotation.dart';

import '../../quiz/quiz.dart';
import '../../quiz_item/quiz_item.dart';

part 'quiz_entity.freezed.dart';
part 'quiz_entity.g.dart';

@freezed
class QuizEntity with _$QuizEntity {
  const factory QuizEntity({
    required String id,
    required Quiz quiz,
    @Default([]) List<QuizItem> quizItems,
  }) = _QuizEntity;

  factory QuizEntity.fromJson(Map<String, Object?> json) => _$QuizEntityFromJson(json);
}
