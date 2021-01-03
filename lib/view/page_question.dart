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

    _bloc.namaRekeningAnggota = List.generate(dataKeluarga['Anggota'].length as int, (index) => null);
    _bloc.tempKelasBPSJ = List.generate(dataKeluarga['Anggota'].length as int, (index) => null);
  }

  final Map<String, dynamic> dataKeluarga;
  final QuestionBloc _bloc = QuestionBloc();

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
                                children: List.generate(dataKeluarga['Anggota'].length as int, (indexAnggota) => Column(
                                  children: [
                                    CheckboxListTile(
                                      dense: true,
                                      title: Text(dataKeluarga['Anggota'][indexAnggota]['Nama'] as String,
                                        style: const TextStyle(fontSize: 15)
                                      ),
                                      value: _bloc.anggotaBPJS[indexAnggota],
                                      onChanged: (value) {
                                        setState(() => _bloc.anggotaBPJS[indexAnggota] = value);
                                        _bloc.checkValidQues();
                                        if (!value) {
                                          _bloc.tempKelasBPSJ[indexAnggota] = null;
                                        }
                                      },
                                    ),
                                    if (_bloc.anggotaBPJS[indexAnggota]) Column(
                                      children: [
                                        ...List.generate(_bloc.opsiKelasBPSJ.length, (indexRadio) => RadioListTile<String>(
                                          title: Text(_bloc.opsiKelasBPSJ[indexRadio]), 
                                          value: _bloc.opsiKelasBPSJ[indexRadio],
                                          groupValue: _bloc.tempKelasBPSJ[indexAnggota], 
                                          onChanged: (value) => setState(() {
                                            _bloc.tempKelasBPSJ[indexAnggota] = value;
                                          })
                                        ))
                                      ],
                                    )
                                  ],
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
                child: StatefulBuilder(
                  builder: (context, setState,) => Column( 
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
                        onSelected: (val) {
                          setState(() {
                            _bloc.tempAirMinum = val;
                          });
                          _bloc.checkValidQues();
                        },
                      ),
                      if (_bloc.tempAirMinum == 'Lainnya') const SizedBox(height: 12,),
                      if (_bloc.tempAirMinum == 'Lainnya') TextFieldWithTitle(
                        title: 'Lainnya',
                        onChanged: (val) => _bloc.tempAirMinum = val,
                      )  
                    ],
                  )
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: StatefulBuilder(
                  builder: (context, setState,) => Column( 
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('Dimana tempat senitasi?',
                        style:  TextStyle(fontSize: 16)
                      ),
                      const SizedBox(height: 12,),
                      DropDownOption(
                        title: 'Pilih Tempat Senitasi',
                        items: _bloc.opsiSenitasi,
                        value: _bloc.tempSenitasi,
                        onSelected: (val) {
                          setState(() {
                            _bloc.tempSenitasi = val;
                          });
                          _bloc.checkValidQues();
                        },
                      ),
                      if (_bloc.tempSenitasi == 'Lainnya') const SizedBox(height: 12,),
                      if (_bloc.tempSenitasi == 'Lainnya') TextFieldWithTitle(
                        title: 'Lainnya',
                        onChanged: (val) => _bloc.tempSenitasi = val,
                      )  
                    ],
                  )
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
                    StatefulBuilder(
                      builder: (context, setState) => Column(
                        children: [
                          DropDownOption(
                            title: 'Pilih Penyedia Telepon',
                            items: _bloc.opsiProvider,
                            value: _bloc.tempProvider,
                            onSelected: (val) {
                              setState(() {
                                _bloc.tempProvider = val;
                              });
                              _bloc.checkValidQues();
                            },
                          ),
                          if (_bloc.tempProvider == 'Lainnya') const SizedBox(height: 12,),
                          if (_bloc.tempProvider == 'Lainnya') TextFieldWithTitle(
                            title: 'Lainnya',
                            onChanged: (val) => _bloc.tempProvider = val,
                          ),
                        ],
                      )
                    ),
                    const SizedBox(height: 12,),
                    StatefulBuilder(
                      builder: (context, setState) => Column(
                        children: [
                          DropDownOption(
                            title: 'Pilih Status Sinyal',
                            items: _bloc.opsiStatusSinyal,
                            value: _bloc.tempStatusSinyal,
                            onSelected: (val) {
                              setState(() {
                                _bloc.tempStatusSinyal = val;
                              });
                              _bloc.checkValidQues();
                            },
                          ),
                          if (_bloc.tempStatusSinyal == 'Lainnya') const SizedBox(height: 12,),
                          if (_bloc.tempStatusSinyal == 'Lainnya') TextFieldWithTitle(
                            title: 'Lainnya',
                            onChanged: (val) => _bloc.tempStatusSinyal = val,
                          ),
                        ],
                      )
                    ),
                    const SizedBox(height: 12,),
                    const Text('Apakah keluarga miliki akses TV?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    StatefulBuilder(
                      builder: (context, setState) => Column(
                        children: [
                          ...List.generate(_bloc.opsiTV.length, (indexRadio) => CheckboxListTile(
                            dense: true,
                            title: Text(_bloc.opsiTV[indexRadio],
                              style: const TextStyle(fontSize: 15)
                            ),
                            value: _bloc.tempOpsiTV[indexRadio],
                            onChanged: (value) {
                              setState(() => _bloc.tempOpsiTV[indexRadio] = value);
                              _bloc.checkValidQues();
                            },
                          ),),
                          if (_bloc.tempOpsiTV[3]) const SizedBox(height: 12,),
                          if (_bloc.tempOpsiTV[3]) TextFieldWithTitle(
                            padding: const EdgeInsets.all(0),
                            title: 'Lainnya',
                            onChanged: (val) => _bloc.tempTVLainnya = val,
                          ),
                        ],
                      )
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
                              builder: (context, value, _) => value ? Column(
                                children: [
                                  DropDownOption(
                                    title: 'Pilih Penyedia Internet',
                                    items: _bloc.opsiProvider,
                                    value: _bloc.tempInternet,
                                    onSelected: (val) {
                                      setState(() {
                                        _bloc.tempInternet = val;
                                      });
                                      _bloc.checkValidQues();
                                    },
                                  ),
                                  if (_bloc.tempInternet == 'Lainnya') const SizedBox(height: 12,),
                                  if (_bloc.tempInternet == 'Lainnya') TextFieldWithTitle(
                                    title: 'Lainnya',
                                    onChanged: (val) => _bloc.tempInternet = val,
                                  ),
                                ],
                              ) : const SizedBox()
                            ),
                          ]
                        );
                      }
                    ),
                  ],
                )
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
                              if (!value) _bloc.namaRekeningAnggota[index] = null;
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
                    StatefulBuilder(
                      builder: (context, setState) => Column(
                        children: [
                          ...List.generate(_bloc.opsiAset.length, (indexRadio) => CheckboxListTile(
                            dense: true,
                            title: Text(_bloc.opsiAset[indexRadio],
                              style: const TextStyle(fontSize: 15)
                            ),
                            value: _bloc.tempOpsiAset[indexRadio],
                            onChanged: (value) {
                              setState(() => _bloc.tempOpsiAset[indexRadio] = value);
                              _bloc.checkValidQues();
                            },
                          ),),
                          if (_bloc.tempOpsiAset[5]) const SizedBox(height: 12,),
                          if (_bloc.tempOpsiAset[5]) TextFieldWithTitle(
                            padding: const EdgeInsets.all(0),
                            title: 'Lainnya',
                            onChanged: (val) => _bloc.tempAsetLainnya = val,
                          ),
                        ],
                      )
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
                    const Text('Apakah keluarga pernah mendapatkan bantuan?',
                      style: TextStyle(fontSize: 16)
                    ),
                    const SizedBox(height: 12,),
                    StatefulBuilder(
                      builder: (context, setState) => Column(
                        children: [
                          ...List.generate(_bloc.opsiBantuan.length, (indexRadio) => CheckboxListTile(
                            dense: true,
                            title: Text(_bloc.opsiBantuan[indexRadio],
                              style: const TextStyle(fontSize: 15)
                            ),
                            value: _bloc.tempOpsiBantuan[indexRadio],
                            onChanged: (value) {
                              setState(() => _bloc.tempOpsiBantuan[indexRadio] = value);
                              _bloc.checkValidQues();
                            },
                          ),),
                          if (_bloc.tempOpsiBantuan[2]) const SizedBox(height: 12,),
                          if (_bloc.tempOpsiBantuan[2]) TextFieldWithTitle(
                            padding: const EdgeInsets.all(0),
                            title: 'Lainnya',
                            onChanged: (val) => _bloc.tempBantuanLainnya = val,
                          ),
                        ],
                      )
                    ),
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
  final void Function(String) onSelected;

  const DropDownOption({this.title, this.value, this.items, this.onSelected});
  
  @override
  Widget build(BuildContext context) {
    String temp = value;
    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              hint: Text(title),
              value: temp,
              items: items.map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              )).toList(),
              onChanged: (val) => setState(() {
                temp = val;
                onSelected(val);
              }),
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}