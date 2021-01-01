part of 'page.dart';

class HomePage extends Page {

  @override
  void dispose() {
    _bloc.dispose();
  }

  @override
  void init() {
    _bloc.init();
  }

  final HomeBloc _bloc = locator.get<HomeBloc>();
  
  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      title: const Text('Data Anggota Keluarga'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWithTitle(
            title: 'Nomor KK',
            keyboardType: TextInputType.number,
            onChanged: (val) {
              _bloc.nomorKK = val;
              _bloc.validAnggotaNotif.value = _bloc.checkValidKeluarga();
            },
          ),
          StatefulBuilder(builder: (context, setState) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: const Text('Satu Alamat'),
                value: _bloc.satuAlamat,
                onChanged: (value) {
                  if (_bloc.satuAlamat != value) {
                    setState(() {
                      _bloc.satuAlamatNotif.value = value;
                      _bloc.satuAlamat = value;
                    });
                  }
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text('Satu Agama'),
                value: _bloc.satuAgama,
                onChanged: (value) {
                  if (_bloc.satuAgama != value) {
                    setState(() {
                      _bloc.satuAgamaNotif.value = value;
                      _bloc.satuAgama = value;
                    });
                  }
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              if (_bloc.satuAlamat) TextFieldWithTitle(
                title: 'Alamat',
                maxLines: 2,
                controller: TextEditingController(text: _bloc.tempAlamat),
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => _bloc.tempAlamat = value,
              ),
              if (_bloc.satuAgama) TextFieldWithTitle(
                title: 'Agama',
                controller: TextEditingController(text: _bloc.tempAgama),
                onChanged: (value) => _bloc.tempAgama = value,
              ),
            ],
          )),
          const SizedBox(height: 12,),
          RaisedButton.icon(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AnggotaFormDialog(bloc: _bloc),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Anggota'),
          ),
          const SizedBox(height: 12,),
          ValueListenableBuilder<List<Map<String, String>>>(
            valueListenable: _bloc.anggotaNotif, 
            builder: (context, value, child) => Column(
              children: List.generate(value.length, (indexAnggota) => Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      ...List.generate(2, 
                        (indexLs) {
                          final String key = _bloc.anggota[indexAnggota].keys
                            .toList()[indexLs];
                          final List<String> menu = ['Edit', 'Delete'];
                          return ListTile(
                            contentPadding: (indexLs == 0) ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
                            title: Text(_bloc.anggota[indexAnggota][key], style: TextStyle(
                              fontSize: (indexLs == 0) ? 18 : 16,
                              fontWeight: (indexLs == 0) ? FontWeight.bold : FontWeight.normal
                            ),),
                            subtitle: (indexLs != 0) ? Text(key) : null,
                            dense: indexLs != 0,
                            trailing: (indexLs == 0) ? PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'Edit') {
                                  _bloc.editAnggota(indexAnggota);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AnggotaFormDialog(bloc: _bloc, editIndex: indexAnggota,),
                                  );
                                } else if (value == 'Delete') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Anggota'),
                                      actions: [
                                        FlatButton(
                                          onPressed: () {
                                            _bloc.deleteAnggota(indexAnggota);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('DELETE')
                                        ),
                                        FlatButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('CANCEL')
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }, 
                              itemBuilder: (context) => List.generate(menu.length,
                                (index) => PopupMenuItem<String>(
                                  value: menu[index], 
                                  child: Text(menu[index]), 
                                )
                              ),
                            ) : null,
                            onTap: (indexLs == 0) ? () {} : null,
                          );
                        }
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _bloc.satuAlamatNotif, 
                        builder: (context, value, _) => !value ? TextFieldWithTitle(
                          title: 'Alamat',
                          maxLines: 2,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => _bloc.tempAlamat,
                        ) : const SizedBox()
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _bloc.satuAgamaNotif, 
                        builder: (context, value, _) => !value ? TextFieldWithTitle(
                          title: 'Agama',
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) => _bloc.tempAgama,
                        ) : const SizedBox()
                      ),
                      const Text("Pekerjaan", style: TextStyle(fontSize:16.0),),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownSearch<String>(
                        hint: "Pilih Pekerjaan",
                        items: _bloc.pekerjaan,
                        showSearchBox: true,
                        selectedItem: 'Belum/ Tidak Bekerja',
                        onChanged: (value) => _bloc.tempPekerjaan[indexAnggota] = value,
                        searchBoxDecoration: const InputDecoration(
                          filled: true,
                          hintText: 'Cari Pekerjaan',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        dropdownSearchDecoration: const InputDecoration(
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Pendidikan", style: TextStyle(fontSize:16.0),),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownSearch<String>(
                        hint: "Pilih Pendidikan",
                        items: _bloc.pendidikan,
                        mode: Mode.MENU,
                        selectedItem: 'SD',
                        onChanged: (value) => _bloc.tempLulusan[indexAnggota] = value,
                        searchBoxDecoration: const InputDecoration(
                          filled: true,
                          hintText: 'Cari Pendidikan',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        dropdownSearchDecoration: const InputDecoration(
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFieldWithTitle(
                        padding: const EdgeInsets.all(0),
                        keyboardType: TextInputType.phone,
                        title: 'Nomor HP',
                        hit: 'Jika ada',
                        onChanged: (value) {
                          _bloc.tempNomorTelp[indexAnggota] = value;
                          // print(_bloc.tempNomorTelp);
                        },
                      ),
                    ]
                  ),
                )
              ),)
            )
          ),
        ],
      ),
    ),
    floatingActionButton: ValueListenableBuilder<bool>(
      valueListenable: _bloc.validAnggotaNotif,
      builder: (context, value, _) => FloatingActionButton(
        backgroundColor: value ? Colors.teal : Colors.grey,
        onPressed: value ? () {
          _bloc.saveDataKeluarga();
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => QuestionPage(_bloc.dataKeluarga)));
          // print(_bloc.anggota);
        } : null,
        child: const Icon(Icons.arrow_forward),
      ),
    ),
  );
}

class TextFieldWithTitle extends StatelessWidget {
  final String title;
  final double titleSize;
  final String hit;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;

  const TextFieldWithTitle({
    this.title, 
    this.keyboardType, 
    this.onChanged, 
    this.padding, 
    this.hit, 
    this.maxLines, 
    this.titleSize,
    this.textCapitalization,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: titleSize ?? 16.0),),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: controller,
            textCapitalization: textCapitalization ?? TextCapitalization.sentences,
            onChanged: onChanged ?? (value) {},
            keyboardType: keyboardType ?? TextInputType.name,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              filled: true,
              hintText: hit ,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ],
      ),
    );
  }
}

class AnggotaFormDialog extends StatelessWidget {
  final HomeBloc bloc;
  final int editIndex;

  const AnggotaFormDialog({this.bloc, this.editIndex});

  @override
  Widget build(BuildContext context) {
    DateTime pickedDate = bloc.tempTglLahir;

    return AlertDialog(
      title: const Text('Tambah Anggota Keluarga'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithTitle(
              title: 'Nama',
              controller: TextEditingController(text: bloc.tempNama),
              textCapitalization: TextCapitalization.words,
              onChanged: (val) {
                bloc.tempNama = val;
                bloc.checkValidFormAnggota();
              },
            ),
            TextFieldWithTitle(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: bloc.tempNik),
              title: 'NIK',
              onChanged: (val) {
                bloc.checkValidFormAnggota();
                bloc.tempNik = val;
              },
            ),
            StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  RadioListTile<String>(
                    groupValue: bloc.tempJenisKel,
                    title: const Text('Laki-laki'),
                    value: 'Laki-laki',
                    onChanged: (value) {
                      setState(() => bloc.tempJenisKel = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                  RadioListTile<String>(
                    groupValue: bloc.tempJenisKel,
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    onChanged: (value) {
                      setState(() => bloc.tempJenisKel = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                ],
              )),
            TextFieldWithTitle(
              padding: const EdgeInsets.symmetric(vertical: 12),
              title: 'Tempat Lahir',
              controller: TextEditingController(text: bloc.tempTempatLahir),
              textCapitalization: TextCapitalization.words,
              onChanged: (val) {
                bloc.tempTempatLahir = val;
                bloc.checkValidFormAnggota();
              },
            ),
            StatefulBuilder(
              builder: (context, setState) => FlatButton(
                color: Colors.teal,
                onPressed: () async {
                  pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2021),
                  );
                  if (pickedDate != null && pickedDate != bloc.tempTglLahir) {
                    setState(() => bloc.tempTglLahir = pickedDate);
                    bloc.checkValidFormAnggota();
                  }
                },
                child: Text(
                  pickedDate != null
                    ? formatDate(pickedDate)
                    : 'Pilih Tanggal Lahir',
                  style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: bloc.validFormNotif,
          builder: (context, value, _) => FlatButton(
            color: Colors.teal,
            onPressed: value ? () {
              (editIndex != null) ? bloc.modifAnggota(editIndex) : bloc.addAnggota();
              Navigator.of(context).pop();
            } : null,
            child: const Text('OKE'),
          ),
        ),
      ]
    );
  }
}
