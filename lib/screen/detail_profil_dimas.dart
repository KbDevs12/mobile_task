import 'package:flutter/material.dart';

class DetailProfilDimas extends StatelessWidget {
  const DetailProfilDimas({super.key});

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
                    child:Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/images/profile_background.png',
                        repeat: ImageRepeat.repeat,
                        errorBuilder: (context, error, stackTrace) {
                          return Container();
                        } ,
                      ),
                    )
                  )
                  ],
                
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
