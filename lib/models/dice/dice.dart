import 'package:freezed_annotation/freezed_annotation.dart';

part 'dice.freezed.dart';
part 'dice.g.dart';

@freezed
class Dice with _$Dice {
  const factory Dice({
    required String id,
    required String roomName,
    required String adminId,
    required String adminName,
    required String adminAvatar,
    String? roomId,
    List<int>? resultRoll,
  }) = _Dice;

  factory Dice.fromJson(Map<String, Object?> json) => _$DiceFromJson(json);
}
