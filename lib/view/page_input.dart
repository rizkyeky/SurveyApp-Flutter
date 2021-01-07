part of 'page.dart';

class InputPage extends Page {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  final InputBloc bloc = InputBloc();

  @override
  Widget build(BuildContext context) {

    DateTime pickedDateLahir;
    DateTime pickedDatePasport;
    DateTime pickedDateKawin;
    DateTime pickedDateCerai;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Anggota'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
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
              )
            ),
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
                  pickedDateLahir = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(DateTime.now().year),
                  );
                  if (pickedDateLahir != null && pickedDateLahir != bloc.tempTglLahir) {
                    setState(() => bloc.tempTglLahir = pickedDateLahir);
                    bloc.checkValidFormAnggota();
                  }
                },
                child: Text(
                  pickedDateLahir != null
                    ? formatDate(pickedDateLahir)
                    : 'Pilih Tanggal Lahir',
                  style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12,),
            const Text("Agama", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Agama',
              items: bloc.opsi['agama'],
              value: bloc.tempAgama,
              onSelected: (value) => bloc.tempAgama = value,
            ),
            const SizedBox(height: 12,),
            const Text("Pekerjaan", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropdownInput(
              hitDrop: 'Pilih Pekerjaan',
              hitSearch: 'Cari Pekerjaan',
              items: bloc.opsi['pekerjaan'],
              onChanged: (value) => bloc.tempPekerjaan = value
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.phone,
              title: 'Nomor HP',
              onChanged: (value) => bloc.tempNomorTelp = value,
            ),
            const SizedBox(height: 12,),
            const Text("Lulusan", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropdownInput(
              hitDrop: 'Pilih Pendidikan Terakhir',
              hitSearch: 'Cari Pendidikan Terakhir',
              items: bloc.opsi['pendidikan1'],
              onChanged: (value) => bloc.tempLulusan = value
            ),
            const SizedBox(height: 12,),
            const Text("Pendidikan Sekarang", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropdownInput(
              hitDrop: 'Pilih Pendidikan Sedang Ditempuh',
              hitSearch: 'Cari Pendidikan Sedang Ditempuh',
              items: bloc.opsi['pendidikan2'],
              onChanged: (value) => bloc.tempPendidikan = value,
            ),
            const SizedBox(height: 12,),
            const Divider(),
            const SizedBox(height: 12,),
            const Text("Dusun", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Dusun',
              items: bloc.opsi['dusun'],
              value: bloc.tempLulusan,
              onSelected: (value) => bloc.tempDusun = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'RW',
              onChanged: (value) => bloc.tempRW = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'RT',
              onChanged: (value) => bloc.tempRT = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              maxLines: 2,
              textCapitalization: TextCapitalization.words,
              title: 'Alamat',
              hit: 'Tulis nama jalan atau nama perumahan',
              onChanged: (value) => bloc.tempAlamat = value,
            ),
            const SizedBox(height: 12,),
            const Divider(),
            const SizedBox(height: 12,),
            const Text("Status Perkawinan", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Status Perkawinan',
              items: bloc.opsi['statusperkawinan'],
              value: bloc.tempStatusPerkawinan,
              onSelected: (value) => bloc.tempStatusPerkawinan = value,
            ),
            const SizedBox(height: 12,),
            const Text("Status Dalam Keluarga", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Status Dalam Keluarga',
              items: bloc.opsi['statuskeluarga'],
              value: bloc.tempStatusKeluarga,
              onSelected: (value) => bloc.tempStatusKeluarga = value,
            ),
            const SizedBox(height: 12,),
            const Text("Status Kewarganegaraan", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Status Kewarganegaraan',
              items: bloc.opsi['kewarganegara'],
              value: bloc.tempKewarganegaraan,
              onSelected: (value) => bloc.tempKewarganegaraan = value,
            ),
            const SizedBox(height: 12,),
            const Divider(),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              title: 'Nama Ayah',
              onChanged: (value) => bloc.tempNamaAyah = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'NIK Ayah',
              onChanged: (value) => bloc.tempNIKAyah = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              title: 'Nama Ibu',
              onChanged: (value) => bloc.tempNamaIbu = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'NIK Ibu',
              onChanged: (value) => bloc.tempNIKIbu = value,
            ),
            const SizedBox(height: 12,),
            const Text("Golongan Darah", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Golongan Darah',
              items: bloc.opsi['darah'],
              value: bloc.tempGolDarah,
              onSelected: (value) => bloc.tempGolDarah = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              title: 'Akta Lahir',
              onChanged: (value) => bloc.tempAktaLahir = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'Nomor Dokumen Pasport',
              onChanged: (value) => bloc.tempNomorPasport = value,
            ),
            const SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, setState) => FlatButton(
                color: Colors.teal,
                onPressed: () async {
                  pickedDatePasport = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2020),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(DateTime.now().year),
                  );
                  if (pickedDatePasport != null && pickedDatePasport != bloc.tempTglPasport) {
                    setState(() => bloc.tempTglPasport = pickedDatePasport);
                    bloc.checkValidFormAnggota();
                  }
                },
                child: Text(
                  pickedDatePasport != null
                    ? formatDate(pickedDatePasport)
                    : 'Pilih Tanggal Pasport',
                  style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'Nomor Dokumen KITAS',
              onChanged: (value) => bloc.tempNomorKITAS = value,
            ),
            const SizedBox(height: 12,),
            const Divider(),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'Nomor Akta Perkawinan',
              onChanged: (value) => bloc.tempNomorAktaKawin = value,
            ),
            const SizedBox(height: 12,),
            TextFieldWithTitle(
              padding: const EdgeInsets.all(0),
              keyboardType: TextInputType.number,
              title: 'Nomor Akta Perceraian',
              onChanged: (value) => bloc.tempNomorAktaCerai = value,
            ),
            const SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, setState) => FlatButton(
                color: Colors.teal,
                onPressed: () async {
                  pickedDateKawin = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2020),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(DateTime.now().year),
                  );
                  if (pickedDateKawin != null && pickedDateKawin != bloc.tempTglAktaKawin) {
                    setState(() => bloc.tempTglAktaKawin = pickedDateKawin);
                    bloc.checkValidFormAnggota();
                  }
                },
                child: Text(
                  pickedDateKawin != null
                    ? formatDate(pickedDateKawin)
                    : 'Pilih Tanggal Akta Perkawinan',
                  style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, setState) => FlatButton(
                color: Colors.teal,
                onPressed: () async {
                  pickedDateCerai = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2020),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(DateTime.now().year),
                  );
                  if (pickedDateCerai != null && pickedDateCerai != bloc.tempTglAktaCerai) {
                    setState(() => bloc.tempTglAktaCerai = pickedDateCerai);
                    bloc.checkValidFormAnggota();
                  }
                },
                child: Text(
                  pickedDateCerai != null
                    ? formatDate(pickedDateCerai)
                    : 'Pilih Tanggal Akta Perceraian',
                  style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12,),
            const Text("Cacat", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Cacat',
              items: bloc.opsi['cacat'],
              value: bloc.tempCacat,
              onSelected: (value) => bloc.tempCacat = value,
            ),
            const SizedBox(height: 12,),
            const Text("Cara KB", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            DropDownOption(
              title: 'Pilih Cara KB',
              items: bloc.opsi['kb'],
              value: bloc.tempKB,
              onSelected: (value) => bloc.tempKB = value,
            ),
            const SizedBox(height: 12,),
            const Text("Hamil", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  RadioListTile<bool>(
                    groupValue: bloc.tempHamil,
                    title: const Text('Iya'),
                    value: true,
                    onChanged: (value) {
                      setState(() => bloc.tempHamil = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                  RadioListTile<bool>(
                    groupValue: bloc.tempHamil,
                    title: const Text('Tidak'),
                    value: false,
                    onChanged: (value) {
                      setState(() => bloc.tempHamil = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                ],
              )
            ),
            const SizedBox(height: 12,),
            const Text("KTP Elektronik", style: TextStyle(fontSize:16.0),),
            const SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  RadioListTile<bool>(
                    groupValue: bloc.tempKTPel,
                    title: const Text('Iya'),
                    value: true,
                    onChanged: (value) {
                      setState(() => bloc.tempKTPel = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                  RadioListTile<bool>(
                    groupValue: bloc.tempKTPel,
                    title: const Text('Tidak'),
                    value: false,
                    onChanged: (value) {
                      setState(() => bloc.tempKTPel = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                ],
              )
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: bloc.validInputNotif, 
        builder: (context, value, child) => FloatingActionButton(
          onPressed: value ? () {
            locator.call<HomeBloc>().addAnggota(bloc.dataAnggota());
            Navigator.pop(context);
          } : null,
          backgroundColor:  value ? Colors.teal : Colors.grey,
          tooltip: 'Tambah Anggota',
          child: child,
        ),
        child:  const Icon(Icons.add),
      )
    );
  }
}

class DropdownInput extends StatelessWidget {

  final String hitDrop;
  final String hitSearch;
  final List<String> items;
  final void Function(String) onChanged;

  const DropdownInput({
    this.hitDrop,
    this.hitSearch,
    this.items, 
    this.onChanged
  });

  @override
  Widget build(BuildContext context) => DropdownSearch<String>(
      hint: hitDrop ?? '',
      items: items,
      showSearchBox: true,
      onChanged: onChanged,
      searchBoxDecoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        hintText: hitSearch ?? '',
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      dropdownSearchDecoration: const InputDecoration(
        border: InputBorder.none,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
}

// class ButtonDate extends StatelessWidget {

//   final void Function() onChanged;
//   final void Function() onState;

//   @override
//   Widget build(BuildContext context) {

//     DateTime pickedDatePasport;

//     return StatefulBuilder(
//       builder: (context, setState) => FlatButton(
//         color: Colors.teal,
//         onPressed: () async {
//           pickedDatePasport = await showDatePicker(
//             context: context,
//             initialDate: DateTime(2020),
//             firstDate: DateTime(1900),
//             lastDate: DateTime(DateTime.now().year),
//           );
//           if (pickedDatePasport != null && pickedDatePasport != bloc.tempTglPasport) {
//             setState(() => bloc.tempTglPasport = pickedDatePasport);
//             bloc.checkValidFormAnggota();
//             onChanged();
//           }
//         },
//         child: Text(
//           pickedDatePasport != null
//             ? formatDate(pickedDatePasport)
//             : 'Pilih Tanggal Pasport',
//           style: const TextStyle(color: Colors.white)),
//       ),
//     );
//   }
// }