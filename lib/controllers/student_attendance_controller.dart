import 'dart:convert';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/diem_danh.dart';
import '/models/sinh_vien.dart';
import '/constants/api_endpoints.dart';

class StudentAttendanceController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool loading = true;
  List<SinhVien> _danhSachSinhVien = [];
  List<DiemDanh> danhSachDiemDanh = [];

  @override
  void onInit() async {
    super.onInit();
    loading = true;

    _danhSachSinhVien = await getDanhSachSinhVien();
    danhSachDiemDanh = _danhSachSinhVien
        .map<DiemDanh>((sv) => DiemDanh(
            sv.maSinhVien, sv.tenSinhVien, sv.danhSachThietBi[0], false, null))
        .toList();
    loading = false;
  }

  void updateDiemDanh(DiemDanh diemDanh) {
    int index = danhSachDiemDanh
        .indexWhere((ele) => ele.maSinhVien == diemDanh.maSinhVien);
    if (index > -1) {
      danhSachDiemDanh[index] = diemDanh;
    }
  }

  Future<List<SinhVien>> getDanhSachSinhVien() async {
    List<SinhVien> danhSachSinhVien = [];
    loading = true;
    final SharedPreferences prefs = await _prefs;
    String? accessToken = prefs.getString("access_token");
    int? maBuoiHoatDong = prefs.getInt("ma_buoi_hoat_dong");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    final queryParameters = {
      'MaBuoiHoatDong': maBuoiHoatDong.toString(),
    };

    var url = Uri.parse(ApiEndpoints.instance.studentAttendanceEndpoint)
        .replace(queryParameters: queryParameters);
    print('URL: $url');
    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> elements = json["danh_sach_sinh_vien"];
        danhSachSinhVien = elements
            .map<SinhVien>((element) => SinhVien(
                element["MaSinhVien"],
                element["TenSinhVien"],
                (element["DanhSachThietBi"] as List<dynamic>)
                    .map<String>((element) => '$element')
                    .toList()))
            .toList();
      } else {
        final json = jsonDecode(response.body);
        throw json["error_message"] ?? "Unknown error occurred";
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
    }

    return danhSachSinhVien;
  }
}
