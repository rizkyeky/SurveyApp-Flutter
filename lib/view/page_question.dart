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
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('Apakah keluarga sudah memiliki BPJS?',
                      style:  TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    StatefulBuilder(
                      builder: (context, setState) {
                        final List<String> opsi = ['Iya', 'Tidak'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    _bloc.checkValidQues();
                                  }
                                ),
                              ),
                            ),
                            if (_bloc.tempYN1) const SizedBox(height: 12,),
                            if (_bloc.tempYN1) const Text('Siapa saja?',
                              style: TextStyle(fontSize: 16)
                            ),
                            if (_bloc.tempYN1) const SizedBox(height: 12,),
                            ValueListenableBuilder<bool>(
                              valueListenable: _bloc.anggotaBPJSNotif, 
                              builder: (context, value, _) => value ? Column(
                                children: List.generate(dataKeluarga['Anggota'].length as int, (index) => CheckboxListTile(
                                  dense: true,
                                  title: Text(dataKeluarga['Anggota'][index]['Nama'] as String,
                                    style: const TextStyle(fontSize: 15)
                                  ),
                                  value: _bloc.anggotaBPJS[index],
                                  onChanged: (value) {
                                    setState(() => _bloc.anggotaBPJS[index] = value);
                                    _bloc.checkValidQues();
                                  },
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
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('Darimana sumber air minum?',
                      style:  TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    DropDownOption(
                      title: 'Pilih Sumber Air Minum',
                      items: _bloc.opsiAirMinum,
                      value: _bloc.tempAirMinum,
                      onChanged: (val) {
                        _bloc.tempAirMinum = val;
                        _bloc.checkValidQues();
                      },
                    ),  
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('Dimana tempat senitasi?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    DropDownOption(
                      title: 'Pilih Senitasi',
                      items: _bloc.opsiSenitasi,
                      value: _bloc.tempSenitasi,
                      onChanged: (val) {
                        _bloc.tempSenitasi = val;
                        _bloc.checkValidQues();
                      },
                    ),  
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('Darimana tempat akses informasi?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    DropDownOption(
                      title: 'Pilih Penyedia Telepon',
                      items: _bloc.opsiProvider,
                      value: _bloc.tempProvider,
                      onChanged: (val) {
                        _bloc.tempProvider = val;
                        _bloc.checkValidQues();
                      },
                    ),
                    const SizedBox(height: 12,),
                    DropDownOption(
                      title: 'Pilih Status Sinyal',
                      items: _bloc.opsiStatusSinyal,
                      value: _bloc.tempStatusSinyal,
                      onChanged: (val) {
                        _bloc.tempStatusSinyal = val;
                        _bloc.checkValidQues();
                      },
                    ),
                    const SizedBox(height: 12,),
                    DropDownOption(
                      title: 'Pilih Siaran TV',
                      items: _bloc.opsiTV,
                      value: _bloc.tempTV,
                      onChanged: (val) {
                        _bloc.tempTV = val;
                        _bloc.checkValidQues();
                      },
                    ),
                    const SizedBox(height: 12,),
                    const Text('Apakah keluarga miliki akses internet?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    StatefulBuilder(
                      builder: (context, setState) {
                        final List<String> opsi = ['Iya', 'Tidak'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            ...List.generate(
                              opsi.length, (indexRadio) => RadioListTile<bool>(
                                groupValue: _bloc.tempAksesInternet,
                                title: Text(opsi[indexRadio]),
                                value: indexRadio == 0,
                                onChanged: (value) => setState(() {
                                    _bloc.tempAksesInternet = value;
                                    _bloc.aksesInternetNotif.value = _bloc.tempAksesInternet;
                                    _bloc.checkValidQues();
                                  }
                                ),
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _bloc.aksesInternetNotif, 
                              builder: (context, value, _) => value ? DropDownOption(
                                title: 'Pilih Penyedia Internet',
                                items: _bloc.opsiProvider,
                                value: _bloc.tempInternet,
                                onChanged: (val) {
                                  _bloc.tempInternet = val;
                                  _bloc.checkValidQues();
                                },
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
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: StatefulBuilder(
                  builder: (context, setState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('Siapa yang sudah memiliki rekening bank?',
                        style: TextStyle(fontSize: 16)
                      ),
                      const SizedBox(height: 12,),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String),
                            value: _bloc.anggotaRekening[index],
                            onChanged: (value) {
                              setState(() => _bloc.anggotaRekening[index] = value);
                              _bloc.checkValidQues();
                            },
                          ),
                          if (_bloc.anggotaRekening[index]) TextFieldWithTitle(
                            title: 'Apa nama bank yang dimiliki?',
                            onChanged: (value) {
                              _bloc.namaRekeningAnggota[index] = value;
                              _bloc.checkValidQues();
                            },
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: StatefulBuilder(
                  builder: (context, setState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('Siapa yang sudah memiliki Kartu Indonesia Pintar?',
                        style: TextStyle(fontSize: 16)
                      ),
                      const SizedBox(height: 12,),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            dense: true,
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String,
                              style: const TextStyle(fontSize: 15)
                            ),
                            value: _bloc.anggotaKIP[index],
                            onChanged: (value) {
                              setState(() => _bloc.anggotaKIP[index] = value);
                              _bloc.checkValidQues();
                            },
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: StatefulBuilder(
                  builder: (context, setState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('Siapa yang sudah memiliki Kartu Indonesia Sehat?',
                        style: TextStyle(fontSize: 16)
                      ),
                      const SizedBox(height: 12,),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            dense: true,
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String,
                              style: const TextStyle(fontSize: 15)
                            ),
                            value: _bloc.anggotaKIS[index],
                            onChanged: (value) {
                              setState(() => _bloc.anggotaKIS[index] = value);
                              _bloc.checkValidQues();
                            },
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: StatefulBuilder(
                  builder: (context, setState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('Siapa yang sudah memiliki Kartu Prakerja?',
                        style: TextStyle(fontSize: 16)
                      ),
                      const SizedBox(height: 12,),
                      ...List.generate(dataKeluarga['Anggota'].length as int, (index) => Column(
                        children: [
                          CheckboxListTile(
                            dense: true,
                            title: Text(dataKeluarga['Anggota'][index]['Nama'] as String,
                              style: const TextStyle(fontSize: 15)
                            ),
                            value: _bloc.anggotaPrakerja[index],
                            onChanged: (value) {
                              setState(() => _bloc.anggotaPrakerja[index] = value);
                              _bloc.checkValidQues();
                            },
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('Apakah keluarga memiliki surat aset?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    DropDownOption(
                      title: 'Pilih Surat Aset',
                      items: _bloc.opsiAset,
                      value: _bloc.tempAset,
                      onChanged: (value) {
                        _bloc.tempAset = value;
                        _bloc.checkValidQues();
                      },
                    )
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('Apakah keluarga pernah mendapatkan bantuan?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    DropDownOption(
                      title: 'Pilih Bantuan',
                      items: _bloc.opsiBantuan,
                      value: _bloc.tempBantuan,
                      onChanged: (value) {
                        _bloc.tempBantuan = value;
                        _bloc.checkValidQues();
                      },
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
          backgroundColor: value ? Colors.teal : Colors.grey,
          elevation: value ? 1 : 0,
          onPressed: value ? () => _bloc.saveJawabanKeluarga() : null,
          child: const Icon(Icons.check),
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
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
          ),
        ),
      ),
    );
  }
}