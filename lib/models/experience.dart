import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Portfolio experience synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    required this.title,
    required this.description,
    required this.category,
    this.thumbnail = '',
    this.id,
    this.categoryDisplay = '',
    this.startedAt,
    this.endedAt,
    this.isOngoing = true,
    this.starCount = 0,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  /// Server-generated fields are excluded from the POST body.
  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String category;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String categoryDisplay;

  @JsonKey(includeToJson: false)
  final String? startedAt;

  final String? endedAt;

  @JsonKey(includeToJson: false, defaultValue: true)
  final bool isOngoing;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}