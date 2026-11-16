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
