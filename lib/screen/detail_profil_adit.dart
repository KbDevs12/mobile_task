import 'package:flutter/material.dart';

class DetailProfilAdit extends StatelessWidget {
  const DetailProfilAdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/images/image3.png'),
                  child: Icon(Icons.person, size: 60, color: Colors.blue),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Aditya Putra Perdana',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Lead Developer & Project Manager',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Responsible for application UI consistency, '
                          'user experience, and design implementation '
                          'using Flutter best practices.',
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(Icons.palette),
                          title: Text('Speciality'),
                          subtitle: Text('Backend, API'),
                        ),
                        ListTile(
                          leading: Icon(Icons.code),
                          title: Text('Tech Stack'),
                          subtitle: Text('Flutter, Dart, Firebase'),
                        ),
                      ],
                    ),
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
