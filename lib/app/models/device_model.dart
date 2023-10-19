import 'package:flutter/material.dart';

// part 'device.freezed.dart';

enum DeviceType {
  mobile(Icons.smartphone),
  desktop(Icons.computer),
  web(Icons.language),
  headless(Icons.terminal),
  server(Icons.dns);

  const DeviceType(this.icon);

  final IconData icon;
}

/// Internal device model.
/// It gets not serialized.
///
// @freezed
class Device {
  String ip;
  String version;
  int port;
  bool https;
  String fingerprint;
  String alias;
  String? deviceModel;
  DeviceType deviceType;
  bool download;

  Device({
    required this.ip,
    required this.version,
    required this.port,
    required this.https,
    required this.fingerprint,
    required this.alias,
    required this.deviceModel,
    required this.deviceType,
    required this.download,
  });

  factory Device.a(_) => Device(
        ip: '',
        version: '',
        port: 0,
        https: true,
        fingerprint: '',
        alias: '',
        deviceModel: '',
        deviceType: DeviceType.desktop,
        download: false,
      );
}
