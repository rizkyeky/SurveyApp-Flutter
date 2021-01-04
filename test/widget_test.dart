// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_app/service/service.dart';

Future<void> main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  final FirebaseService _service = FirebaseService();
  await _service.init();

  final Map<String, dynamic> keluarga = {
    'Nomor KK': '12345678',
    'Anggota': [
      {
        'Nama': 'Mochamad Rizky Darmawan',
        'NIK': '321111000222333444',
        'Jenis Kelamin': 'Perempuan',
        'Tempat Lahir': 'Bandung dan Bandung',
        'Tanggal Lahir': '1 January 1999',
        'Agama': 'Islam',
        'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
        'Pekerjaan': 'Presiden',
        'Lulusan': 'D3',
        'Nomor HP': null
      },
      {
        'Nama': 'Dewi Rostika',
        'NIK': '321111000222333444',
        'Jenis Kelamin': 'Laki-laki',
        'Tempat Lahir': 'Bandung dan Surabaya',
        'Tanggal Lahir': '31 Desember 2020',
        'Agama': 'Islam',
        'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
        'Pekerjaan': 'Wakil Presiden',
        'Lulusan': 'SD',
        'Nomor HP': '0812121212'
      },
      {
        'Nama': 'Dadang Rendra',
        'NIK': '321111000222333444',
        'Jenis Kelamin': 'Laki-laki',
        'Tempat Lahir': 'Bandung dan Surabaya',
        'Tanggal Lahir': '31 Desember 2020',
        'Agama': 'Islam',
        'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
        'Pekerjaan': 'Wakil Presiden',
        'Lulusan': 'SD',
        'Nomor HP': '0812121212'
      },
      {
        'Nama': 'Rajiv',
        'NIK': '321111000222333444',
        'Jenis Kelamin': 'Laki-laki',
        'Tempat Lahir': 'Bandung dan Surabaya',
        'Tanggal Lahir': '31 Desember 2020',
        'Agama': 'Islam',
        'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
        'Pekerjaan': 'Wakil Presiden',
        'Lulusan': 'SD',
        'Nomor HP': '0812121212'
      }
    ]
  };

  await _service.addKeluarga(keluarga);

}
