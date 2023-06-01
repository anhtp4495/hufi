import 'package:flutter/material.dart';
import '/models/buoi_diem_danh.dart';

class AttendanceEventItem extends StatelessWidget {
  final int index;
  final BuoiDiemDanh buoiDiemDanh;
  const AttendanceEventItem(
      {Key? key, required this.buoiDiemDanh, required this.index})
      : super(key: key);

  handlePressed() {
    //Get.to(AttendanceDetail(hoatDong: hoatDong));
  }

  Color? getColor() {
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      color: Colors.white,
      child: ListTile(
          title: Text(buoiDiemDanh.maHoatDong),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    '${buoiDiemDanh.tenBuoi} ngày ${buoiDiemDanh.thoiGianBatDau}'),
                Text('Sỉ số: ${buoiDiemDanh.siSo}'),
              ]),
          trailing: FloatingActionButton.extended(
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
