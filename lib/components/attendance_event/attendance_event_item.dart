import 'package:flutter/material.dart';
import '/models/buoi_diem_danh.dart';

class AttendanceEventItem extends StatelessWidget {
  final int index;
  final BuoiDiemDanh hoatDong;
  const AttendanceEventItem(
      {Key? key, required this.hoatDong, required this.index})
      : super(key: key);

  handleTap() {
    //Get.to(AttendanceDetail(hoatDong: hoatDong));
  }

  Color? getColor() {
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      color: Colors.white,
      child: ListTile(
        title: Text('${hoatDong.maHoatDong} - ${hoatDong.tenBuoi}'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  'Thời gian: ${hoatDong.thoiGianBatDau} - ${hoatDong.thoiGianKetThuc}'),
            ]),
        trailing: const Icon(Icons.forward_outlined),
        onTap: handleTap,
      ),
    );
  }
}
