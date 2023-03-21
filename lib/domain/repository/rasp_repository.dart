import 'package:gagu_schedule/domain/model/Rasp.dart';

abstract class RaspRepository {
  Future<List<Rasp>> get_rasp_group(int id, String date);
  Future<List<Rasp>> get_rasp_teacher(int id, String date);
}
