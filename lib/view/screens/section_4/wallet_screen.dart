import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final double walletBalance = 120.00;

  final List<Map<String, dynamic>> transactions = [
    {"id": "#1284", "amount": -30.0, "date": "10 June"},
    {"id": "#1233", "amount": 50.0, "date": "5 June"},
    {"id": "#1232", "amount": -20.0, "date": "5 June"},
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(local.wallet),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAF6FF), Color(0xFF86D3EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/wallet.png',
                          height: 170,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 10),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                local.your_balance,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "\$${walletBalance.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0D47A1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      local.add_money,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFD1F3FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      local.withdraw,
                                      style: const TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              local.transaction_history,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            final tx = transactions[index];
                            final bool isPositive = tx['amount'] > 0;

                            return Card(
                              color: Colors.white,
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: isPositive
                                      ? const Color(0xFFB2DFDB)
                                      : const Color(0xFFFFCDD2),
                                  child: Icon(
                                    isPositive
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: isPositive
                                        ? const Color(0xFF00695C)
                                        : const Color(0xFFC62828),
                                  ),
                                ),
                                title: Text(
                                  tx['id'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  tx['date'],
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                trailing: Text(
                                  "${isPositive ? '+' : '-'}\$${tx['amount'].abs()}",
                                  style: TextStyle(
                                    color: isPositive
                                        ? const Color(0xFF2E7D32)
                                        : const Color(0xFFD32F2F),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}