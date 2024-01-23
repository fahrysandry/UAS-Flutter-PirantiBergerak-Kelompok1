import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../bloc/logout/logout_bloc.dart';
import '../../common/components/custom_scaffold.dart';
import '../../common/components/row_text.dart';
import '../../common/constants/colors.dart';
import '../../common/constants/icons.dart';
import '../../data/datasources/auth_local_datasorce.dart';
import '../../data/models/response/auth_response_model.dart';
import '../auth/auth_page.dart';
import '../mahasiswa/widgets/get_initials.dart';

class ProfilePage extends StatefulWidget {
  final String role;

  const ProfilePage({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User?> _userFuture;

  @override
  void initState() {
    _userFuture = AuthLocalDatasource().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 60.0),
          FutureBuilder<User?>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const SizedBox(); // Handle jika data tidak tersedia
              } else {
                User user = snapshot.data!;
                return buildUserProfile(user);
              }
            },
          ),
          const SizedBox(height: 30.0),
          Center(
            child: BlocProvider(
              create: (context) => LogoutBloc(),
              child: BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      loaded: () {
                        AuthLocalDatasource().removeAuthData();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const AuthPage();
                        }));
                      },
                      error: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logout Error')));
                      });
                },
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return ElevatedButton(
                      onPressed: () {
                        context
                            .read<LogoutBloc>()
                            .add(const LogoutEvent.logout());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorName.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Logout'),
                      ),
                    );
                  }, loaded: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: ColorName.white,
              boxShadow: [
                BoxShadow(
                  color: ColorName.black.withOpacity(0.25),
                  offset: const Offset(0, 3),
                  spreadRadius: 0,
                  blurRadius: 4.0,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowText(
                  icon: const ImageIcon(IconName.profileLine),
                  label: 'Edit Informasi Profil',
                  value: '',
                  valueColor: ColorName.primary,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const EditProfilePage(),
                    //   ),
                    // );
                  },
                ),
                const SizedBox(height: 12.0),
                RowText(
                  icon: const Icon(Icons.notifications),
                  label: 'Notifikasi',
                  value: 'ON',
                  valueColor: ColorName.primary,
                  onTap: () {},
                ),
                const SizedBox(height: 12.0),
                RowText(
                  icon: const Icon(Icons.translate),
                  label: 'Bahasa',
                  value: 'Indonesia',
                  valueColor: ColorName.primary,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: ColorName.white,
              boxShadow: [
                BoxShadow(
                  color: ColorName.black.withOpacity(0.25),
                  offset: const Offset(0, 3),
                  spreadRadius: 0,
                  blurRadius: 4.0,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserProfile(User user) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: ColorName.white,
        boxShadow: [
          BoxShadow(
            color: ColorName.black.withOpacity(0.25),
            offset: const Offset(0, 3),
            spreadRadius: 0,
            blurRadius: 4.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 22.0),
          // ... widget lainnya
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: Container(
                  width: 72.0,
                  height: 72.0,
                  color: Colors.blue, // Warna latar belakang avatar
                  alignment: Alignment.center,
                  child: Text(
                    getInitials(user.name),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      border: Border.all(color: ColorName.primary),
                    ),
                    child: Text(
                      user.roles,
                      style: const TextStyle(
                        color: ColorName.primary,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorName.primary,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Dash(
            length: MediaQuery.of(context).size.width - 60.0,
            dashColor: const Color(0xffD5DFE7),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
