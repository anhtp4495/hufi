import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hufi/models/diem_danh.dart';
import 'package:hufi/models/sinh_vien.dart';
import '/controllers/student_attendance_controller.dart';
import '/components/background.dart';
import '/components/student_attendance/student_attendance_item.dart';

class StudentAttendance extends StatefulWidget {
  const StudentAttendance({Key? key}) : super(key: key);

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  final StudentAttendanceController studentAttendanceController =
      Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    return AppbarBackground(
        title: "Điểm danh",
        child: FutureBuilder(
          future: studentAttendanceController.getDanhSachSinhVien(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: studentAttendanceController.danhSachDiemDanh.length,
                itemBuilder: (context, index) {
                  return StudentAttendanceItem(
                      controller: studentAttendanceController,
                      diemDanh:
                          studentAttendanceController.danhSachDiemDanh[index],
                      index: index);
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (studentAttendanceController.loading) {
              return Container(
                  margin: const EdgeInsets.all(8),
                  alignment: FractionalOffset.center,
                  child: const CircularProgressIndicator());
            }
            // By default show a loading spinner.
            return const Text('Không có dữ liệu');
          },
        ));
  }
}
