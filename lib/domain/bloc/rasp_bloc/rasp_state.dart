part of 'rasp_bloc.dart';

class RaspState {
  Map<String, List<Rasp>> map_rasp;
  final bool isLoading;

  RaspState({
    this.map_rasp = const {},
    this.isLoading = false,
  });
}
