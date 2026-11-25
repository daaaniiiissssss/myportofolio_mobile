import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

/// Kartu tombol aksi dengan warna sesuai [ItemHomepage.color].
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  Future<void> _onTap(BuildContext context) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    final auth = context.read<AuthState>();

    switch (item.name) {
      case 'Lihat Experience':
        await navigator.push(
          MaterialPageRoute<void>(
            builder: (_) => const ExperienceListScreen(),
          ),
        );
      case 'Tambah Experience':
        if (await ensureLoggedIn(context)) {
          await navigator.push(
            MaterialPageRoute<void>(
              builder: (_) => const ExperienceFormPage(),
            ),
          );
        }
      case 'Tambah Education':
        await navigator.push(
          MaterialPageRoute<void>(builder: (_) => const EducationFormPage()),
        );
      case 'Login':
        if (await ensureLoggedIn(context)) {
          messenger.showSnackBar(
            const SnackBar(content: Text('Login berhasil!')),
          );
        }
      case 'Logout':
        if (auth.isLoggedIn) {
          await auth.logout();
          messenger.showSnackBar(
            const SnackBar(content: Text('Kamu telah logout.')),
          );
        }
      default:
        messenger.showSnackBar(
          SnackBar(content: Text('Kamu telah menekan tombol ${item.name}!')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _onTap(context),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 40.0),
                const SizedBox(height: 8.0),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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