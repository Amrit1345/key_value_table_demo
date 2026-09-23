import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:key_value_table/key_value_table.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KeyValueTableDemoApp());
}

class KeyValueTableDemoApp extends StatefulWidget {
  const KeyValueTableDemoApp({super.key});

  @override
  State<KeyValueTableDemoApp> createState() => _KeyValueTableDemoAppState();
}

class _KeyValueTableDemoAppState extends State<KeyValueTableDemoApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeyValueTable Demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5), // Indigo
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: ShowcaseHomeScreen(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class ShowcaseHomeScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const ShowcaseHomeScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.table_chart_rounded),
            SizedBox(width: 12),
            Text(
              'key_value_table Demo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle Light/Dark Theme',
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            onPressed: onToggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 860;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _buildProfileCard(context),
                              const SizedBox(height: 24),
                              _buildServerDiagnosticsCard(context),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: [
                              _buildOrderSummaryCard(context),
                              const SizedBox(height: 24),
                              _buildCustomSeparatorCard(context),
                            ],
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _buildProfileCard(context),
                    const SizedBox(height: 20),
                    _buildOrderSummaryCard(context),
                    const SizedBox(height: 20),
                    _buildServerDiagnosticsCard(context),
                    const SizedBox(height: 20),
                    _buildCustomSeparatorCard(context),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live Feature Gallery',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Pixel-perfect colon alignment, widget values, zebra striping, and tap interactions.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // 1. Profile Card (Showcases standard auto-alignment)
  Widget _buildProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  radius: 22,
                  child: Icon(
                    Icons.person_rounded,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Physician Profile',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Automatic intrinsic column alignment',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            const KeyValueTable(
              rowPadding: EdgeInsets.symmetric(vertical: 6.0),
              data: {
                'Full Name': 'Dr. Alexander Fleming',
                'Medical License': 'GMC #4829104',
                'Primary Specialty': 'Microbiology & Infectious Diseases',
                'Affiliated Hospital': 'St. Mary\'s Hospital, London',
                'Certification Year': 1928,
              },
            ),
          ],
        ),
      ),
    );
  }

  // 2. Order Summary Card (Showcases custom Widgets & Chips as values)
  Widget _buildOrderSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal.shade100,
                  radius: 22,
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Custom Badges & Rich Widgets',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            KeyValueTable(
              rowPadding: const EdgeInsets.symmetric(vertical: 6.0),
              data: {
                'Order ID': '#ORD-2026-9481',
                'Delivery Status': Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade400, width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        'Delivered',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                'Amount Due': const Text(
                  '\$249.99 USD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                'Payment Method': const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.credit_card, size: 16),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Mastercard (•••• 4242)',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  // 3. Server & Hardware Diagnostics (Showcases zebra striping & copy callbacks)
  Widget _buildServerDiagnosticsCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber.shade100,
                  radius: 22,
                  child: const Icon(Icons.dns_outlined, color: Colors.brown),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Server Diagnostics',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Zebra striping & tap-to-copy callbacks',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            KeyValueTable(
              separator: '→',
              separatorWidth: 26.0,
              rowPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              alternateRowColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.shade100,
              data: const {
                'Cluster Node': 'us-east-cluster-04',
                'Host IP': '192.168.1.150',
                'Active Port': '8080 (HTTPS/TLS 1.3)',
                'CPU Utilization': '14.2% (16 Cores)',
                'Memory Allocation': '8.4 GB / 32.0 GB',
              },
              onRowTap: (context, key, value) {
                Clipboard.setData(ClipboardData(text: value.toString()));
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied "$key" ($value) to clipboard!'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 4. Custom Border & Separator Card
  Widget _buildCustomSeparatorCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  radius: 22,
                  child: const Icon(Icons.tune_rounded, color: Colors.blue),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'App Specifications',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Custom TableBorder & custom separator styling',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            KeyValueTable(
              separator: '::',
              separatorWidth: 28.0,
              separatorStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.4),
                  width: 0.8,
                ),
              ),
              rowPadding: const EdgeInsets.symmetric(vertical: 8.0),
              data: const {
                'Package Name': 'key_value_table',
                'Release Version': '0.0.1',
                'Supported Platforms':
                    'Android, iOS, Web, macOS, Linux, Windows',
                'Dart SDK': '>=3.0.0 <4.0.0',
              },
            ),
          ],
        ),
      ),
    );
  }
}
