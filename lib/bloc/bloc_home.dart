part of 'bloc.dart';

class HomeBloc implements Bloc {
  @override
  void dispose() {
    anggotaNotif.dispose();
    validFormNotif.dispose();
  }

  @override
  void init() {
    anggotaNotif = ValueNotifier(anggota);
    validFormNotif = ValueNotifier(checkValid());
  }

  final FirebaseService _firebaseService = locator.get<FirebaseService>();

  ValueNotifier<List<Map<String, dynamic>>> anggotaNotif;
  ValueNotifier<bool> validFormNotif;

  String nomorKK;

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
    dataKeluarga['Nomor KK'] = nomorKK;
    dataKeluarga['Anggota'] = anggota;
  }

  bool checkValid() => anggota.isNotEmpty && (nomorKK != null && nomorKK != '');

  void addAnggota(Map<String, dynamic> dataAnggota) {
    anggota.add(dataAnggota);
    anggotaNotif.value = List.from(anggota);
  }

  void deleteAnggota(int index) {
    anggota.removeAt(index);
    anggotaNotif.value = List.from(anggota);
    validFormNotif.value = checkValid();
  }

  void resetForm() {
    anggota = [];
    dataKeluarga = {};
    nomorKK = null;
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

}
