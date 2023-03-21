import 'package:bloc/bloc.dart';
import 'package:gagu_schedule/domain/model/Teacher.dart';
import 'package:gagu_schedule/domain/repository/teacher_repository.dart';
import 'package:meta/meta.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final TeacherRepository _teacherReposioty;

  TeacherBloc(this._teacherReposioty) : super(TeacherState()) {
    on<GetTeacherEvent>(_onGetTeachers);
    on<SearchTeacherEvent>(_onSearch);
  }

  _onGetTeachers(GetTeacherEvent event, Emitter<TeacherState> emit) async {
    final List<Teacher> teachers = await _teacherReposioty.get_teacher_list();
    emit(TeacherState(teachers: teachers));
  }

  _onSearch(SearchTeacherEvent event, Emitter<TeacherState> emit) async {
    final List<Teacher> teachers = await _teacherReposioty.get_teacher_list();
    final result = teachers
        .where((element) =>
            element.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(TeacherState(teachers: result));
  }
}
