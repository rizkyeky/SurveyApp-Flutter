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
      'soal': 'Siapa penemu listrik statis?',
      'opsi': [
        'Jono',
        'Jonshon',
        'Jones'
      ]
    }
  ];

  List<String> pertanyaanInput = [
    'Siapa penemu listrik statis?',
    'Siapa penemu listrik dinamis?',
  ];

  List<String> jawabanOpsi = List.generate(1, (index) => '');
  List<String> jawabanInput = List.generate(2, (index) => '');

}