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

  final FirebaseService _firebaseService = locator.get<FirebaseService>();

  ValueNotifier<bool> anggotaBPJSNotif = ValueNotifier(false);
  ValueNotifier<bool> aksesInternetNotif = ValueNotifier(false);
  ValueNotifier<bool> validQuesNotif = ValueNotifier(false);

  Map<String, dynamic> dataKeluarga;

  void checkValidQues() {

    final bool validBPJS = tempYN1 ? anggotaBPJS.contains(true) : !tempYN1;
    final bool validAirMinum = tempAirMinum != null && tempAirMinum != '' && tempAirMinum != 'Lainnya';
    final bool validSenitasi = tempSenitasi != null && tempSenitasi != '' && tempSenitasi != 'Lainnya';
    final bool validProvider = tempProvider != null && tempProvider != '' && tempProvider != 'Lainnya';
    final bool validStatusSinyal = tempStatusSinyal != null;
    final bool validTV = tempOpsiTV.contains(true);
    final bool validInternet = tempAksesInternet ? tempInternet != null : !tempAksesInternet;
    final bool validAset = !tempOpsiAset.contains(null);
    final bool validAsetLain = tempOpsiAset.last ? tempAsetLainnya != '' : !tempOpsiAset.last;
    final bool validBantuan = !tempOpsiBantuan.contains(null);
    final bool validBantuanLain = tempOpsiBantuan.last ? tempBantuanLainnya != '' : !tempOpsiBantuan.last;
    final bool validNamaBank = !namaRekeningAnggota.contains('');
    final bool validFoto = images.isNotEmpty;

    final bool check = validBPJS && validAirMinum && validSenitasi && validProvider &&
    validStatusSinyal && validTV && validInternet && validAset && validAsetLain && validBantuan
    && validBantuanLain && validNamaBank && validFoto;
    validQuesNotif.value = check;
  }

  bool tempYN1 = false;
  List<bool> anggotaBPJS;

  List<String> tempKelasBPSJ;
  List<String> opsiKelasBPSJ = [
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
  List<String> namaRekeningAnggota;

  List<bool> anggotaKIP;
  List<bool> anggotaKIS;
  List<bool> anggotaPrakerja;

  Future<void> saveJawabanKeluarga() async {
    
    final List<String> tempAnggotaBPJS = [];
    int i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    anggotaBPJS.forEach((element) {
      if (element) {
        tempAnggotaBPJS.add(dataKeluarga['Anggota'][i]['Nama'] as String);
      }
      i++;
    });

    final List<String> tempTV = [];
    i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    tempOpsiTV.forEach((element) {
      if (element && i != tempOpsiTV.length-1) {
        tempTV.add(opsiTV[i]);
      }
      i++;
    });
    if (tempTVLainnya != null && tempTVLainnya != '') tempTV.add(tempTVLainnya);
    

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

    final List<String> tempAset = [];
    i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    tempOpsiAset.forEach((element) {
      if (element && i != tempOpsiAset.length-1) {
        tempAset.add(opsiAset[i]);
      }
      i++;
    });
    if (tempAsetLainnya != null && tempAsetLainnya != '') tempAset.add(tempAsetLainnya);

    final List<String> tempBantuan = [];
    i = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    tempOpsiBantuan.forEach((element) {
      if (element && i != tempOpsiBantuan.length-1) {
        tempBantuan.add(opsiBantuan[i]);
      }
      i++;
    });
    if (tempBantuanLainnya != null && tempBantuanLainnya != '') {tempBantuan.add(tempBantuanLainnya);}


    dataKeluarga.addAll({
      'Jawaban': {
        'BPJS': tempYN1,
        'Anggota BPJS': tempAnggotaBPJS,
        'Kelas BPJS': tempKelasBPSJ,
        'Air Minum': tempAirMinum,
        'Senitasi': tempSenitasi,
        'Provider Telp': tempProvider,
        'Status Sinyal': tempStatusSinyal,
        'TV': tempTV,
        'Akses Internet': tempAksesInternet,
        'Internet': tempInternet,
        'Anggota Rekening': tempAnggotaRekening,
        'Nama Bank': namaRekeningAnggota,
        'Anggota KIP': tempAnggotaKIP,
        'Anggota KIS': tempAnggotaKIS,
        'Surat Aset': tempAset,
        'Bantuan': tempBantuan
      }
    });
    await _firebaseService.addKeluarga(dataKeluarga);
  }

  List<File> images = [];
  final picker = ImagePicker();

  Future<File> getImage() async {
    try {
      final PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void deleteImg(int index) {
    images.removeAt(index);
  }
}