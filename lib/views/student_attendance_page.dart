import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hufi/controllers/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'dart:math';

final _random = new Random();
/**
 * Generates a positive random integer uniformly distributed on the range
 * from [min], inclusive, to [max], exclusive.
 */
int next(int min, int max) => min + _random.nextInt(max - min);

class StudentAttendancePage extends StatelessWidget {
  const StudentAttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BluetoothController>(
          init: BluetoothController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.blue,
                    child: const Center(
                      child: Text("HĐ00024 - Quét dọn sân trường",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5 * 3),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.scanDevices();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(350, 55),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Text(
                        'Điểm danh',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<ScanResult>>(
                    stream: controller.scanResults,
                    builder: (context, snapshot) {
                      bool hasData = snapshot.hasData;
                      print('hasData: $hasData');
                      if (snapshot.hasData) {
                        int length = snapshot.data!.length;
                        print('length: $length');
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final device = snapshot.data![index].device;
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                onTap: () {},
                                title: Text('MSSV: 200517${next(1000, 9999)}'),
                                subtitle: Text('Thiết bị: ${device.id.id}'),
                                trailing: TextButton(
                                  onPressed: () {
                                    controller.connectToDevice(device);
                                  },
                                  child: const Text('Có mặt'),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No devices found'),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}