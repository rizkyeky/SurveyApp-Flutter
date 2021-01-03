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

  void checkValidQues() {

    // final bool validBPJS = tempYN1 ? anggotaBPJS.contains(true) : !tempYN1;
    // final bool validAirMinum = tempAirMinum != null;
    // final bool validSenitasi = tempSenitasi != null;
    // final bool validProvider = tempProvider != null;
    // final bool validStatusSinyal = tempStatusSinyal != null;
    // final bool validTV = tempTV != null;
    // final bool validInternet = tempAksesInternet ? tempInternet != null : !tempAksesInternet;
    // final bool validAset = tempAset != null;
    // final bool validBantuan = tempBantuan != null;

    // final bool check = validBPJS && validAirMinum && validSenitasi && validProvider &&
    // validStatusSinyal && validTV && validInternet && validAset && validBantuan;
    // validQuesNotif.value = check;
  }

  bool tempYN1 = false;
  List<bool> anggotaBPJS;

  List<String> tempKelasBPSJ = List.generate(3, (index) => null);
  List<String> opsiKelasBPSJ =[
    'Kelas 1', 'Kelas 2', 'Kelas 3'
  ];

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
    'Telkomsel',
    'Indosat',
    'XL',
    'Lainnya'
  ];

  String tempStatusSinyal;
  List<String> opsiStatusSinyal = [
    'Tidak Ada',
    'Lemah',
    'Sedang',
    'Kuat',
  ];

  String tempTVLainnya;
  List<bool> tempOpsiTV = List.generate(4, (index) => false);
  List<String> opsiTV = [
    'TVRI',
    'Swasta',
    'Luar Negri',
    'Lainnya',
  ];

  String tempAsetLainnya;
  List<bool> tempOpsiAset = List.generate(6, (index) => false);
  List<String> opsiAset = [
    'Sertifikat', 'Akte', 'Hibah', 'Waris', 'Petok D', 'Lainnya'
  ];

  String tempBantuanLainnya;
  List<bool> tempOpsiBantuan = List.generate(3, (index) => false);
  List<String> opsiBantuan = [
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
    int i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaBPJS.forEach((element) {
      if (element) {
        tempAnggotaBPJS.add(dataKeluarga['Anggota'][i]['Nama'] as String);
      }
      i++;
    });

    final List<String> tempAnggotaRekening = [];
    i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaRekening.forEach((element) {
      if (element) {
        tempAnggotaRekening.add(dataKeluarga['Anggota'][i]['Nama'] as String);
      }
      i++;
    });

    final List<String> tempAnggotaKIP = [];
    i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaKIP.forEach((element) {
      if (element) {
        tempAnggotaKIP.add(dataKeluarga['Anggota'][i]['Nama'] as String);
      }
      i++;
    });

    final List<String> tempAnggotaKIS = [];
    i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaKIS.forEach((element) {
      if (element) {
        tempAnggotaKIS.add(dataKeluarga['Anggota'][i]['Nama'] as String);
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
        // 'TV': tempTV,
        'Akses Internet': tempAksesInternet,
        'Internet': tempInternet,
        'Anggota Rekening': tempAnggotaRekening,
        'Anggota KIP': tempAnggotaKIP,
        'Anggota KIS': tempAnggotaKIS,
        // 'Surat Aset': tempAset,
        // 'Bantuan': tempBantuan
      }
    });

    print(dataKeluarga);
  }
}