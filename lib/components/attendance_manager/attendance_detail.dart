import 'package:flutter/material.dart';
import '/components/background.dart';
import '/models/hoat_dong.dart';

class AttendanceDetail extends StatelessWidget {
  final HoatDong hoatDong;
  const AttendanceDetail({Key? key, required this.hoatDong}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppbarBackground(
        title: hoatDong.maHoatDong,
        child: Container(
          margin: const EdgeInsets.all(8),
          color: Colors.white,
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              hoatDong.tieuDe,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Nội dung: ${hoatDong.noiDung}'),
            Text('Địa điểm: ${hoatDong.diaDiem}'),
            Text(
                'Thời gian: ${hoatDong.thoiGianBatDau} - ${hoatDong.thoiGianKetThuc}'),
            Text('Người tạo: ${hoatDong.nguoiTao}'),
            Text('Khoa: ${hoatDong.khoa}'),
          ]),
        ));
  }
}
