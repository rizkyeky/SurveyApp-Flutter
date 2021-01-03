import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

import 'locator.dart';
import 'view/page.dart';
// import 'service/service.dart';
// import 'bloc/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // final Map<String, dynamic> keluarga = {
    //   'Nomor KK': '12345678',
    //   'Anggota': [
    //     {
    //       'Nama': 'Mochamad Rizky Darmawan',
    //       'NIK': '321111000222333444',
    //       'Jenis Kelamin': 'Perempuan',
    //       'Tempat Lahir': 'Bandung dan Bandung',
    //       'Tanggal Lahir': '1 January 1999',
    //       'Agama': 'Islam',
    //       'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
    //       'Pekerjaan': 'Presiden',
    //       'Lulusan': 'D3',
    //       'Nomor HP': null
    //     },
    //     {
    //       'Nama': 'Dewi Rostika',
    //       'NIK': '321111000222333444',
    //       'Jenis Kelamin': 'Laki-laki',
    //       'Tempat Lahir': 'Bandung dan Surabaya',
    //       'Tanggal Lahir': '31 Desember 2020',
    //       'Agama': 'Islam',
    //       'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
    //       'Pekerjaan': 'Wakil Presiden',
    //       'Lulusan': 'SD',
    //       'Nomor HP': '0812121212'
    //     },
    //     {
    //       'Nama': 'Dadang Rendra',
    //       'NIK': '321111000222333444',
    //       'Jenis Kelamin': 'Laki-laki',
    //       'Tempat Lahir': 'Bandung dan Surabaya',
    //       'Tanggal Lahir': '31 Desember 2020',
    //       'Agama': 'Islam',
    //       'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
    //       'Pekerjaan': 'Wakil Presiden',
    //       'Lulusan': 'SD',
    //       'Nomor HP': '0812121212'
    //     },
    //     {
    //       'Nama': 'Rajiv',
    //       'NIK': '321111000222333444',
    //       'Jenis Kelamin': 'Laki-laki',
    //       'Tempat Lahir': 'Bandung dan Surabaya',
    //       'Tanggal Lahir': '31 Desember 2020',
    //       'Agama': 'Islam',
    //       'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung',
    //       'Pekerjaan': 'Wakil Presiden',
    //       'Lulusan': 'SD',
    //       'Nomor HP': '0812121212'
    //     }
    //   ]
    // };

    return MaterialApp(      
      debugShowCheckedModeBanner: false,
      title: 'Survey App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}