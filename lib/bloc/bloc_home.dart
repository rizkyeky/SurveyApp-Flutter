part of 'bloc.dart';

class HomeBloc implements Bloc {
  @override
  void dispose() {
    anggotaNotif.dispose();
    validFormNotif.dispose();
    validAnggotaNotif.dispose();
    satuAlamatNotif.dispose();
    satuAgamaNotif.dispose();
  }

  @override
  void init() {
    anggotaNotif.value = List.from(anggota);
  }

  final FirebaseService _firebaseService = locator.get<FirebaseService>();

  ValueNotifier<List<Map<String, dynamic>>> anggotaNotif = ValueNotifier([]);
  ValueNotifier<bool> validFormNotif = ValueNotifier(false);
  ValueNotifier<bool> validAnggotaNotif = ValueNotifier(false);
  ValueNotifier<bool> satuAlamatNotif = ValueNotifier(false);
  ValueNotifier<bool> satuAgamaNotif = ValueNotifier(false);

  String nomorKK;
  bool satuAlamat = false;
  bool satuAgama = false;

  String tempAlamat;
  String tempAgama;

  String tempNama;
  String tempNik;
  String tempJenisKel;
  String tempTempatLahir;
  DateTime tempTglLahir;
  
  List<String> tempPekerjaan = [];
  List<String> tempLulusan = [];
  List<String> tempNomorTelp = [];

  List<Map<String, dynamic>> anggota = [];

  Map<String, dynamic> dataKeluarga = {};

  Future<bool> checkNoKK(String noKK) async {
    final ServiceResult<List<String>> result = await _firebaseService.checkKoleksi();
    if (result.value != null) {
      return result.value.contains(noKK); 
    } else {
      return false;
    }
  }

  void saveDataKeluarga() {
    // dataKeluarga['Nomor KK'] = nomorKK;

    // // ignore: avoid_function_literals_in_foreach_calls
    // anggota.forEach((element) {element.addAll({
    //   'Pekerjaan': tempPekerjaan[anggota.indexOf(element)],
    //   'Lulusan': tempLulusan[anggota.indexOf(element)],
    //   'Nomor HP': tempNomorTelp[anggota.indexOf(element)],
    // });});

    dataKeluarga['Anggota'] = anggota;
  }

  bool checkValidKeluarga() => anggota.isNotEmpty && (nomorKK != null && nomorKK != '');

  void addAnggota(Map<String, dynamic> dataAnggota) {
    anggota.add(dataAnggota);
    anggotaNotif.value = List.from(anggota);
  }

  // void editAnggota(int index) {
  //   tempNama = anggota[index]['Nama'];
  //   tempNik = anggota[index]['NIK'];
  //   tempJenisKel = anggota[index]['Jenis Kelamin'];
  //   tempTempatLahir = anggota[index]['Tempat Lahir'];
  //   tempTglLahir = convertDate(anggota[index]['Tanggal Lahir']);
  // }

  // void modifAnggota(int index) {
  //   anggota[index] = {
  //     'Nama': tempNama,
  //     'NIK': tempNik,
  //     'Jenis Kelamin': tempJenisKel,
  //     'Tempat Lahir': tempTempatLahir,
  //     'Tanggal Lahir': formatDate(tempTglLahir),
  //     'Agama': tempAgama,
  //     'Alamat': tempAlamat,
  //   };
  //   anggotaNotif.value = List.from(anggota);

  //   tempNama = null;
  //   tempNik = null;
  //   tempJenisKel = null;
  //   tempTempatLahir = null;
  //   tempTglLahir = null;
  // }

  void deleteAnggota(int index) {
    anggota.removeAt(index);
    anggotaNotif.value = List.from(anggota);
    tempPekerjaan.removeAt(index);
    tempLulusan.removeAt(index);
    tempNomorTelp.removeAt(index);
    validAnggotaNotif.value = checkValidKeluarga();
  }
}
