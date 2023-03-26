import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_cubit.dart';
import 'package:gagu_schedule/domain/bloc/interner_bloc/internet_state.dart';
import 'package:gagu_schedule/domain/bloc/teacher_bloc/teacher_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/group_module.dart';
import 'package:gagu_schedule/domain/bloc/group_bloc/group_bloc.dart';
import 'package:gagu_schedule/internal/dependecies/teacher_module.dart';
import 'package:gagu_schedule/presentation/about.dart';
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
    final Connectivity connectivity = Connectivity();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (_) => InternetCubit(connectivity: connectivity)),
        BlocProvider<GroupBloc>(create: (context) => _groupBloc),
        BlocProvider<TeacherBloc>(create: (context) => _teacherBloc)
      ],
      child: DefaultTabController(
        length: 2,
        child: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            context.read<GroupBloc>().add(GetGroupsEvent());
            context.read<TeacherBloc>().add(GetTeacherEvent());
          },
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()));
                  },
                  icon: const Icon(Icons.info_outline),
                )
              ],
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
      ),
    );
  }
}
