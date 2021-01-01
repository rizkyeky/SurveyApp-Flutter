part of 'bloc.dart';

class QuestionBloc implements Bloc {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  ValueNotifier<bool> anggotaBPJSNotif = ValueNotifier(false);
  ValueNotifier<bool> aksesInternetNotif = ValueNotifier(false);

  Map<String, dynamic> dataKeluarga;

  bool tempYN1 = false;
  List<bool> anggotaBPJS;
  Map<String, String> dataBPJS = {
  };

  String tempAirMinum;
  List<String> opsiAirMinum = [
    'Air Minum Kemasan',
    'Air Minum PAM',
    'Air Minum Ledeng Tanpa Meteran',
    'Air Minum Sumur Bor',
    'Air Minum Sumur',
    'Air Minum Mata Air',
    'Air Minum Sungai',
    'Air Minum Hujan',
    'Air Minum Lainnya',
  ];
  
  String tempSenitasi;
  List<String> opsiSenitasi = [
    'Jamban Sendiri',
    'Jamban Bersama',
    'Jamban Umum',
    'Bukan Jamban',
    'Yang Lain'
  ];

  String tempProvider;
  List<String> opsiProvider = [
    'Tidak Menggunakan',
    'Telkomsel',
    'Indosat',
    'XL',
    'Yang Lain'
  ];

  String tempStatusSinyal;
  List<String> opsiStatusSinyal = [
    'Kuat',
    'Sedang',
    'Lemah',
  ];

  String tempTV;
  List<String> opsiTV = [
    'TVRI',
    'Swasta',
    'Luar Negri',
  ];

  bool tempYN2 = false;
  List<bool> aksesInternet;
  String tempInternet;
  // Map<String, String> dataBPJS = {
  // };
}