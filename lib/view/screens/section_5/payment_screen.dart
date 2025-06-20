import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_5/profile_screen.dart';
import 'package:servana/view/screens/section_6/worker_notification_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../../widgets/payment_widget.dart';
import '../section_3/home_client_screen.dart';
import '../section_4/history_screen.dart';
import '../section_4/wallet_screen.dart';


//// show when the worker end work.


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedIndex2 = 0;

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final hintTextColor = isDark ? Colors.grey[400] : Colors.grey[700];
    final iconColor = isDark ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]
              : [Colors.blue.shade600, Colors.lightBlue.shade100],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  HomeScreen()));
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
              ),
              Text(
                local.servana,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WorkerNotificationScreen()),
                  );
                },
                icon: const Icon(Icons.notifications, color: Colors.white, size: 32),
              ),
            ],
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500), // Made box larger
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: PaymentWidget(),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: bgColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottonNavigationWidget(
                  icon: Icons.home_filled,
                  label: local.bottomNavHome,
                  isSelected: selectedIndex2 == 0,
                  onTap: () {
                    onItemTapped2(0);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                  },
                ),
                BottonNavigationWidget(
                  icon: Icons.wallet,
                  label: local.bottomNavWallet,
                  isSelected: selectedIndex2 == 1,
                  onTap: () {
                    onItemTapped2(1);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => WalletScreen()));
                  },
                ),
                BottonNavigationWidget(
                  icon: Icons.history,
                  label: local.bottomNavHistory,
                  isSelected: selectedIndex2 == 2,
                  onTap: () {
                    onItemTapped2(2);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen()));
                  },
                ),
                BottonNavigationWidget(
                  icon: Icons.person,
                  label: local.bottomNavProfile,
                  isSelected: selectedIndex2 == 3,
                  onTap: () {
                    onItemTapped2(3);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
