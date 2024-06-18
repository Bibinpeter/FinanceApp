import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/services/auth_service.dart';
import 'package:personalfinanceapp/services/finance_service.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:personalfinanceapp/widgets/dashbard_widget.dart';
import 'package:personalfinanceapp/widgets/mydivider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchInitialData(context);
    }
  }

  Future<void> _fetchInitialData(BuildContext context) async {
    try {
      final finService = Provider.of<UserService>(context, listen: false);
      final authService = Provider.of<AuthService>(context, listen: false);
      final userModel = await authService.getCurrentUser();
      if (userModel != null) {
        finService.calculateTotalIncomeForUser(userModel.id);
        finService.calculateTotalExpenseForUser(userModel.id);
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching initial data: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Consumer<UserService>(
        builder: (context, finService, _) {
          return _buildBody(context, finService);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserService finService) {
    final totalExpense = finService.totalExpense;
    final totalIncome = finService.totalIncome;

    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<AuthService>(
              builder: (context, authService, child) {
                return FutureBuilder<UserModel?>(
                  future: authService.getCurrentUser(),
                  builder: (context, snapshot) {
                    print('FutureBuilder snapshot: ${snapshot.connectionState}');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrangeAccent,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('FutureBuilder error: ${snapshot.error}');
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final userData = snapshot.data!;
                      print('User data fetched: ${userData.name}');
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  AppText(
                                    data: "Welcome!",
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  AppText(
                                    data: userData.name,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'profile');
                                },
                                child: CircleAvatar(
                                  child: Text(
                                    userData.name[0].toUpperCase(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const MyDivider(),
                          const SizedBox(
                            height: 20,
                          ),
                          DashboardItemWidget(
                            onTap1: () {
                              Navigator.pushNamed(context, "listexpense",
                                  arguments: totalExpense);
                            },
                            onTap2: () {
                              Navigator.pushNamed(context, "listincome",
                                  arguments: totalIncome);
                            },
                            titleOne: "Expense\n $totalExpense",
                            titleTwo: "Income \n $totalIncome",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DashboardItemWidget(
                            onTap1: () {
                              Navigator.pushNamed(context, 'addExpense',
                                  arguments: userData.id);
                            },
                            onTap2: () {
                              Navigator.pushNamed(context, 'addIncome',
                                  arguments: userData.id);
                            },
                            titleOne: "Add Expense",
                            titleTwo: "Add Income",
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Income vs Expense",
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                AspectRatio(
                                  aspectRatio: 1.3,
                                  child: PieChart(PieChartData(
                                    sectionsSpace: 5,
                                    centerSpaceColor: Colors.transparent,
                                    sections: [
                                      PieChartSectionData(
                                        radius: 50,
                                        color: chartColor1,
                                        value: finService.totalExpense,
                                        title: "Expense",
                                        titleStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        titleStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        color: chartColor2,
                                        title: "Income",
                                        value: finService.totalIncome,
                                      ),
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      print('No user data available');
                      return const Center(
                        child: Text(
                          'No user data available',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
