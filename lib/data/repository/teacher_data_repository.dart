import 'package:gagu_schedule/domain/repository/teacher_repository.dart';
import 'package:gagu_schedule/domain/model/Teacher.dart';
import 'package:gagu_schedule/data/api/apiUtil.dart';

class TeacherDataRepository extends TeacherRepository {
  final ApiUtil apiUtil;

  TeacherDataRepository(this.apiUtil);

  @override
  Future<List<Teacher>> get_teacher_list() async {
    return apiUtil.get_teacher_list();
  }
}
