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
      body: ListView(
        children: [
          ...List.generate(_bloc.pertanyaanOpsi.length, (indexCard) => Card(
            margin: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(_bloc.pertanyaanOpsi[indexCard]['soal'] as String,
                    style: const TextStyle(fontSize: 16)
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) => Column(
                    children: List.generate(
                      _bloc.pertanyaanOpsi[indexCard]['opsi'].length as int, 
                      (indexRadio) => RadioListTile<String>(
                        groupValue: _bloc.jawabanOpsi[indexCard],
                        title: Text(_bloc.pertanyaanOpsi[indexCard]['opsi'][indexRadio]  as String),
                        value: _bloc.pertanyaanOpsi[indexCard]['opsi'][indexRadio]  as String,
                        onChanged: (value) =>
                            setState(() => _bloc.jawabanOpsi[indexCard] = value),
                      ),
                    )
                  )
                ),
              ],
            ),
          ),),
          ...List.generate(_bloc.pertanyaanInput.length, (indexCard) => Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextFieldWithTitle(
                title: _bloc.pertanyaanInput[indexCard],
                onChanged: (value) => _bloc.jawabanInput[indexCard] = value,
              ),
            )
          ))
        ], 
      ),
    );
  }
}