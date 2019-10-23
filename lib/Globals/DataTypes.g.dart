// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataTypes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreObject _$ScoreObjectFromJson(Map<String, dynamic> json) {
  return ScoreObject(
      username: json['username'] as String, score: json['score'] as int);
}

Map<String, dynamic> _$ScoreObjectToJson(ScoreObject instance) =>
    <String, dynamic>{'username': instance.username, 'score': instance.score};
