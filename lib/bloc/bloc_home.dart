part of 'bloc.dart';

class HomeBloc implements Bloc {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    anggotaNotif.value = anggota;
  }

  ValueNotifier<List<Map>> anggotaNotif = ValueNotifier([]);

  String nomorKK;

  String tempNik;
  String tempAlamat;
  String tempJenisKel;
  String tempTempatLahir;
  DateTime tempTglLahir;

  List<Map<String, String>> anggota = [
    {
      'nik': '111',
      'alamat': 'Bandung',
      'jenisKel': 'Laki-laki',
      'tempatLahir': 'Bandung',
      'tempTglLahir': '2000-20-20'
    }
  ];

  void addAnggota() {
    if (tempNik != null && tempAlamat != null && tempJenisKel != null && 
    tempTempatLahir != null && tempTglLahir != null) {
      anggota.add({
        'nik': tempNik,
        'alamat': tempAlamat,
        'jenisKel': tempJenisKel,
        'tempatLahir': tempTempatLahir,
        'tempTglLahir': tempTglLahir.toLocal().toString().split(' ')[0]
      });
      anggotaNotif.value = anggota;
      tempNik = null;
      tempAlamat = null;
      tempJenisKel = null;
      tempTempatLahir = null;
      tempTglLahir = null;
    }
  }
}
