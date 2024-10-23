import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:oth_app/src/domain/entities/rating_entity.dart';

part 'rating_model.g.dart';

@HiveType(typeId: 1)
class RatingModel extends Equatable {
  @HiveField(0)
  final double rate;

  @HiveField(1)
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  RatingModel fromEntity(RatingEntity entity) {
    return RatingModel(
      rate: entity.rate,
      count: entity.count,
    );
  }

  RatingEntity toEntity() {
    return RatingEntity(
      rate: rate,
      count: count,
    );
  }

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
