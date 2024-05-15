
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothService extends  GetxService{
  FlutterBluePlus flutterBlue = FlutterBluePlus();

  late BluetoothDevice device;
  late BluetoothCharacteristic characteristic;

  void connectToDevice(String deviceId) async {
    // final device = flutterBlue.devices.firstWhere((d) => d.id == deviceId);
    // await device.connect();
    discoverServices(device);
  }

  void discoverServices(BluetoothDevice device) async {
    this.device = device;
    await device.discoverServices();
    // final service = device.services.firstWhere((s) => s.uuid.toString() == 'your_service_uuid');
    // final characteristic = service.characteristics.firstWhere((c) => c.uuid.toString() == 'your_characteristic_uuid');
    setCharacteristic(characteristic);
  }

  void setCharacteristic(BluetoothCharacteristic characteristic) {
    this.characteristic = characteristic;
    // 这里可以添加更多的方法来读取、写入和监听特征值的变化
  }

  // 读取特性值的方法
  Future<List<int>> readValue() async {
    return await characteristic.read();
  }

  // 写入特性值的方法
  Future<void> writeValue(List<int> value) async {
    return await characteristic.write(value);
  }


}


