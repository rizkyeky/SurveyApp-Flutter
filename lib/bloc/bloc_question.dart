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
  ValueNotifier<bool> validQuesNotif = ValueNotifier(false);

  Map<String, dynamic> dataKeluarga;

  bool tempYN1 = false;
  List<bool> anggotaBPJS;
  Map<String, String> dataBPJS = {
  };

  void checkValidQues() {
    final bool check = tempAirMinum != null && tempSenitasi != null && 
      tempProvider != null && tempStatusSinyal != null && tempTV != null && 
      tempAset != null && tempBantuan != null && tempInternet != null;
    validQuesNotif.value = check;
  }

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

  String tempAset;
  List<String> opsiAset = [
    'Sertifikat', 'Akte', 'Hibah', 'Waris', 'Petok D', 'Tidak Ada'
  ];

  String tempBantuan;
  List<String> opsiBantuan = [
    'Belum Pernah',
    'Bantuan Sosial Tunai',
    'Program Keluarga Harapan',
    'Bansos lainnya',
  ];

  bool tempYN2 = false;
  List<bool> aksesInternet;
  String tempInternet;

  List<bool> anggotaRekening;
  List<bool> anggotaKIP;
  List<bool> anggotaKIS;
  List<bool> anggotaPrakerja;

  List<String> bankAnggota = [];
  // Map<String, String> dataBPJS = {
  // };
}