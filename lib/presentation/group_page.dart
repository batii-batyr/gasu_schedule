import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/group_module.dart';
import 'package:gagu_schedule/domain/bloc/group_bloc/group_bloc.dart';
import 'package:gagu_schedule/presentation/rasp.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          search(),
          const SizedBox(
            height: 10.0,
          ),
          listGroup(),
        ],
      ),
    );
  }

  Widget search() {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              5.0,
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Введите вашу группу',
      ),
      onChanged: (value) {
        context.read<GroupBloc>().add(SearchGroupEvent(query: value));
      },
    );
  }

  Widget listGroup() {
    final groups = context.select((GroupBloc bloc) => bloc.state.groups);
    return Expanded(
      child: Center(
        child: Builder(
          builder: (_) {
            if (groups.isNotEmpty) {
              return ListView.builder(
                itemCount: groups.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RaspPage(
                                  name: groups[index].name,
                                  id: groups[index].id)));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              groups[index].name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              groups[index].facul,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
