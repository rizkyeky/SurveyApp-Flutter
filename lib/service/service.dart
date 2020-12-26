
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

part 'service_connection.dart';

enum ConnectionStatus { online, offline }

class ServiceResult<T> {
  String massage;
  T value;

  ServiceResult({this.massage, this.value});
}