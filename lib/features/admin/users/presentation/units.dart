import 'package:command_care/features/auth/data/User.dart';
import 'package:flutter/material.dart';
import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/constants/app_images.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  // Default Users Fallback
  final List<UserData> defaultDoctors = [
    UserData(id: 'd1', userType: 'doctor', phoneNumber: '0101000001', name: 'Dr. John', email: 'john@clinic.com', password: '1234'),
    UserData(id: 'd2', userType: 'doctor', phoneNumber: '0101000002', name: 'Dr. Smith', email: 'smith@clinic.com', password: '1234'),
    UserData(id: 'd3', userType: 'doctor', phoneNumber: '0101000003', name: 'Dr. Alice', email: 'alice@clinic.com', password: '1234'),
  ];

  final List<UserData> defaultPatients = [
    UserData(id: 'p1', userType: 'user', phoneNumber: '0202000001', name: 'Patient Anna', email: 'anna@hospital.com', password: '1234'),
    UserData(id: 'p2', userType: 'user', phoneNumber: '0202000002', name: 'Patient Ben', email: 'ben@hospital.com', password: '1234'),
    UserData(id: 'p3', userType: 'user', phoneNumber: '0202000003', name: 'Patient Clara', email: 'clara@hospital.com', password: '1234'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final usersAsyncValue = ref.watch(usersProvider); // Commented out Firebase fetching

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.whiteTextColor,
          ),
          title: const Text(
            'Users',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: Dimensions.fontSizeLarge,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteTextColor),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appBarColor,
          elevation: 4,
          bottom: TabBar(
            labelColor: AppColors.whiteTextColor,
            unselectedLabelColor: AppColors.greyColor,
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Doctors'),
              Tab(text: 'Patients'),
            ],
          ),
        ),
        body: BackgroundScreen(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildusersGrid(context, defaultDoctors),
              _buildusersGrid(context, defaultPatients),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildusersGrid(BuildContext context, List<UserData> userData) {
    return userData.isEmpty
        ? const Center(
      child: Text(
        'No users available',
        style: TextStyle(
            color: AppColors.whiteTextColor,
            fontSize: Dimensions.fontSizeExtraLarge),
      ),
    )
        : GridView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: userData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final user = userData[index];
        return GestureDetector(
          child: Card(
            color: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(Dimensions.radiusDefault),
            ),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AppImages.placeHolder,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          _showDeleteConfirmationDialog(user.id!);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 16,
                          child: Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Email: ${user.email}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Phone: ${user.phoneNumber}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteuser(userId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteuser(String userId) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('User deleted successfully'),
            backgroundColor: AppColors.successColor),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting user: $e'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }
}
