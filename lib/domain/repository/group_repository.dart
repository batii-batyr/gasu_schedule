import 'package:gagu_schedule/domain/model/Group.dart';

abstract class GroupRepository {
  Future<List<Group>> get_group_list();
}
