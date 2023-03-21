import 'package:bloc/bloc.dart';
import 'package:gagu_schedule/domain/model/Group.dart';
import 'package:gagu_schedule/domain/repository/group_repository.dart';
import 'package:meta/meta.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository _groupReposioty;

  GroupBloc(this._groupReposioty) : super(GroupState()) {
    on<GetGroupsEvent>(_onGetGroups);
    on<SearchGroupEvent>(_onSearch);
  }

  _onGetGroups(GetGroupsEvent event, Emitter<GroupState> emit) async {
    emit(GroupState(isLoading: true));
    final List<Group> groups = await _groupReposioty.get_group_list();
    emit(GroupState(groups: groups));
  }

  _onSearch(SearchGroupEvent event, Emitter<GroupState> emit) async {
    emit(GroupState(isLoading: true));
    final List<Group> groups = await _groupReposioty.get_group_list();
    final result = groups
        .where((element) =>
            element.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(GroupState(groups: result));
  }
}
