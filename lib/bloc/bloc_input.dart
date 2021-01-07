part of 'bloc.dart';

class InputBloc implements Bloc {
  @override
  void dispose() {
    validInputNotif.dispose();
  }

  @override
  void init() {
    // TODO: implement init
  }

  ValueNotifier<bool> validInputNotif = ValueNotifier(false);

  String tempNama;
  String tempNik;
  String tempJenisKel;
  String tempTempatLahir;
  DateTime tempTglLahir;
  String tempAgama;
  String tempPekerjaan;
  String tempLulusan;
  String tempPendidikan;
  String tempStatusPerkawinan;
  String tempStatusKeluarga;
  String tempKewarganegaraan;

  String tempNamaAyah;
  String tempNamaIbu;
  String tempNIKAyah;
  String tempNIKIbu;

  String tempGolDarah;
  String tempAktaLahir;
  String tempNomorPasport;
  DateTime tempTglPasport;
  String tempNomorKITAS;

  String tempNomorAktaKawin;
  DateTime tempTglAktaKawin;

  String tempNomorAktaCerai;
  DateTime tempTglAktaCerai;

  String tempCacat;
  String tempKB;

  String tempAlamat;
  String tempDusun;
  String tempRW;
  String tempRT;

  String tempNomorTelp;

  bool tempHamil = false;
  bool tempKTPel = false;

  Map<String, dynamic> dataAnggota() => {
    'Nama': tempNama,
    'NIK': tempNik,
    'Tempat Lahir': tempTempatLahir,
    'Tanggal Lahir': tempTglLahir != null ? formatDate(tempTglLahir) : null,
    'Jenis Kelamin': opsi['kelamin'].indexOf(tempJenisKel) + 1,
    'Agama': opsi['agama'].indexOf(tempAgama),
    'Pekerjaan': opsi['pekerjaan'].indexOf(tempPekerjaan) + 1,
    'Lulusan': opsi['pendidikan1'].indexOf(tempLulusan) + 1,
    'Pendidikan': opsi['pendidikan2'].indexOf(tempPendidikan) + 1,
    'Status Perkawinan': opsi['statusperkawinan'].indexOf(tempStatusPerkawinan) + 1,
    'Status Keluarga': opsi['statuskeluarga'].indexOf(tempStatusKeluarga) + 1,
    'Kewarganegaraan': opsi['kewarganegara'].indexOf(tempKewarganegaraan) + 1,

    'Alamat': tempAlamat,
    'Dusun': opsi['dusun'].indexOf(tempDusun) + 1,
    'RW': tempRW,
    'RT': tempRT,

    'Nama Ayah': tempNamaAyah,
    'Nama Ibu': tempNamaIbu,
    'NIK Ayah': tempNIKAyah,
    'NIK Ibu': tempNIKIbu,

    'Golongan Darah': opsi['dusun'].indexOf(tempGolDarah) + 1,
    'Akta Kelahiran': tempAktaLahir,
    'Nomor Pasport': tempNomorPasport,
    'Tanggal Akhir Pasport': tempTglPasport != null ? formatDate(tempTglPasport) : null,
    'Nomor Dokumen KITAS': tempNomorKITAS,

    'Nomor Akta Perkawinan': tempNomorAktaKawin,
    'Tanggal Akta Perkawinan': tempTglAktaKawin != null ? formatDate(tempTglAktaKawin) : null,

    'Nomor Akta Perceraian': tempNomorAktaCerai,
    'Tanggal Akta Perceraian': tempTglAktaCerai != null ? formatDate(tempTglAktaCerai) : null,

    'Cacat': opsi['cacat'].indexOf(tempCacat) + 1,
    'Cara KB': opsi['cacat'].indexOf(tempKB) + 1,

    'Nomor Telp': tempNomorTelp,

    'Hamil': tempHamil ? 1 : 2,
    'KTP-E': tempKTPel ? 1 : 2,
  };

  void checkValidFormAnggota() {
    final bool valid = tempNama != null &&
    tempNik != null;
    // tempJenisKel != null &&
    // tempTempatLahir != null &&
    // tempTglLahir != null &&
    // tempAgama != null &&
    // tempPekerjaan != null &&
    // tempLulusan != null &&
    // tempPendidikan != null&& 
    // tempStatusPerkawinan != null &&
    // tempStatusKeluarga != null &&
    // tempKewarganegaraan != null &&
    // tempNamaAyah != null &&
    // tempNamaIbu != null &&
    // tempNIKAyah != null &&
    // tempNIKIbu != null &&

    // tempGolDarah != null &&
    // tempAktaLahir != null &&
    // tempNomorPasport != null &&
    // tempTglPasport != null &&
    // tempNomorKITAS != null &&

    // tempNomorAktaKawin != null &&
    // tempTglAktaKawin != null &&

    // tempNomorAktaCerai != null &&
    // tempTglAktaCerai != null &&

    // tempCacat != null &&
    // tempKB != null &&

    // tempAlamat != null &&
    // tempDusun != null &&
    // tempRW != null &&
    // tempRT != null;
    validInputNotif.value = valid;
  }

  Map<String, List<String>> opsi = {
    'cacat': [
      'Cacat Fisik',
      'Cacat Netra/Buta',
      'Cacat Rungu/Wicara',
      'Cacat Mental/Jiwa',
      'Cacat Fisik dan Mental',
      'Cacat Lainnya',
      'Tidak Cacat',
    ],
    'kelamin': [
      'Laki-laki',
      'Perempuan'
    ],
    'kb': [
      'Pil', 'IUD', 'Suntik', 'Kondom',
      'Susuk KB', 'Sterilisasi Wanita',
      'Sterilisasi Pria', 'Lainnya',
    ],
    'dusun': [
      'Jatirenggo',
      'Madyorenggo',
    ],
    'agama': [
      'Islam', 'Kristen', 'Katholik',
      'Hindu', 'Budha', 'Khonghucu',
      'Kepercayaan Tuhan YME / Lainnya'
    ],
    'statusperkawinan': [
      'Belum Kawin',
      'Kawin',
      'Cerai Hidup',
      'Cerai Mati',
    ],
    'statuskeluarga': [
      'Kepala Keluarga',
      'Suami',
      'Istri',
      'Anak',
      'Menantu',
      'Cucu',
      'Orang tua',
      'Mertua',
      'Famili Lain',
      'Pembantu',
      'Lainnya'
    ],
    'kewarganegara': [
      'WNI',
      'WNA',
      'Dua Kewarganegaraan'
    ],
    'darah': [
      'A', 'B', 'AB', 'O', 'A+', 'A-',
      'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
      'Tidak Tahu'
    ],
    'pendidikan1': [
      'Tidak/Belum Sekolah',
      'Belum Tamat SD/Sederajat',
      'Tamat SD/Sederajat',
      'SLTP/Sederajat',
      'SLTA/Sederajat',
      'Diploma 1/2',
      'Akademi/Diploma 3/S. Muda',
      'Diploma 4/ Strata 1',
      'Strata 2',
      'Strata 3'
    ],
    'pendidikan2': [
      'Belum Masuk TK/Kelompok Bermain',
      'Sedang TK/Kelompok Bermain',
      'Tidak Pernah Sekolah',
      'Sedang SD/Sederajat',
      'Tidak Tamat SD/Sederajat',
      'Sedang SLTP/Sederajat',
      'Sedang SLTA/Sederajat',
      'Sedang D1/Sederajat',
      'Sedang D2/Sederajat',
      'Sedang D3/Sederajat',
      'Sedang S1/Sederajat',
      'Sedang S2/Sederajat',
      'Sedang S3/Sederajat',
      'Sedang SLB A/Sederajat',
      'Sedang SLB B/Sederajat',
      'Sedang SLB C/Sederajat',
      'Tidak Dapat Membaca dan Menulis',
      'Tidak Sedang Sekolah'
    ],
    'pekerjaan': [
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
      'Wiraswasta',
    ]
  };
}