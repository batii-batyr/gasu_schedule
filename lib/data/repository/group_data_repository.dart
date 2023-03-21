import 'package:gagu_schedule/domain/repository/group_repository.dart';
import 'package:gagu_schedule/domain/model/Group.dart';
import 'package:gagu_schedule/data/api/apiUtil.dart';

class GroupDataRepository extends GroupRepository {
  final ApiUtil apiUtil;

  GroupDataRepository(this.apiUtil);

  @override
  Future<List<Group>> get_group_list() async {
    return apiUtil.get_group_list();
  }
}
