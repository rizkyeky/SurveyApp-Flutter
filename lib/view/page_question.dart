part of 'page.dart';

class QuestionPage extends Page {

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  final QuestionBloc _bloc = locator.get<QuestionBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertanyaan'),
      ),
      body: ListView.builder(
        itemCount: _bloc.pertanyaan.length,
        itemBuilder: (context, indexCard) => Card(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(_bloc.pertanyaan[indexCard]['soal'] as String,
                  style: const TextStyle(fontSize: 16)
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) => Column(
                  children: List.generate(
                    _bloc.pertanyaan[indexCard]['opsi'].length as int, 
                    (indexRadio) => RadioListTile<String>(
                      groupValue: _bloc.jawaban[indexCard],
                      title: Text(_bloc.pertanyaan[indexCard]['opsi'][indexRadio]  as String),
                      value: _bloc.pertanyaan[indexCard]['opsi'][indexRadio]  as String,
                      onChanged: (value) =>
                          setState(() => _bloc.jawaban[indexCard] = value),
                    ),)
                )),
            ],
          ),
        ),
      ),
    );
  }
}