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
            onChanged: (val) => _bloc.nomorKK = val,
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
                      _bloc.satuAgama = value;
                    });
                  }
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              if (_bloc.satuAlamat) TextFieldWithTitle(
                title: 'Alamat',
                maxLines: 2,
                onChanged: (value) {},
              ),
              if (_bloc.satuAgama) TextFieldWithTitle(
                title: 'Agama',
                onChanged: (value) {},
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
            label: const Text('Tambah Anggota Keluarga'),
          ),
          const SizedBox(height: 12,),
          ValueListenableBuilder<List<Map<String, String>>>(
            valueListenable: _bloc.anggotaNotif, 
            builder: (context, value, child) => Column(
              children: List.generate(value.length, (index) => Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      ...List.generate(2, 
                        (indexLs) {
                          final String key = _bloc.anggota[index].keys
                            .toList()[indexLs];
                          final List<String> menu = ['Edit', 'Delete'];
                          return ListTile(
                            contentPadding: (indexLs == 0) ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
                            title: Text(_bloc.anggota[index][key], style: TextStyle(
                              fontSize: (indexLs == 0) ? 20 : 16,
                              fontWeight: (indexLs == 0) ? FontWeight.bold : FontWeight.normal
                            ),),
                            subtitle: (indexLs != 0) ? Text(key) : null,
                            dense: indexLs != 0,
                            trailing: (indexLs == 0) ? PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {}, 
                              itemBuilder: (context) => List.generate(menu.length,
                                (index) => PopupMenuItem<String>(child: Text(menu[index]))),
                            ) : null,
                            onTap: (indexLs == 0) ? () {} : null,
                          );
                        }
                      ),
                      TextFieldWithTitle(
                        title: 'Alamat',
                        maxLines: 2,
                        onChanged: (value) => _bloc.tempAlamat,
                      ),
                      const Text("Pekerjaan", style: TextStyle(fontSize:16.0),),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownSearch<String>(
                        hint: "Pilih Pekerjaan",
                        items: _bloc.pekerjaan,
                        showSearchBox: true,
                        onChanged: (value) => _bloc.tempPekerjaan,
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
                        onChanged: (value) => _bloc.tempPekerjaan,
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
                        title: 'Nomor HP',
                        hit: 'Opsional',
                        onChanged: (value) => _bloc.tempNomorTelp,
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
    floatingActionButton: FloatingActionButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => QuestionPage())),
      child: const Icon(Icons.arrow_forward),
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

  const TextFieldWithTitle({
    this.title, 
    this.keyboardType, 
    this.onChanged, 
    this.padding, 
    this.hit, 
    this.maxLines, 
    this.titleSize,
    this.textCapitalization
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

  const AnggotaFormDialog({this.bloc});

  @override
  Widget build(BuildContext context) {
    DateTime pickedDate;

    return AlertDialog(
      title: const Text('Tambah Anggota Keluarga'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithTitle(
              title: 'Nama',
              onChanged: (val) {
                bloc.tempNama = val;
                bloc.checkValidFormAnggota();
              },
            ),
            TextFieldWithTitle(
              keyboardType: TextInputType.number,
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
                    ? formatDate(bloc.tempTglLahir)
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
              bloc.addAnggota();
              Navigator.of(context).pop();
            } : null,
            child: const Text('OKE'),
          ),
        ),
      ]
    );
  }
}
