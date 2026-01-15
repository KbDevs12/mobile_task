import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class DetailProfilDimas extends StatelessWidget {
  const DetailProfilDimas({super.key});

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Detail Profil Dimas'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.indigo.shade700,
                      Colors.blue.shade500,
                      Colors.cyan.shade400,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: Image.asset(
                          'assets/images/profile_background.png',
                          repeat: ImageRepeat.repeat,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showMoreOptions(context);
                },
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                // Profile Picture Section dengan Badge
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.3),
                                  blurRadius: 25,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.indigo.shade100,
                              child: const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Dimas Prasetyo',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.indigo.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.code,
                              size: 16,
                              color: Colors.indigo.shade700,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.indigo.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Passionate Flutter developer with 3 years of experience in building beautiful and performant mobile applications. Skilled in Dart, UI/UX design, and state management solutions.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade50, Colors.blue.shade50],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('24', 'Projects', Icons.folder_special),
                        _buildVerticalDivider(),
                        _buildStatItem('1.5K', 'Followers', Icons.people),
                        _buildVerticalDivider(),
                        _buildStatItem('342', 'Following', Icons.person_add),
                      ],
                    ),
                  ),
                ),
                // Personal Information Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildInfoCard(
                        icon: Icons.email_rounded,
                        title: 'Email',
                        value: '1123150165@global.ac.id',
                        color: Colors.red,
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),

                      _buildInfoCard(
                        icon: Icons.phone_android,
                        title: 'Phone',
                        value: '+62 812-3456-7890',
                        color: Colors.green,
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),

                      _buildInfoCard(
                        icon: Icons.cake_rounded,
                        title: 'Birthday',
                        value: '15 Maret 1999 (25 tahun)',
                        color: Colors.purple,
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),

                      _buildInfoCard(
                        icon: Icons.location_on_rounded,
                        title: 'Location',
                        value: 'Jakarta, Indonesia',
                        color: Colors.orange,
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),

                      _buildInfoCard(
                        icon: Icons.work_rounded,
                        title: 'Company',
                        value: 'Tech Solutions Inc.',
                        color: Colors.blue,
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),

                      _buildInfoCard(
                        icon: Icons.school_rounded,
                        title: 'Education',
                        value: 'S1 Teknik Informatika',
                        color: Colors.teal,
                        onTap: () {},
                      ),

                      const SizedBox(height: 30),

                      // Skills Section
                      const Text(
                        'Skills & Expertise',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildSkillChip('Flutter', Colors.blue),
                          _buildSkillChip('Dart', Colors.cyan),
                          _buildSkillChip('Firebase', Colors.orange),
                          _buildSkillChip('UI/UX Design', Colors.purple),
                          _buildSkillChip('REST API', Colors.green),
                          _buildSkillChip('Git', Colors.red),
                          _buildSkillChip('SQL', Colors.indigo),
                          _buildSkillChip('Mobile Dev', Colors.teal),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Social Media Section
                      const Text(
                        'Connect With Me',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialButton(
                            icon: Icons.chat_bubble,
                            label: 'WhatsApp',
                            color: Colors.green,
                            onTap: () {},
                          ),
                          _buildSocialButton(
                            icon: Icons.code,
                            label: 'GitHub',
                            color: Colors.black87,
                            onTap: () {},
                          ),
                          _buildSocialButton(
                            icon: Icons.work,
                            label: 'LinkedIn',
                            color: Colors.blue,
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _showEditDialog(context);
                              },
                              icon: const Icon(Icons.edit_rounded),
                              label: const Text('Edit Profile'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _showShareDialog(context);
                              },
                              icon: const Icon(Icons.share_rounded),
                              label: const Text('Share'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.indigo,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                side: const BorderSide(
                                  color: Colors.indigo,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Settings and Logout
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.settings_rounded),
                          label: const Text('Settings'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text('Logout'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: const BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigo, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 60, width: 1, color: Colors.grey.shade300);
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Profile'),
        content: const Text('Fitur edit profile akan segera hadir!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Share Profile'),
        content: const Text('Pilih platform untuk membagikan profile Anda'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logout(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Show QR Code'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download Profile'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report Issue'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
