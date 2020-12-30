part of 'bloc.dart';

class HomeBloc implements Bloc {
  @override
  void dispose() {
    anggotaNotif.dispose();
    validFormNotif.dispose();
  }

  @override
  void init() {
    anggotaNotif.value = List.from(anggota);
  }

  ValueNotifier<List<Map<String, String>>> anggotaNotif = ValueNotifier([]);
  ValueNotifier<bool> validFormNotif = ValueNotifier(false);

  String nomorKK;

  String tempNama;
  String tempNik;
  String tempAlamat;
  String tempJenisKel;
  String tempTempatLahir;
  DateTime tempTglLahir;
  String tempAgama;
  String tempLulusan;

  List<Map<String, String>> anggota = [
    {
      'Nama': 'Mochamad Rizky Darmawan',
      'NIK': '321111000222333444',
      'Jenis Kelamin': 'Laki-laki',
      'Tempat Lahir': 'Badung dan Surabaya',
      'Tanggal Lahir': '31 Desember 2020',
    }
  ];

  void checkValidFormAnggota() {
    validFormNotif.value = tempNama != null && tempNik != null && 
    tempJenisKel != null && tempTempatLahir != null && tempTglLahir != null;
  }

  void addAnggota() {
    if (tempNama != null && tempNik != null && tempJenisKel != null && 
    tempTempatLahir != null && tempTglLahir != null
    ) {
      anggota.add({
        'Nama': tempNama,
        'NIK': tempNik,
        'Jenis Kelamin': tempJenisKel,
        'Tempat Lahir': tempTempatLahir,
        'Tanggal Lahir': formatDate(tempTglLahir),
      });
      anggotaNotif.value = List.from(anggota);
      
      tempNama = null;
      tempNik = null;
      tempAlamat = null;
      tempJenisKel = null;
      tempTempatLahir = null;
      tempTglLahir = null;
      tempAgama = null;
      tempLulusan = null;
    }
  }

  void deleteAnggota(int index) {
    anggota.removeAt(index);
    anggotaNotif.value = List.from(anggota);
  }
}
