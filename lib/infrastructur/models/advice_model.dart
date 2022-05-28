import 'package:equatable/equatable.dart';
import 'package:firstcleanarchi/domain/enities/advice_entitiy.dart';

class AdviceModel extends AdviceEntitiy with EquatableMixin {
  AdviceModel({required String advice, required int id})
      : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      advice: json['advice'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'advice': advice,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [advice, id];
}
