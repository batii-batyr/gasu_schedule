import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/domain/bloc/teacher_bloc/teacher_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/group_module.dart';
import 'package:gagu_schedule/domain/bloc/group_bloc/group_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/teacher_module.dart';
import 'package:gagu_schedule/presentation/rasp.dart';

import 'package:gagu_schedule/presentation/group_page.dart';
import 'package:gagu_schedule/presentation/teacher_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rasp GASU',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Расписание ГАГУ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final GroupBloc _groupBloc = GroupModule.groupBloc();
    final TeacherBloc _teacherBloc = TeacherModule.teacherBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupBloc>(
            create: (context) => _groupBloc..add(GetGroupsEvent())),
        BlocProvider<TeacherBloc>(
            create: (context) => _teacherBloc..add(GetTeacherEvent()))
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text(widget.title)),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Группы"),
                Tab(text: "Преподователи"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              GroupPage(),
              TeacherPage(),
            ],
          ),
        ),
      ),
    );
  }
}
