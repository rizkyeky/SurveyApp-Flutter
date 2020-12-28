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

  String answ;

  List<Map<String, dynamic>> pertanyaanOpsi = [
    {
      'soal': 'Siapa penemu listrik statis?',
      'opsi': [
        'Jono',
        'Jonshon',
        'Jones'
      ]
    }
  ];

  List<Map<String, dynamic>> pertanyaanInput = [
    {
      'soal': 'Siapa penemu listrik statis?',
    }
  ];

  List<String> jawaban = List.generate(1, (index) => '');

}