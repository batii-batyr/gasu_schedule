import 'package:gagu_schedule/domain/repository/rasp_repository.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';
import 'package:gagu_schedule/data/api/apiUtil.dart';

class RaspDataRepository extends RaspRepository {
  final ApiUtil apiUtil;

  RaspDataRepository(this.apiUtil);

  @override
  Future<List<Rasp>> get_rasp_teacher(int id, String date) async {
    String url =
        'https://stud.gasu.ru/api/Rasp?idTeacher=${id.toString()}&sdate=$date';

    return apiUtil.get_rasp(url);
  }

  @override
  Future<List<Rasp>> get_rasp_group(int id, String date) async {
    String url =
        'https://stud.gasu.ru/api/Rasp?idGroup=${id.toString()}&sdate=$date';
    print(url);
    return apiUtil.get_rasp(url);
  }
}
