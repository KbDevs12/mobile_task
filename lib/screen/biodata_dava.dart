import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BiodataDava extends StatelessWidget {
  const BiodataDava({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 260,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bgprofile.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 260,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.2),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 30),
                      CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage: AssetImage(
                            'assets/images/fotoprofile.jpeg',
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Dava Ananda',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '1123150164 • TI SE 2 P',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xffEEF2F7),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.9),
                      blurRadius: 16,
                      offset: const Offset(-6, -6),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(6, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _sectionCard(
                      title: 'Tentang Saya',
                      icon: Icons.info_outline,
                      child: Text(
                        'Mahasiswa Informatika yang tertarik pada pengembangan '
                        'aplikasi mobile menggunakan Flutter. '
                        'Aplikasi ini dibuat sebagai bagian dari tugas akademik.',
                      ),
                    ),
                    _sectionCard(
                      title: 'Data Diri',
                      icon: Icons.person_outline,
                      child: Column(
                        children: [
                          _simpleInfo('NIM', '1123150164'),
                          _simpleInfo('Kelas', 'TI SE 2 P'),
                          _simpleInfo('Keahlian', 'Flutter, UI/UX'),
                          _simpleInfo('Email', 'anandadava93@gmail.com'),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'GitHub',
                              style: TextStyle(color: Colors.grey),
                            ),
                            subtitle: Text(
                              'github.com/annddvaa',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                            trailing: const Icon(Icons.open_in_new, size: 18),
                            onTap: () =>
                                _launchUrl('https://github.com/annddvaa'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blueGrey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.logout, color: Colors.white),
                    label: Text('data'),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _sectionCard({
  required String title,
  required IconData icon,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _simpleInfo(String title, String value) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title, style: const TextStyle(color: Colors.grey)),
    subtitle: Text(
      value,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
