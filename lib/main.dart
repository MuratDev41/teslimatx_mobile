import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UserOrdersPage(),
    HistoryPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.asset(
              'assets/logo.png',
              height: 45.0,
              width: 45.0,
            ),
          ), // Replace this with your app icon
          onPressed: () {
            // You can add functionality here for the app icon, e.g., navigate to a page
            print('App icon pressed!');
          },
        ),
        title: Text('TeslimatX', style: TextStyle(color: Colors.white70),),
        backgroundColor: Colors.black,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Geçmiş',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}

// Page 1: User Orders Page with 2x2 Status Update Buttons and Order Card
class UserOrdersPage extends StatefulWidget {
  @override
  _UserOrdersPageState createState() => _UserOrdersPageState();
}

class _UserOrdersPageState extends State<UserOrdersPage> {
  String orderStatus = 'Devam Ediyor'; // Initial order status

  void updateStatus(String newStatus) {
    setState(() {
      orderStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Merhaba,',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Ahmet Yuğla',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () {
                  switch (index) {
                    case 0:
                      updateStatus('Yolda');
                      break;
                    case 1:
                      updateStatus('Şubede');
                      break;
                    case 2:
                      updateStatus('Mağazada');
                      break;
                    case 3:
                      updateStatus('Boşta');
                      break;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: index == 0
                      ? Colors.orange
                      : index == 1
                          ? Colors.blue
                          : index == 2
                              ? Colors.green
                              : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  index == 0
                      ? 'Yolda'
                      : index == 1
                          ? 'Şubede'
                          : index == 2
                              ? 'Mağazada'
                              : 'Boşta',
                ),
              );
            },
          ),
          SizedBox(height: 20),

          // Order Card

          OrderCard(
            shopName: 'Komagene İzmit',
            status: 'Devam Ediyor', // Using the current status
            color: Colors.green, // Example color, adjust based on status
          ),
        ],
      ),
    );
  }
}

// Page 2: History Page
class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Eski Siparişler',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          SizedBox(height: 16),

          // Order Cards
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                OrderCard(
                  shopName: 'Komagene İzmit',
                  status: 'Tamamlandı', // Completed
                  color: Colors.green,
                ),
                OrderCard(
                  shopName: 'Burger King Kocaeli',
                  status: 'İptal Edildi', // Canceled
                  color: Colors.red.shade700, // Dark red
                ),
                OrderCard(
                  shopName: 'Starbucks Gölcük',
                  status: 'Tamamlandı', // Completed
                  color: Colors.green,
                ),
                OrderCard(
                  shopName: 'McDonald’s İzmit',
                  status: 'İptal Edildi', // Canceled
                  color: Colors.red.shade700, // Dark red
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Page 3: Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            color: Colors.blueAccent.withOpacity(0.1),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ahmet Yuğla',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ahmet.yugla@example.com',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blueAccent),
            title: Text('Profil'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print('Profile Settings tapped');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text('Ödeme'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print('Payment Settings tapped');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Çıkış'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print('Logout tapped');
            },
          ),
        ],
      ),
    );
  }
}

// Order Card Widget
class OrderCard extends StatelessWidget {
  final String shopName;
  final String status;
  final Color color;

  OrderCard(
      {required this.shopName, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.store, color: color),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shopName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(fontSize: 14, color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
