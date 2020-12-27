
import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

part 'service_connection.dart';
part 'service_firebase.dart';

enum ConnectionStatus { online, offline }

abstract class Service {
  void init();
  void dispose();
}

class ServiceResult<T> {
  String massage;
  T value;

  ServiceResult({this.massage, this.value});
}