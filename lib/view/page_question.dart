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
    _bloc.anggotaRekening = List.generate(dataKeluarga['Anggota'].length as int, (index) => false);
    _bloc.anggotaKIP = List.generate(dataKeluarga['Anggota'].length as int, (index) => false);
    _bloc.anggotaKIS = List.generate(dataKeluarga['Anggota'].length as int, (index) => false);
    _bloc.anggotaPrakerja = List.generate(dataKeluarga['Anggota'].length as int, (index) => false);
  }

  final Map<String, dynamic> dataKeluarga;
  final QuestionBloc _bloc = locator.get<QuestionBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertanyaan'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    const SizedBox(height: 12,),
                    DropdownSearch<String>(
                      hint: "Pilih Status Sinyal",
                      items: _bloc.opsiStatusSinyal,
                      mode: Mode.MENU,
                      onChanged: (value) => _bloc.tempStatusSinyal = value,
                      searchBoxDecoration: const InputDecoration(
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      dropdownSearchDecoration: const InputDecoration(
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    const SizedBox(height: 12,),
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
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text('Apakah terdapat akses internet?',
                        style: TextStyle(fontSize: 16)
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
                                groupValue: _bloc.tempYN2,
                                title: Text(opsi[indexRadio]),
                                value: indexRadio == 0,
                                onChanged: (value) => setState(() {
                                    _bloc.tempYN2 = value;
                                    _bloc.aksesInternetNotif.value = _bloc.tempYN2;
                                  }
                                ),
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _bloc.aksesInternetNotif, 
                              builder: (context, value, _) => value ? DropdownSearch<String>(
                                hint: "Pilih Penyedia Internet",
                                items: _bloc.opsiProvider,
                                mode: Mode.MENU,
                                onChanged: (value) => _bloc.tempInternet = value,
                                searchBoxDecoration: const InputDecoration(
                                  filled: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                ),
                                dropdownSearchDecoration: const InputDecoration(
                                  filled: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                ),
                              ) : const SizedBox()
                            ),
                          ]
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: StatefulBuilder(
                builder: (context, setState) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Siapa yang memiliki rekening bank?',
                          style:  TextStyle(fontSize: 16)
                        ),
                      ),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String),
                            value: _bloc.anggotaRekening[index],
                            onChanged: (value) => setState(() => _bloc.anggotaRekening[index] = value),
                          ),
                          if (_bloc.anggotaRekening[index]) TextFieldWithTitle(
                            title: 'Apa nama bank yang dimiliki?',
                            onChanged: (value) {},
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: StatefulBuilder(
                builder: (context, setState) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Siapa yang memiliki KIP (Kartu Indonesia Pintar)?',
                          style:  TextStyle(fontSize: 16)
                        ),
                      ),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String),
                            value: _bloc.anggotaKIP[index],
                            onChanged: (value) => setState(() => _bloc.anggotaKIP[index] = value),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: StatefulBuilder(
                builder: (context, setState) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Siapa yang memiliki KIS (Kartu Indonesia Sehat)?',
                          style:  TextStyle(fontSize: 16)
                        ),
                      ),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String),
                            value: _bloc.anggotaKIS[index],
                            onChanged: (value) => setState(() => _bloc.anggotaKIS[index] = value),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: StatefulBuilder(
                builder: (context, setState) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Siapa yang memiliki Kartu Prakerja?',
                          style:  TextStyle(fontSize: 16)
                        ),
                      ),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String),
                            value: _bloc.anggotaPrakerja[index],
                            onChanged: (value) => setState(() => _bloc.anggotaPrakerja[index] = value),
                          ),
                        ],
                      ))
                    ],
                  ),
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
                      child: Text('Apakah terdapat surat aset?',
                        style:  TextStyle(fontSize: 16)
                      ),
                    ),
                    const SizedBox(height: 6,),
                    DropdownSearch<String>(
                      hint: "Pilih surat aset",
                      items: _bloc.opsiAset,
                      mode: Mode.MENU,
                      onChanged: (value) => _bloc.tempAset = value,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('Apakah pernah mendapatkan bantuan?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 6,),
                    DropDownOption(
                      title: 'Pilih Bantuan',
                      items: _bloc.opsiBantuan,
                      value: _bloc.tempBantuan,
                      onChanged: (value) => _bloc.tempBantuan = value,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 300,),
          ], 
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _bloc.validQuesNotif,
        builder: (context, value, _) => FloatingActionButton(
            onPressed: value ? () {} : null,
            backgroundColor: value ? Colors.teal : Colors.grey,
            child: const Icon(Icons.save),
          )
      ),
    );
  }
}

class DropDownOption extends StatelessWidget {

  final String title;
  final String value;
  final List<String> items;
  final void Function(String) onChanged;

  const DropDownOption({this.title, this.value, this.items, this.onChanged});
  
  @override
  Widget build(BuildContext context) {
    String temp = value;
    return StatefulBuilder(
      builder: (context, setState) => DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          hint: Text(title),
          value: temp,
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          )).toList(),
          onChanged: (val) => setState(() {
            temp = val;
            onChanged(val);
          }),
        ),
      ),
    );
  }
}