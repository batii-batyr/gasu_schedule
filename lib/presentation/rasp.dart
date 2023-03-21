import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagu_schedule/domain/model/Rasp.dart';
import 'package:gagu_schedule/internal/dependecies/rasp_module.dart';
import 'package:gagu_schedule/domain/bloc/rasp_bloc/rasp_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class RaspPage extends StatefulWidget {
  const RaspPage(
      {super.key, required this.name, required this.id, this.type = ''});
  final String name;
  final int id;
  final String type;

  @override
  State<RaspPage> createState() => _RaspPageState();
}

class _RaspPageState extends State<RaspPage> {
  TextEditingController dateController = TextEditingController();
  DateTime? temp_date;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    temp_date = DateTime.now();
    dateController.text = DateFormat('MMMMd', 'ru').format(temp_date!);
  }

  @override
  Widget build(BuildContext context) {
    final RaspBloc raspBloc = RaspModule.raspBloc();
    return BlocProvider<RaspBloc>(
      create: (context) {
        String strDate = DateFormat('yyyy-MM-dd').format(temp_date!);
        return raspBloc
          ..add(GetRaspEvent(id: widget.id, date: strDate, type: widget.type));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          dateInput(),
          const SizedBox(
            height: 10.0,
          ),
          listGroup(),
        ],
      ),
    );
  }

  Widget dateInput() {
    return BlocBuilder<RaspBloc, RaspState>(
      builder: (context, state) {
        return TextField(
          controller: dateController,
          decoration: const InputDecoration(
            icon: Icon(Icons.calendar_month_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5.0,
                ),
              ),
            ),
            filled: true,
            //fillColor: Colors.white60,
            contentPadding: EdgeInsets.all(15.0),
          ),
          readOnly: true,
          onTap: () async {
            temp_date = await showDatePicker(
                context: context,
                initialDate: temp_date ?? DateTime.now(), //get today's date
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2100));
            if (temp_date != null) {
              String strDate = DateFormat('yyyy-MM-dd').format(temp_date!);
              String cont_text = DateFormat.MMMEd('ru').format(temp_date!);
              BlocProvider.of<RaspBloc>(context).add(GetRaspEvent(
                  id: widget.id, date: strDate, type: widget.type));
              setState(() {
                dateController.text = cont_text;
              });
            }
          },
        );
      },
    );
  }

  Widget listGroup() {
    return Expanded(
      child: Center(
        child: Builder(
          builder: (context) {
            final state = context.watch<RaspBloc>().state;
            final week = state.map_rasp;
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }
            if (week.isNotEmpty) {
              return ListView.builder(
                itemCount: week.length,
                itemBuilder: (BuildContext context, int index) {
                  final rasp = week.values.elementAt(index);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                week.keys.elementAt(index),
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                rasp[0].date,
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: rasp.length,
                          itemBuilder: (BuildContext context, int index) {
                            return lesson(rasp, index);
                          })
                    ],
                  );
                },
              );
            }
            return const Text("Нет данных");
          },
        ),
      ),
    );
  }

  Card lesson(List<Rasp> rasp, int index) {
    return Card(
      color: Color(rasp[index].color),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Text(
                  "${rasp[index].start_time} - ",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  rasp[index].end_time,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 1.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.groups,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Flexible(
                  child: Text(
                    "Группа: ${rasp[index].group}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 1.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.book_outlined,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Flexible(
                  child: Text(
                    rasp[index].discipline,
                    style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 1.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.school_outlined,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Text(
                  rasp[index].teacher,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 1.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Text(
                  "Аудитория: ${rasp[index].classroom}",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
