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

  List<Map<String, dynamic>> pertanyaan = [
    {
      'soal': 'Siapa penemu listrik statis?',
      'opsi': [
        'Jono',
        'Jonshon',
        'Jones'
      ]
    }
  ];

  List<String> jawaban = List.generate(1, (index) => '');

}