# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Tugas 7

1.
Widget tree itu susunan semua widget di aplikasi Flutter yang bentuknya seperti pohon. Di Flutter semua tampilan adalah widget, dan satu widget bisa membungkus widget lain. Hubungan parent dan child artinya widget yang membungkus disebut parent, sedangkan yang ada di dalamnya disebut child. Parent yang mengatur posisi dan batas ukuran child, lalu child menentukan ukurannya sendiri di dalam batas itu. Di proyek saya urutannya kira-kira MaterialApp, lalu MyHomePage, Scaffold, Padding, Column, dan di dalamnya ada Row berisi InfoCard serta GridView berisi ItemCard. Kalau parent berubah, child-nya ikut dibangun ulang, dan data biasanya dikirim dari parent ke child lewat konstruktor.

2.
Widget yang saya pakai di proyek ini:
- MaterialApp: root aplikasi yang mengatur tema, halaman awal, dan navigasi.
- Scaffold: kerangka dasar halaman, isinya AppBar dan body. SnackBar juga muncul lewat Scaffold.
- AppBar: bar judul di bagian atas halaman.
- Text: menampilkan tulisan.
- Padding: memberi jarak di sekeliling widget.
- Column: menyusun widget ke bawah.
- Row: menyusun widget ke samping.
- Expanded: membuat widget mengisi sisa ruang yang ada.
- SizedBox: memberi jarak kosong antar widget.
- Center: menaruh widget di tengah.
- GridView.count: menampilkan tombol dalam bentuk grid dengan jumlah kolom tetap.
- Card: kartu dengan sedikit bayangan, saya pakai untuk InfoCard.
- Container: kotak pembungkus yang bisa diatur ukuran dan jaraknya.
- Material: permukaan yang bisa diberi warna dan sudut melengkung, saya pakai untuk ItemCard.
- InkWell: membuat area bisa ditekan dan memberi efek ripple.
- Icon: menampilkan ikon.
- SnackBar: pesan singkat yang muncul di bawah layar.
- ScaffoldMessenger: yang mengatur kapan SnackBar ditampilkan atau disembunyikan.
- MyApp, MyHomePage, InfoCard, dan ItemCard: widget buatan sendiri.

3.
MaterialApp adalah widget yang membungkus seluruh aplikasi dengan gaya Material Design. Dia mengurus tema, halaman awal (home), judul aplikasi, dan juga navigasi antar halaman. Banyak widget lain seperti Scaffold, AppBar, dan SnackBar baru bisa jalan dengan benar kalau ada MaterialApp di atasnya. Makanya MaterialApp hampir selalu dipakai sebagai root widget.

4.
StatelessWidget itu widget yang tampilannya tidak berubah setelah dibuat, karena hanya bergantung pada data yang dikirim lewat konstruktor. StatefulWidget punya State yang bisa berubah, dan tampilannya diperbarui lewat setState. Jadi StatelessWidget cocok untuk tampilan yang statis, seperti MyHomePage, InfoCard, dan ItemCard di tugas ini. StatefulWidget dipakai kalau tampilan perlu berubah karena interaksi pengguna atau perubahan data, misalnya counter, isi form, checkbox, atau animasi.

5.
BuildContext adalah penunjuk lokasi sebuah widget di dalam widget tree. Lewat context, sebuah widget bisa mengambil informasi dari widget di atasnya, misalnya tema, ukuran layar, atau Scaffold terdekat. Di dalam method build, context dipakai untuk hal seperti Theme.of(context), MediaQuery.of(context), dan ScaffoldMessenger.of(context). Di proyek saya, context dipakai untuk menampilkan SnackBar saat tombol ditekan dan untuk mengambil lebar layar supaya ukuran InfoCard menyesuaikan.

6.
Hot reload memasukkan perubahan kode ke aplikasi yang sedang jalan tanpa memulai ulang aplikasinya, jadi state-nya tetap tersimpan. Hot restart memuat ulang semua kode dari awal (main dijalankan lagi) sehingga state kembali ke kondisi awal, tapi masih lebih cepat daripada menjalankan ulang aplikasi dari nol. Hot reload tidak cukup kalau kita mengubah main, nilai variabel global atau static, isi initState, enum, atau mengganti StatelessWidget menjadi StatefulWidget, jadi perlu hot restart. Full restart (stop lalu run lagi) perlu dilakukan kalau kita mengubah kode native Android atau iOS, menambah dependency di pubspec.yaml, menambah aset atau font baru, atau mengubah konfigurasi platform.

Penggunaan AI:
Untuk tugas ini, saya menggunakan Claude untuk memastikan saya berada di jalan yang tepat dan tidak keliru saat menggunakan Flutter. Karna sejujurnya saya masih kagok menggunakan Flutter.

### Tugas 8

1.
Navigator.push() menambahkan route baru di atas stack, jadi halaman sebelumnya masih tersimpan dan pengguna bisa kembali ke sana. Navigator.pushReplacement() mengganti route yang sedang tampil dengan route baru, jadi route lama dibuang dari stack dan tidak bisa dikembalikan dengan tombol back. Navigator.pop() membuang route paling atas sehingga pengguna kembali ke route di bawahnya, dan metode ini juga dipakai untuk menutup dialog. Untuk membuka formulir dari kartu aksi saya memakai Navigator.push(), karena formulir adalah halaman tambahan di atas halaman utama dan pengguna perlu bisa kembali dengan tombol back. Opsi Home di drawer memakai Navigator.pushReplacement() dengan MaterialPageRoute ke MyHomePage, sehingga halaman formulir yang sedang terbuka diganti dengan halaman utama.

2.
Scaffold menjadi kerangka tiap halaman dengan slot appBar, drawer, dan body, sehingga semua halaman punya struktur yang sama. AppBar menampilkan judul dan tombol hamburger untuk membuka Drawer. Drawer saya buat sebagai satu widget LeftDrawer di folder lib/widgets yang dipakai di halaman utama, form proyek, dan form education, jadi menunya selalu sama di semua halaman. Contoh penggunaan warna tema: warna indigo dipakai sebagai warna AppBar di form proyek dan form education, sebagai warna DrawerHeader di drawer, dan menjadi seed ColorScheme di MaterialApp yang mewarnai AppBar halaman utama.

3.
Formulir saya susun dengan Column yang berisi input berurutan, dibungkus Padding dan SingleChildScrollView di dalam SafeArea. Susunan vertikal dipilih karena mudah dibaca dan cocok untuk layar ponsel yang sempit. SizedBox dipakai untuk memberi jarak antar input supaya tidak menempel dan mudah disentuh. SingleChildScrollView membuat isi formulir bisa digulir ketika ruang layar terbatas, misalnya saat keyboard tampil, sehingga semua kolom dan tombol Simpan tetap bisa dijangkau. Pengaturan keyboardDismissBehavior membuat keyboard tertutup saat layar digulir.

4.
GlobalKey<FormState> adalah kunci yang menghubungkan tombol Simpan dengan state Form, sehingga saya bisa memanggil _formKey.currentState!.validate() dari luar field. Validator adalah fungsi di tiap field yang mengembalikan pesan error (String) jika nilainya salah, atau null jika nilainya benar. Fungsi validate() menjalankan semua validator sekaligus, menampilkan pesan error pada kolom yang bermasalah, dan mengembalikan true hanya jika semuanya lolos, sehingga dialog ringkasan baru muncul setelah itu. Contoh nilai yang ditolak adalah nama sekolah yang hanya berisi spasi, atau tanggal selesai yang lebih awal dari tanggal mulai. Memilih jenis input atau papan ketik saja belum cukup karena papan ketik hanya mengatur tampilan input, bukan isi yang dimasukkan. Pengguna tetap bisa mengirim spasi saja, menempel teks yang terlalu panjang, atau memasukkan tag HTML. Aturan seperti itu harus diperiksa oleh validator.

Penggunaan AI:
Alat yang saya pakai adalah Claude. Memastikan apa yang saya ubah benar dan tidak melenceng dari yang seharusnya.
