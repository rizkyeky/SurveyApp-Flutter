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

  List<Map<String, dynamic>> pertanyaanOpsi = [
    {
      'soal': 'Apakah sudah memiliki BPJS?',
      'opsi': [
        'Jono',
        'Jonshon',
        'Jones'
      ]
    },
    {
      'soal': 'Sumber air minum apa?',
      'opsi': [
        'AirMn_kemasan',
        'AirMn_PAM',
        'AirMn_ledeng_tanpa_meteran',
        'AirMn_sumurbor',
        'AirMn_sumur',
        'AirMn_mataair',
        'AirMn_sungai',
        'AirMn_hujan',
        'AirMn_lainnya',
        'AirMn_lainnya_sebutkan'
      ]
    }
  ];

  List<String> pertanyaanInput = [
    'Siapa penemu listrik statis?',
    'Siapa penemu listrik dinamis?',
  ];

  List<String> jawabanOpsi = List.generate(2, (index) => '');
  List<String> jawabanInput = List.generate(2, (index) => '');

}