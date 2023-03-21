import 'package:flutter/rendering.dart';
import 'package:gagu_schedule/data/api/service/servie_client.dart';

import 'package:gagu_schedule/domain/model/Group.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';

import 'package:gagu_schedule/data/api/mapper/rasp_mapper.dart';
import 'package:gagu_schedule/domain/model/Teacher.dart';

class ApiUtil {
  final ServiceClient serviceClient;

  ApiUtil(this.serviceClient);

  Future<List<Group>> get_group_list() async {
    final result = await serviceClient.get_group_list();
    return List.generate(
        result.length,
        (index) => Group(
              name: result[index].name,
              id: result[index].id,
              facul: result[index].facul,
            ));
  }

  Future<List<Rasp>> get_rasp(String url) async {
    final result = await serviceClient.get_rasp(url: url);
    return List.generate(
        result.length, (index) => RaspMapper.fromApi(result[index]));
  }

  Future<List<Teacher>> get_teacher_list() async {
    final result = await serviceClient.get_teacher_list();
    return List.generate(
        result.length,
        (index) => Teacher(
              id: result[index].id,
              name: result[index].name,
            ));
  }
}
