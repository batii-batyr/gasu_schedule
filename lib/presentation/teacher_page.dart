import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/domain/bloc/teacher_bloc/teacher_bloc.dart';
import 'package:gagu_schedule/presentation/rasp.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
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
        context.read<TeacherBloc>().add(SearchTeacherEvent(query: value));
      },
    );
  }

  Widget listGroup() {
    final groups = context.select((TeacherBloc bloc) => bloc.state.teachers);
    return Expanded(
      child: Builder(
        builder: (_) {
          if (groups.isNotEmpty) {
            return Center(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RaspPage(
                                    name: groups[index].name,
                                    id: groups[index].id,
                                    type: 't',
                                  )));
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
