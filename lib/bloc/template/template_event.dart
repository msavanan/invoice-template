import 'package:equatable/equatable.dart';
import 'package:invoice/constant.dart';

sealed class TemplateEvent extends Equatable {
  const TemplateEvent();
}

class Read extends TemplateEvent {
  final String key;
  const Read({required this.key});

  @override
  List<Object?> get props => [key];
}

class Update extends TemplateEvent {
  final String key;
  final String value;
  final String type;
  const Update(
      {required this.key, required this.value, this.type = Types.defaults});

  @override
  List<Object?> get props => [key, value, type];
}

class UpdateItem extends TemplateEvent {
  final String key;
  final String value;
  final int rowNum;
  const UpdateItem(
      {required this.key, required this.value, required this.rowNum});

  @override
  List<Object?> get props => [key, value, rowNum];
}

class Hover extends TemplateEvent {
  final String key;
  const Hover({required this.key});

  @override
  List<Object?> get props => [key];
}

class Exit extends TemplateEvent {
  final String key;
  const Exit({required this.key});

  @override
  List<Object?> get props => [key];
}

class HoverItem extends TemplateEvent {
  final String key;
  final int rowNum;
  const HoverItem({required this.key, required this.rowNum});

  @override
  List<Object?> get props => [key, rowNum];
}

class ExitItem extends TemplateEvent {
  final String key;
  final int rowNum;
  const ExitItem({required this.key, required this.rowNum});

  @override
  List<Object?> get props => [key, rowNum];
}
