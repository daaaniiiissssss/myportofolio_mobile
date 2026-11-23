import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambah data Education.
///
/// Field mengikuti model `Education` pada versi web:
/// school, degree, description, started_at, dan ended_at (opsional).
class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _schoolController = TextEditingController();
  final _degreeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startedAtController = TextEditingController();
  final _endedAtController = TextEditingController();

  DateTime? _startedAt;
  DateTime? _endedAt;

  /// Menjadi true setelah tombol Simpan pertama kali ditekan, supaya
  /// kolom tanggal divalidasi ulang otomatis setelah pengguna memperbaikinya.
  bool _hasSubmitted = false;

  static const int _maxLength = 255; // sama dengan max_length di model web
  static final RegExp _htmlTag = RegExp(r'<[^>]*>');

  static const List<String> _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _descriptionController.dispose();
    _startedAtController.dispose();
    _endedAtController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Helper
  // ---------------------------------------------------------------------------

  String _formatDate(DateTime date) =>
      '${date.day} ${_months[date.month - 1]} ${date.year}';

  /// Validasi teks wajib: tidak kosong/spasi saja, tidak hanya berisi tag HTML,
  /// dan tidak melebihi [maxLength] (jika diberikan).
  String? _validateRequiredText(
    String? value,
    String label, {
    int? maxLength,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label tidak boleh kosong!';
    }
    if (text.replaceAll(_htmlTag, '').trim().isEmpty) {
      return '$label tidak boleh hanya berisi tag HTML!';
    }
    if (maxLength != null && text.length > maxLength) {
      return '$label maksimal $maxLength karakter!';
    }
    return null;
  }

  String? _validateStartedAt(String? _) {
    if (_startedAt == null) {
      return 'Tanggal mulai wajib dipilih!';
    }
    return null;
  }

  /// Tanggal selesai opsional, tetapi jika diisi tidak boleh sebelum tanggal mulai.
  String? _validateEndedAt(String? _) {
    final start = _startedAt;
    final end = _endedAt;
    if (end != null && start != null && end.isBefore(start)) {
      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
    }
    return null;
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial =
        (isStart ? _startedAt : _endedAt) ?? _startedAt ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked == null || !mounted) return;

    setState(() {
      if (isStart) {
        _startedAt = picked;
        _startedAtController.text = _formatDate(picked);
      } else {
        _endedAt = picked;
        _endedAtController.text = _formatDate(picked);
      }
    });

    if (_hasSubmitted) {
      _formKey.currentState?.validate();
    }
  }

  void _clearEndedAt() {
    setState(() {
      _endedAt = null;
      _endedAtController.clear();
    });
    if (_hasSubmitted) {
      _formKey.currentState?.validate();
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _schoolController.clear();
      _degreeController.clear();
      _descriptionController.clear();
      _startedAtController.clear();
      _endedAtController.clear();
      _startedAt = null;
      _endedAt = null;
      _hasSubmitted = false;
    });
  }

  void _onSave() {
    setState(() => _hasSubmitted = true);

    if (!_formKey.currentState!.validate()) {
      return; // pesan error sudah muncul di kolom terkait
    }

    final ended = _endedAt;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Education berhasil disimpan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sekolah/Universitas: ${_schoolController.text.trim()}'),
                const SizedBox(height: 8),
                Text('Program: ${_degreeController.text.trim()}'),
                const SizedBox(height: 8),
                Text('Deskripsi: ${_descriptionController.text.trim()}'),
                const SizedBox(height: 8),
                Text('Mulai: ${_formatDate(_startedAt!)}'),
                const SizedBox(height: 8),
                Text(
                  'Selesai: ${ended == null ? 'Sekarang (masih berlangsung)' : _formatDate(ended)}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(dialogContext);
                _resetForm();
              },
            ),
          ],
        );
      },
    );
  }

  InputDecoration _decoration({
    required String label,
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Education Form'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      // Body menyusut saat keyboard muncul; SingleChildScrollView membuat
      // semua input dan tombol Simpan tetap bisa digulir dan dijangkau.
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // === School ===
                TextFormField(
                  controller: _schoolController,
                  textInputAction: TextInputAction.next,
                  decoration: _decoration(
                    label: 'Nama Sekolah/Universitas',
                    hint: 'Isi nama sekolah/universitasmu',
                  ),
                  validator: (value) => _validateRequiredText(
                    value,
                    'Nama sekolah/universitas',
                    maxLength: _maxLength,
                  ),
                ),
                const SizedBox(height: 16),

                // === Degree ===
                TextFormField(
                  controller: _degreeController,
                  textInputAction: TextInputAction.next,
                  decoration: _decoration(
                    label: 'Program Pendidikan',
                    hint: 'Contoh: S1 Ilmu Komputer',
                  ),
                  validator: (value) => _validateRequiredText(
                    value,
                    'Program pendidikan',
                    maxLength: _maxLength,
                  ),
                ),
                const SizedBox(height: 16),

                // === Description ===
                TextFormField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: _decoration(
                    label: 'Deskripsi',
                    hint: 'Ceritakan pendidikanmu',
                  ),
                  validator: (value) =>
                      _validateRequiredText(value, 'Deskripsi'),
                ),
                const SizedBox(height: 16),

                // === Started at (date picker) ===
                TextFormField(
                  controller: _startedAtController,
                  readOnly: true,
                  onTap: () => _pickDate(isStart: true),
                  decoration: _decoration(
                    label: 'Tanggal Mulai',
                    hint: 'Pilih tanggal mulai',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  validator: _validateStartedAt,
                ),
                const SizedBox(height: 16),

                // === Ended at (date picker, opsional) ===
                TextFormField(
                  controller: _endedAtController,
                  readOnly: true,
                  onTap: () => _pickDate(isStart: false),
                  decoration: _decoration(
                    label: 'Tanggal Selesai (opsional)',
                    hint: 'Kosongkan jika masih berlangsung',
                    suffixIcon: _endedAt == null
                        ? const Icon(Icons.calendar_today)
                        : IconButton(
                            tooltip: 'Hapus tanggal selesai',
                            icon: const Icon(Icons.clear),
                            onPressed: _clearEndedAt,
                          ),
                  ),
                  validator: _validateEndedAt,
                ),
                const SizedBox(height: 24),

                // === Tombol Simpan ===
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  onPressed: _onSave,
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}