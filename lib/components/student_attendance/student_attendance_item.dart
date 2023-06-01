import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/components/student_attendance/student_attendance.dart';
import '/models/diem_danh.dart';
import '/models/buoi_diem_danh.dart';
import '/controllers/student_attendance_controller.dart';

class StudentAttendanceItem extends StatelessWidget {
  final int index;
  final DiemDanh diemDanh;
  final StudentAttendanceController controller;
  const StudentAttendanceItem(
      {Key? key,
      required this.controller,
      required this.diemDanh,
      required this.index})
      : super(key: key);

  Color? getColor() {
    return Colors.greenAccent;
  }

  Icon getLeadingIcon() {
    if (diemDanh.coMat) {
      return const Icon(
        Icons.check_circle_rounded,
        color: Colors.greenAccent,
      );
    }

    return const Icon(
      Icons.radio_button_unchecked_outlined,
      color: Colors.redAccent,
    );
  }

  void handlePressed() {
    DiemDanh newDiemDanh = diemDanh;
    newDiemDanh.coMat = !newDiemDanh.coMat;
    controller.updateDiemDanh(newDiemDanh);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      color: Colors.white,
      child: ListTile(
          leading: getLeadingIcon(),
          title: Text(diemDanh.tenSinhVien),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(diemDanh.maSinhVien),
                Text(diemDanh.maThietBi),
              ]),
          trailing: FloatingActionButton.extended(
            heroTag: '${diemDanh.maSinhVien}.$index',
            extendedPadding: const EdgeInsets.fromLTRB(2, 0, 4, 0),
            backgroundColor: Colors.white,
            onPressed: handlePressed,
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.blueAccent,
              size: 24.0,
            ),
            label: const Text(
              'Điểm danh',
              style: TextStyle(color: Colors.blueAccent),
            ),
          )),
    );
  }
}
