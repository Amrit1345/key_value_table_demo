import 'package:flutter/material.dart';
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
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    final themeParam = Uri.base.queryParameters['theme'];
    if (themeParam == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
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
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        cardTheme: CardThemeData(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardTheme: CardThemeData(
          elevation: 1,
          color: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF334155)),
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

class ShowcaseHomeScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const ShowcaseHomeScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  State<ShowcaseHomeScreen> createState() => _ShowcaseHomeScreenState();
}

class _ShowcaseHomeScreenState extends State<ShowcaseHomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final scrollParam = Uri.base.queryParameters['scroll'];
    final initialOffset = double.tryParse(scrollParam ?? '0') ?? 0.0;
    _scrollController = ScrollController(initialScrollOffset: initialOffset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              'key_value_table Showcase',
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
            onPressed: widget.onToggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 860;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1240),
              child: ListView(
                controller: _scrollController,
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
                              _buildCleanProfileCard(context),
                              const SizedBox(height: 24),
                              _buildFormInspectorCard(context),
                              const SizedBox(height: 24),
                              _buildStackedLayoutCard(context),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: [
                              _buildFinancialReceiptCard(context),
                              const SizedBox(height: 24),
                              _buildServerDiagnosticsCard(context),
                              const SizedBox(height: 24),
                              _buildGranularItemCard(context),
                            ],
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _buildCleanProfileCard(context),
                    const SizedBox(height: 20),
                    _buildFinancialReceiptCard(context),
                    const SizedBox(height: 20),
                    _buildFormInspectorCard(context),
                    const SizedBox(height: 20),
                    _buildServerDiagnosticsCard(context),
                    const SizedBox(height: 20),
                    _buildStackedLayoutCard(context),
                    const SizedBox(height: 20),
                    _buildGranularItemCard(context),
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
          'Modern no-colon whitespace, financial alignment, responsive stacked views, and granular item controls.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // 1. Modern Clean Key-Value (Default: No Colon)
  Widget _buildCleanProfileCard(BuildContext context) {
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
                  radius: 20,
                  child: Icon(
                    Icons.person_rounded,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. Modern Clean Profile',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Default: No colons, clean 2-column whitespace',
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
              density: KeyValueDensity.comfortable,
              data: {
                'Full Name': 'Dr. Alexander Fleming',
                'Medical License': 'GMC #4829104',
                'Specialty': 'Microbiology & Infectious Diseases',
                'Hospital': "St. Mary's Hospital, London",
                'Certification Year': 1928,
              },
            ),
          ],
        ),
      ),
    );
  }

  // 2. Financial & E-Commerce Receipt (Right-Aligned Values)
  Widget _buildFinancialReceiptCard(BuildContext context) {
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
                  backgroundColor: Colors.teal.withValues(alpha: 0.2),
                  radius: 20,
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    color: Colors.teal,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2. Financial & Receipt',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Right-aligned values with row dividers',
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
              keyAlignment: Alignment.centerLeft,
              valueAlignment: Alignment.centerRight,
              showDividers: true,
              dividerColor: theme.dividerColor.withValues(alpha: 0.3),
              data: {
                'Wireless Noise-Canceling Headphones': '\$299.00',
                'Eco Protection Plan (2 Years)': '\$39.00',
                'Standard Courier Shipping': 'FREE',
                'Estimated Sales Tax': '\$24.50',
                'Order Total Due': Text(
                  '\$362.50 USD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontSize: 15,
                  ),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  // 3. Form & Inspector (Right-Aligned Keys with Colon)
  Widget _buildFormInspectorCard(BuildContext context) {
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
                  backgroundColor: Colors.blue.withValues(alpha: 0.2),
                  radius: 20,
                  child: const Icon(
                    Icons.settings_suggest_rounded,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3. Form & Inspector Alignment',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Right-aligned keys with centered colon gutter',
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
              separator: ':',
              separatorWidth: 20.0,
              keyAlignment: Alignment.centerRight,
              valueAlignment: Alignment.centerLeft,
              data: {
                'Display Name': 'Antigravity Core',
                'Package Identifier': 'com.google.agentic.flutter',
                'Minimum SDK': 'Flutter 3.0.0 (Dart 3.0)',
                'Architectures': 'x86_64, arm64-v8a',
                'Internal Build': 4209,
              },
            ),
          ],
        ),
      ),
    );
  }

  // 4. Server Diagnostics (Zebra Striping & Tap-to-Copy)
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
                  backgroundColor: Colors.amber.withValues(alpha: 0.2),
                  radius: 20,
                  child: const Icon(Icons.dns_rounded, color: Colors.amber, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '4. Diagnostics & Tap-to-Copy',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Compact density, zebra striping & copyable',
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
              density: KeyValueDensity.compact,
              rowPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              alternateRowColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFF1F5F9),
              copyable: true,
              data: {
                'Cluster Host': 'k8s-prod-us-east.cloud.internal',
                'Node IP Address': '10.244.3.188',
                'Status': Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade400, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'HEALTHY',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                'Secret API Key': 'sk_live_99a8b7c6d5e4f3a2b1c0',
                'Backup Gateway': null,
              },
            ),
          ],
        ),
      ),
    );
  }

  // 5. Responsive & Stacked Layout
  Widget _buildStackedLayoutCard(BuildContext context) {
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
                  backgroundColor: Colors.purple.withValues(alpha: 0.2),
                  radius: 20,
                  child: const Icon(
                    Icons.view_agenda_rounded,
                    color: Colors.purple,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5. Responsive Stacked Layout',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Label on top, value below — ideal for cards',
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
              layout: KeyValueLayout.stacked,
              density: KeyValueDensity.comfortable,
              showDividers: true,
              dividerColor: theme.dividerColor.withValues(alpha: 0.3),
              data: const {
                'Architecture Goal':
                    'Deliver deterministic, highly extensible key-value presentation across all Flutter platforms.',
                'Telemetry Endpoint':
                    'https://telemetry.analytics.internal/v2/ingest?batch=true&compress=gzip',
                'Maintenance Window':
                    'Sundays from 02:00 UTC to 04:00 UTC (Automated rollouts enabled)',
              },
            ),
          ],
        ),
      ),
    );
  }

  // 6. Granular Control with KeyValueItem
  Widget _buildGranularItemCard(BuildContext context) {
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
                  backgroundColor: Colors.teal.withValues(alpha: 0.2),
                  radius: 20,
                  child: const Icon(
                    Icons.widgets_rounded,
                    color: Colors.teal,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '6. Granular Control (KeyValueItem)',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Leading/trailing widgets, tooltips & actions',
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
            KeyValueTable.items(
              density: KeyValueDensity.comfortable,
              showDividers: true,
              dividerColor: theme.dividerColor.withValues(alpha: 0.3),
              items: [
                const KeyValueItem(
                  leading: Icon(Icons.person_outline, size: 18, color: Color(0xFF6366F1)),
                  key: 'Account Owner',
                  value: 'Amrit (Senior Engineer)',
                  tooltip: 'Verified organization primary contact',
                ),
                const KeyValueItem(
                  leading: Icon(Icons.verified_user_outlined, size: 18, color: Colors.teal),
                  key: 'Two-Factor Auth',
                  value: 'Enforced via FIDO2 / Passkey',
                  trailing: Icon(Icons.check_circle, size: 16, color: Colors.teal),
                ),
                const KeyValueItem(
                  leading: Icon(Icons.memory, size: 18, color: Colors.orange),
                  key: 'Memory Usage',
                  value: '78.4% (6.2 GB of 8 GB)',
                  valueStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                KeyValueItem(
                  leading: const Icon(Icons.tune, size: 18, color: Colors.blueGrey),
                  key: 'Configuration',
                  value: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    ),
                    child: const Text('Configure'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
