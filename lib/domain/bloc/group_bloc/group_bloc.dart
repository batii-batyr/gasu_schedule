import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:gagu_schedule/domain/model/Group.dart';
import 'package:gagu_schedule/domain/repository/group_repository.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'group_event.dart';
part 'group_state.dart';


EventTransformer<E> debounceDroppable<E>(Duration duration){
  return(evetns, mapper){
    return droppable<E>().call(evetns.debounce(duration), mapper);
  };
}


class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository _groupReposioty;

  GroupBloc(this._groupReposioty) : super(GroupState()) {
    on<GetGroupsEvent>(_onGetGroups);
    on<SearchGroupEvent>(_onSearch, transformer: debounceDroppable(const Duration(milliseconds: 300)));
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
