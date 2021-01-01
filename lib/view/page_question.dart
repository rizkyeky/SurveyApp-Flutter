part of 'page.dart';

class QuestionPage extends Page {

  QuestionPage(this.dataKeluarga);

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    _bloc.dataKeluarga = dataKeluarga;
    _bloc.anggotaBPJS = List.generate(dataKeluarga['Anggota'].length as int, (index) => false);
  }

  final Map<String, dynamic> dataKeluarga;
  final QuestionBloc _bloc = locator.get<QuestionBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertanyaan'),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('Apakah sudah memiliki BPJS?',
                    style:  TextStyle(fontSize: 16)
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    final List<String> opsi = ['Iya', 'Tidak'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        ...List.generate(
                          2, (indexRadio) => RadioListTile<bool>(
                            groupValue: _bloc.tempYN1,
                            title: Text(opsi[indexRadio]),
                            value: indexRadio == 0,
                            onChanged: (value) => setState(() {
                                _bloc.tempYN1 = value;
                                _bloc.anggotaBPJSNotif.value = _bloc.tempYN1;
                              }
                            ),
                          ),
                        ),
                        if (_bloc.tempYN1) const Padding(
                        padding: EdgeInsets.all(18),
                          child: Text('Siapa saja?',
                            style: TextStyle(fontSize: 16)
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _bloc.anggotaBPJSNotif, 
                          builder: (context, value, _) => value ? Column(
                            children: List.generate(dataKeluarga['Anggota'].length as int, (index) => CheckboxListTile(
                              title: Text(dataKeluarga['Anggota'][index]['Nama'] as String),
                              value: _bloc.anggotaBPJS[index],
                              onChanged: (value) => setState(() => _bloc.anggotaBPJS[index] = value),
                            ))
                          ) : const SizedBox()
                        ),
                      ]
                    );
                  }
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(6),
                    child: Text('Darimana sumber air minum?',
                      style:  TextStyle(fontSize: 16)
                    ),
                  ),
                  const SizedBox(height: 6,),
                  DropdownSearch<String>(
                    hint: "Pilih Sumber Air Minum",
                    items: _bloc.opsiAirMinum,
                    mode: Mode.MENU,
                    onChanged: (value) => _bloc.tempAirMinum = value,
                    searchBoxDecoration: const InputDecoration(
                      filled: true,
                      hintText: 'Cari Sumber Air Minum',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    dropdownSearchDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),  
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(6),
                    child: Text('Dimana tempat senitasi?',
                      style:  TextStyle(fontSize: 16)
                    ),
                  ),
                  const SizedBox(height: 6,),
                  DropdownSearch<String>(
                    hint: "Pilih Senitasi",
                    items: _bloc.opsiSenitasi,
                    mode: Mode.MENU,
                    onChanged: (value) => _bloc.tempSenitasi = value,
                    searchBoxDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    dropdownSearchDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),  
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(6),
                    child: Text('Darimana tempat akses informasi?',
                      style:  TextStyle(fontSize: 16)
                    ),
                  ),
                  const SizedBox(height: 6,),
                  DropdownSearch<String>(
                    hint: "Pilih Provider",
                    items: _bloc.opsiProvider,
                    mode: Mode.MENU,
                    onChanged: (value) => _bloc.tempProvider = value,
                    searchBoxDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    dropdownSearchDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  DropdownSearch<String>(
                    hint: "Pilih Status Sinyal",
                    items: _bloc.opsiProvider,
                    mode: Mode.MENU,
                    onChanged: (value) => _bloc.tempProvider = value,
                    searchBoxDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    dropdownSearchDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  DropdownSearch<String>(
                    hint: "Pilih Siaran TV",
                    items: _bloc.opsiTV,
                    mode: Mode.MENU,
                    onChanged: (value) => _bloc.tempTV = value,
                    searchBoxDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    dropdownSearchDecoration: const InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ],
              ),
            ),
          )
        ], 
      ),
    );
  }
}