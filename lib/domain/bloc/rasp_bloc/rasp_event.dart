part of 'rasp_bloc.dart';

@immutable
abstract class RaspEvent {}

class GetRaspEvent extends RaspEvent {
  final int id;
  final String type;
  String date;

  GetRaspEvent({required this.id, this.type = 'g', this.date = ''});
}
