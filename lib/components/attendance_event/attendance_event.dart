import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hufi/components/attendance_manager/attendance_item.dart';
import 'package:hufi/controllers/attendance_event_controller.dart';

import '/components/background.dart';

class AttendanceEvent extends StatefulWidget {
  const AttendanceEvent({Key? key}) : super(key: key);

  @override
  State<AttendanceEvent> createState() => _AttendanceEventState();
}

class _AttendanceEventState extends State<AttendanceEvent> {
  final AttendanceEventController attendanceEventController =
      Get.put(AttendanceEventController());

  @override
  Widget build(BuildContext context) {
    return AppbarBackground(
        title: "Điểm danh",
        child: FutureBuilder(
          future: attendanceEventController.getDanhSachHoatDong(),
          builder: (context, snapshot) {
            if (attendanceEventController.loading) {
              return ListView.builder(
                itemCount: attendanceEventController.danhSachHoatDong.length,
                itemBuilder: (context, index) {
                  return AttendanceItem(
                      index: index,
                      hoatDong:
                          attendanceEventController.danhSachHoatDong[index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            // By default show a loading spinner.
            return Container(
                margin: const EdgeInsets.all(8),
                alignment: FractionalOffset.center,
                child: const CircularProgressIndicator());
          },
        ));
  }
}