import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';
import 'package:gagu_schedule/domain/repository/rasp_repository.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'rasp_event.dart';
part 'rasp_state.dart';

class RaspBloc extends Bloc<RaspEvent, RaspState> {
  final RaspRepository raspRepository;

  RaspBloc(this.raspRepository) : super(RaspState()) {
    on<GetRaspEvent>(_onGetRasp);
  }

  _onGetRasp(GetRaspEvent event, Emitter<RaspState> emit) async {
    emit(RaspState(isLoading: true));
    List<Rasp> rasp;
    if (event.type == 't') {
      rasp = await raspRepository.get_rasp_teacher(event.id, event.date);
    } else {
      rasp = await raspRepository.get_rasp_group(event.id, event.date);
    }

    Set<String> week = {};
    for (Rasp lesson in rasp) {
      week.add(lesson.weekday);
    }

    Map<String, List<Rasp>> map = {};
    for (String day in week) {
      map[day] = rasp
          .where((element) =>
              element.weekday.toLowerCase().contains(day.toLowerCase()))
          .toList();
    }
    emit(RaspState(map_rasp: map));
  }
}
