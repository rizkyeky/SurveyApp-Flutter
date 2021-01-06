part of 'page.dart';

class HomePage extends Page {

  final Map<String, dynamic> dataAnggota;

  HomePage({this.dataAnggota});

  @override
  void dispose() {
    bloc.dispose();
  }

  @override
  void init() {
    bloc.init();
    
    if (dataAnggota != null) {

    }
  }

  final HomeBloc bloc = HomeBloc();
  
  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      title: const Text('Data Anggota Keluarga'),
      actions: [
        IconButton(
          icon: const Icon(Icons.article_outlined), 
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()))
        )
      ],
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
              bloc.nomorKK = val;
              bloc.validAnggotaNotif.value = bloc.checkValidKeluarga();
            },
          ),
          const SizedBox(height: 12,),
          RaisedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => InputPage()));
            },
            icon: const Icon(Icons.add),
            label: const Text('Tambah Anggota'),
          ),
          const SizedBox(height: 12,),
          ValueListenableBuilder<List<Map<String, String>>>(
            valueListenable: bloc.anggotaNotif, 
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
                          final String key = bloc.anggota[indexAnggota].keys
                            .toList()[indexLs];
                          final List<String> menu = ['Edit', 'Delete'];
                          return ListTile(
                            contentPadding: (indexLs == 0) ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
                            title: Text(bloc.anggota[indexAnggota][key], style: TextStyle(
                              fontSize: (indexLs == 0) ? 18 : 16,
                              fontWeight: (indexLs == 0) ? FontWeight.bold : FontWeight.normal
                            ),),
                            subtitle: (indexLs != 0) ? Text(key) : null,
                            dense: indexLs != 0,
                            trailing: (indexLs == 0) ? PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'Edit') {
                                  bloc.editAnggota(indexAnggota);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AnggotaFormDialog(bloc: bloc, editIndex: indexAnggota,),
                                  );
                                } else if (value == 'Delete') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Anggota'),
                                      actions: [
                                        FlatButton(
                                          onPressed: () {
                                            bloc.deleteAnggota(indexAnggota);
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
                        valueListenable: bloc.satuAlamatNotif, 
                        builder: (context, value, _) => !value ? TextFieldWithTitle(
                          title: 'Alamat',
                          maxLines: 2,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => bloc.tempAlamat,
                        ) : const SizedBox()
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: bloc.satuAgamaNotif, 
                        builder: (context, value, _) => !value ? TextFieldWithTitle(
                          title: 'Agama',
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) => bloc.tempAgama,
                        ) : const SizedBox()
                      ),
                      const Text("Pekerjaan", style: TextStyle(fontSize:16.0),),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownSearch<String>(
                        hint: "Pilih Pekerjaan",
                        items: bloc.pekerjaan,
                        showSearchBox: true,
                        selectedItem: 'Belum/ Tidak Bekerja',
                        onChanged: (value) => bloc.tempPekerjaan[indexAnggota] = value,
                        searchBoxDecoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          hintText: 'Cari Pekerjaan',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        dropdownSearchDecoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      const SizedBox(height: 12,),
                      const Text("Pendidikan", style: TextStyle(fontSize:16.0),),
                      const SizedBox(height: 12,),
                      DropDownOption(
                        title: 'Pilih Pendidikan',
                        items: bloc.pendidikan,
                        value: bloc.tempLulusan[indexAnggota],
                        onSelected: (value) => bloc.tempLulusan[indexAnggota] = value,
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
                          bloc.tempNomorTelp[indexAnggota] = value;
                          // print(bloc.tempNomorTelp);
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
      valueListenable: bloc.validAnggotaNotif,
      builder: (context, value, _) => FloatingActionButton(
        backgroundColor: value ? Colors.teal : Colors.grey,
        onPressed: value ? () async {
          await bloc.checkNoKK(bloc.nomorKK).then((value) {
            if (!value) {
              bloc.saveDataKeluarga();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => QuestionPage(bloc.dataKeluarga)));
            } else {
              showNetworkFlash(
                context,
                text: 'Nomor KK sudah terdaftar',
                color: Colors.white,
                textColor: Colors.black
              );
            }
          });
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
              border: InputBorder.none,
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
                    initialDate: DateTime(2000),
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
