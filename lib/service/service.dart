
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
// import 'package:image_picker/image_picker.dart';

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
  bool isSucess;

  ServiceResult({this.massage, this.value, this.isSucess});
}