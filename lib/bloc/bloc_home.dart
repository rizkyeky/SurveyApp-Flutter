part of 'bloc.dart';

class HomeBloc implements Bloc {
  @override
  void dispose() {
    anggotaNotif.dispose();
  }

  @override
  void init() {
    anggotaNotif.value = List.from(anggota);
  }

  ValueNotifier<List<Map<String, String>>> anggotaNotif = ValueNotifier([]);

  String nomorKK;

  String tempNama;
  String tempNik;
  String tempAlamat;
  String tempJenisKel;
  String tempTempatLahir;
  DateTime tempTglLahir;
  String tempAgama;
  String tempLulusan;

  List<Map<String, String>> anggota = [];

  void addAnggota() {
    if (tempNama != null && tempNik != null && tempAlamat != null && 
    tempJenisKel != null && tempTempatLahir != null && tempTglLahir != null && 
    tempAgama != null && tempLulusan != null
    ) {
      anggota.add({
        'nama': tempNama,
        'nik': tempNik,
        'alamat': tempAlamat,
        'jenisKel': tempJenisKel,
        'tempatLahir': tempTempatLahir,
        'tglLahir': tempTglLahir.toLocal().toString().split(' ')[0],
        'agama': tempAgama,
        'lulusan': tempLulusan
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
