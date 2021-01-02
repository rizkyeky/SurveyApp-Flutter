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

  void checkValidQues() {

    final bool validBPJS = tempYN1 ? anggotaBPJS.contains(true) : !tempYN1;
    final bool validAirMinum = tempAirMinum != null;
    final bool validSenitasi = tempSenitasi != null;
    final bool validProvider = tempProvider != null;
    final bool validStatusSinyal = tempStatusSinyal != null;
    final bool validTV = tempTV != null;
    final bool validInternet = tempAksesInternet ? tempInternet != null : !tempAksesInternet;
    final bool validAset = tempAset != null;
    final bool validBantuan = tempBantuan != null;

    final bool check = validBPJS && validAirMinum && validSenitasi && validProvider &&
    validStatusSinyal && validTV && validInternet && validAset && validBantuan;
    validQuesNotif.value = check;
  }

  String tempAirMinum;
  List<String> opsiAirMinum = [
    'Tidak Ada',
    'Kemasan',
    'PAM',
    'Ledeng Tanpa Meteran',
    'Sumur Bor',
    'Sumur',
    'Mata Air',
    'Sungai',
    'Hujan',
    'Lainnya',
  ];
  
  String tempSenitasi;
  List<String> opsiSenitasi = [
    'Tidak Ada',
    'Jamban Sendiri',
    'Jamban Bersama',
    'Jamban Umum',
    'Bukan Jamban',
    'Lainnya'
  ];

  String tempProvider;
  List<String> opsiProvider = [
    'Tidak Ada',
    'Telkomsel',
    'Indosat',
    'XL',
    'Lainnya'
  ];

  String tempStatusSinyal;
  List<String> opsiStatusSinyal = [
    'Tidak Ada',
    'Kuat',
    'Sedang',
    'Lemah',
  ];

  String tempTV;
  List<String> opsiTV = [
    'Tidak Ada',
    'TVRI',
    'Swasta',
    'Luar Negri',
  ];

  String tempAset;
  List<String> opsiAset = [
    'Tidak Ada', 'Sertifikat', 'Akte', 'Hibah', 'Waris', 'Petok D', 'Lainnya'
  ];

  String tempBantuan;
  List<String> opsiBantuan = [
    'Tidak Ada',
    'Bantuan Sosial Tunai',
    'Program Keluarga Harapan',
    'Lainnya',
  ];

  bool tempAksesInternet = false;
  String tempInternet;

  List<bool> anggotaRekening;
  List<String> namaRekeningAnggota = [];

  List<bool> anggotaKIP;
  List<bool> anggotaKIS;
  List<bool> anggotaPrakerja;

  void saveJawabanKeluarga() {
    final List<String> tempAnggotaBPJS = [];
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaBPJS.forEach((element) {
      int i = 0;
      if (element) {
        tempAnggotaBPJS.add(dataKeluarga['Anggota'][i] as String);
      }
      i++;
    });

    final List<String> tempAnggotaRekening = [];
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaRekening.forEach((element) {
      int i = 0;
      if (element) {
        tempAnggotaRekening.add(dataKeluarga['Anggota'][i] as String);
      }
      i++;
    });

    final List<String> tempAnggotaKIP = [];
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaKIP.forEach((element) {
      int i = 0;
      if (element) {
        tempAnggotaKIP.add(dataKeluarga['Anggota'][i] as String);
      }
      i++;
    });

    final List<String> tempAnggotaKIS = [];
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaKIS.forEach((element) {
      int i = 0;
      if (element) {
        tempAnggotaKIS.add(dataKeluarga['Anggota'][i] as String);
      }
      i++;
    });

    dataKeluarga.addAll({
      'Jawaban': {
        'BPjS': tempYN1,
        'Anggota BPJS': tempAnggotaBPJS,
        'Air Minum': tempAirMinum,
        'Senitasi': tempSenitasi,
        'Provider Telp': tempProvider,
        'Status Sinyal': tempStatusSinyal,
        'TV': tempTV,
        'Akses Internet': tempAksesInternet,
        'Internet': tempInternet,
        'Anggota Rekening': tempAnggotaRekening,
        'Anggota KIP': tempAnggotaKIP,
        'Anggota KIS': tempAnggotaKIS,
        'Surat Aset': tempAset,
        'Bantuan': tempBantuan
      }
    });

    print(dataKeluarga);
  }
}