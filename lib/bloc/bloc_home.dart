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

  List<Map<String, String>> anggota = [
    {
      'Nama': 'Mochamad Rizky Darmawan Ganteng Banget Gila',
      'NIK': '321111000222333444',
      'Jenis Kelamin': 'Perempuan',
      'Tempat Lahir': 'Bandung dan Bandung',
      'Tanggal Lahir': '1 January 1999',
      'Agama': 'Islam',
      'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung'
    },
    {
      'Nama': 'Dewi Rostika dan Dadang',
      'NIK': '321111000222333444',
      'Jenis Kelamin': 'Laki-laki',
      'Tempat Lahir': 'Bandung dan Surabaya',
      'Tanggal Lahir': '31 Desember 2020',
      'Agama': 'Islam',
      'Alamat': 'Jalan Raya Blok Kanan Kiri Pertigaan Deket Tukang Somay Bandung'
    }
  ];

  Map<String, dynamic> dataKeluarga = {
  };

  void saveDataKeluarga() {
    dataKeluarga['Nomor KK'] = nomorKK;

    // print(anggota);

    // ignore: avoid_function_literals_in_foreach_calls
    anggota.forEach((element) {element.addAll({
      'Pekerjaan': tempPekerjaan[anggota.indexOf(element)],
      'Lulusan': tempLulusan[anggota.indexOf(element)],
      'Nomor HP': tempNomorTelp[anggota.indexOf(element)],
    });});

    dataKeluarga['Anggota'] = anggota;
    // print(dataKeluarga);
  }

  void checkValidFormAnggota() {
    validFormNotif.value = tempNama != null && tempNik != null && 
    tempJenisKel != null && tempTempatLahir != null && tempTglLahir != null;
  }

  bool checkValidKeluarga() {
    final bool validAlamat = satuAlamat ? (tempAlamat != null || tempAlamat != '') : !satuAlamat;
    final bool validAgama = satuAlamat ? (tempAgama != null || tempAgama != '') : !satuAgama;
    return anggota.isNotEmpty && (nomorKK != null || nomorKK != '') && validAlamat && validAgama;
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
        'Agama': tempAgama,
        'Alamat': tempAlamat,
      });
      anggotaNotif.value = List.from(anggota);
      validFormNotif.value = false;

      validAnggotaNotif.value = checkValidKeluarga();

      tempPekerjaan.add('Belum/ Tidak Bekerja');
      tempLulusan.add('SD');
      tempNomorTelp.add(null);

      tempNama = null;
      tempNik = null;
      tempJenisKel = null;
      tempTempatLahir = null;
      tempTglLahir = null;
    }
  }

  void editAnggota(int index) {
    tempNama = anggota[index]['Nama'];
    tempNik = anggota[index]['NIK'];
    tempJenisKel = anggota[index]['Jenis Kelamin'];
    tempTempatLahir = anggota[index]['Tempat Lahir'];
    tempTglLahir = convertDate(anggota[index]['Tanggal Lahir']);
  }

  void modifAnggota(int index) {
    anggota[index] = {
      'Nama': tempNama,
      'NIK': tempNik,
      'Jenis Kelamin': tempJenisKel,
      'Tempat Lahir': tempTempatLahir,
      'Tanggal Lahir': formatDate(tempTglLahir),
      'Agama': tempAgama,
      'Alamat': tempAlamat,
    };
    anggotaNotif.value = List.from(anggota);

    tempNama = null;
    tempNik = null;
    tempJenisKel = null;
    tempTempatLahir = null;
    tempTglLahir = null;
  }

  void deleteAnggota(int index) {
    anggota.removeAt(index);
    anggotaNotif.value = List.from(anggota);
    tempPekerjaan.removeAt(index);
    tempLulusan.removeAt(index);
    tempNomorTelp.removeAt(index);
    validAnggotaNotif.value = checkValidKeluarga();
  }

  List<String> pendidikan = [
    'SD',
    'SMP',
    'SMA',
    'D3',
    'S1',
    'S2',
  ];

  List<String> pekerjaan = [
    'Belum/ Tidak Bekerja',
    'Mengurus Rumah Tangga',
    'Pelajar/ Mahasiswa',
    'Pensiunan',
    'Pewagai Negeri Sipil',
    'Tentara Nasional Indonesia',
    'Kepolisisan RI',
    'Perdagangan',
    'Petani/ Pekebun',
    'Peternak',
    'Nelayan/ Perikanan',
    'Industri',
    'Konstruksi',
    'Transportasi',
    'Karyawan Swasta',
    'Karyawan BUMN',
    'Karyawan BUMD',
    'Karyawan Honorer',
    'Buruh Harian Lepas',
    'Buruh Tani/ Perkebunan',
    'Buruh Nelayan/ Perikanan',
    'Buruh Peternakan',
    'Pembantu Rumah Tangga',
    'Tukang Cukur',
    'Tukang Listrik',
    'Tukang Batu',
    'Tukang Kayu',
    'Tukang Sol Sepatu',
    'Tukang Las/ Pandai Besi',
    'Tukang Jahit',
    'Tukang Gigi',
    'Penata Rias',
    'Penata Busana',
    'Penata Rambut',
    'Mekanik',
    'Seniman',
    'Tabib',
    'Paraji',
    'Perancang Busana',
    'Penterjemah',
    'Imam Masjid',
    'Pendeta',
    'Pastor',
    'Wartawan',
    'Ustadz/ Mubaligh',
    'Juru Masak',
    'Promotor Acara',
    'Anggota DPR-RI',
    'Anggota DPD',
    'Anggota BPK',
    'Presiden',
    'Wakil Presiden',
    'Anggota Mahkamah Konstitusi',
    'Anggota Kabinet/ Kementerian',
    'Duta Besar',
    'Gubernur',
    'Wakil Gubernur',
    'Bupati',
    'Wakil Bupati',
    'Walikota',
    'Wakil Walikota',
    'Anggota DPRD Provinsi',
    'Anggota DPRD Kabupaten/ Kota',
    'Dosen',
    'Guru',
    'Pilot',
    'Pengacara',
    'Notaris',
    'Arsitek',
    'Akuntan',
    'Konsultan',
    'Dokter',
    'Bidan',
    'Perawat',
    'Apoteker',
    'Psikiater/ Psikolog',
    'Penyiar Televisi',
    'Penyiar Radio',
    'Pelaut',
    'Peneliti',
    'Sopir',
    'Pialang',
    'Paranormal',
    'Pedagang',
    'Perangkat Desa',
    'Kepala Desa',
    'Biarawati',
    'Wiraswasta -> Isian wiraswasta',
  ];
}
