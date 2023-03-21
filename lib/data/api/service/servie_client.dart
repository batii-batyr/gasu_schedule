import 'package:dio/dio.dart';
import 'package:gagu_schedule/data/api/model/GroupApi.dart';
import 'package:gagu_schedule/data/api/model/RaspApi.dart';
import 'package:gagu_schedule/data/api/model/TeacherApi.dart';

class ServiceClient {
  final String urlGroups = 'https://stud.gasu.ru/api/raspGrouplist';
  final String urlTecahers = 'https://stud.gasu.ru/api/raspTeacherlist';

  Future<List<GroupApi>> get_group_list() async {
    final Dio _dio = Dio();
    final response = await _dio.get(urlGroups);
    final maps = response.data["data"];
    return List.generate(maps.length, (index) => GroupApi.fromApi(maps[index]));
  }

  Future<List<RaspApi>> get_rasp({required String url}) async {
    final Dio _dio = Dio();
    final response = await _dio.get(url);
    final maps = response.data["data"]["rasp"];
    return List.generate(maps.length, (index) => RaspApi.fromApi(maps[index]));
  }

  Future<List<TeacherApi>> get_teacher_list() async {
    final Dio _dio = Dio();
    final response = await _dio.get(urlTecahers);
    final maps = response.data["data"];
    return List.generate(
        maps.length, (index) => TeacherApi.fromApi(maps[index]));
  }
}
