part of 'page.dart';

class HomePage extends Page<HomeBloc> {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  Widget build(BuildContext context) {
    String jenisKel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithTitle(
              title: 'Nomor KK',
              keyboardType: TextInputType.number,
            ),
            // TextFieldWithTitle(
            //   title: 'Nama Keluarga',
            // ),
            RaisedButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AnggotaFormDialog(bloc: _bloc),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Tambah Anggota Keluarga'),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldWithTitle extends StatelessWidget {
  final String title;
  final String hit;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final EdgeInsetsGeometry padding;

  const TextFieldWithTitle(
      {this.title, this.keyboardType, this.onChanged, this.padding, this.hit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 12,
          ),
          TextField(
            onChanged: onChanged ?? (value) {},
            keyboardType: keyboardType ?? TextInputType.name,
            decoration: const InputDecoration(
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
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
                title: 'NIK',
                onChanged: (val) => bloc.tempNik = val,
              ),
              TextFieldWithTitle(
                title: 'Alamat (RT & RW)',
                onChanged: (val) => bloc.tempAlamat = val,
              ),
              StatefulBuilder(
                builder: (context, setState) => Column(
                  children: [
                    RadioListTile<String>(
                      groupValue: bloc.tempJenisKel,
                      title: const Text('Laki-laki'),
                      value: 'Laki-laki',
                      onChanged: (value) =>
                          setState(() => bloc.tempJenisKel = value),
                    ),
                    RadioListTile<String>(
                      groupValue: bloc.tempJenisKel,
                      title: const Text('Perempuan'),
                      value: 'Perempuan',
                      onChanged: (value) =>
                          setState(() => bloc.tempJenisKel = value),
                    ),
                  ],
                )),
              TextFieldWithTitle(
                padding: const EdgeInsets.symmetric(vertical: 12),
                title: 'Tempat Lahir',
                onChanged: (val) => bloc.tempTempatLahir = val,
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
                    if (pickedDate != null &&
                        pickedDate != bloc.tempTglLahir) {
                      setState(() => bloc.tempTglLahir = pickedDate);
                    }
                  },
                  child: Text(
                    pickedDate != null
                      ? bloc.tempTglLahir
                        .toLocal()
                        .toString()
                        .split(' ')[0]
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
          FlatButton(
            color: Colors.teal,
            onPressed: () {
              bloc.addAnggota();
              Navigator.of(context).pop();
            },
            child: const Text('OKE'),
          ),
        ]
      );
  }
}
