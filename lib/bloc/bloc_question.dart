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

  ValueNotifier<bool> anggotaBPJSNotif = ValueNotifier(false);

  Map<String, dynamic> dataKeluarga;

  bool tempYN1 = false;
  List<bool> anggotaBPJS;
  Map<String, String> dataBPJS = {
  };


  String tempAirMinum;
  List<String> opsiAirMinum = [
    'Air Minum Kemasan',
    'Air Minum PAM',
    'Air Minum Ledeng tanpa Meteran',
    'Air Minum Sumur Bor',
    'Air Minum Sumur',
    'Air Minum Mata Air',
    'Air Minum Sungai',
    'Air Minum Hujan',
    'Air Minum Lainnya',
  ];

  List<String> pertanyaanInput = [
    'Siapa penemu listrik statis?',
    'Siapa penemu listrik dinamis?',
  ];

  List<String> jawabanOpsi = List.generate(2, (index) => '');
  List<String> jawabanInput = List.generate(2, (index) => '');

}