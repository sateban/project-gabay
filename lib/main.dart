import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_svg/flutter_svg.dart';

final _logger = Logger();

// 💡main()
// └── runApp()
//     └── MaterialApp
//         └── home: Scaffold
//             ├── appBar: AppBar
//             │     └── title: Text
//             └── body: Center
//                   └── child: Column
//                         ├── Text
//                         ├── Icon
//                         └── ElevatedButton

// 💡 Actual Hierarchy based on the code below
// Root: MyApp (StatelessWidget)
//   └─ MaterialApp
//        └─ home: MyHomePage (StatefulWidget)
//             └─ Scaffold
//                  ├─ AppBar (with title)
//                  ├─ Body: Center → Column → Text + Counter
//                  └─ FloatingActionButton

// 💡MaterialApp → Scaffold → AppBar & Body → Widgets inside body.

// 💡 What is a StatefulWidget/StatelessWidget?
// StatelessWidget
// Does not change after it’s built.
// Example: A Text("Hello") — once it shows “Hello”, it always shows “Hello”.

// StatefulWidget
// Can change over time (it has state that can be updated).
// Example: A counter that increases when you press a button.

// 💡Root of the App
void main() {
  // _logger.d("Debugging");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 💡MaterialApp
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // 💡Home (ref: https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200910164334/App.png)
      // home: const MyHomePage(title: 'AndroidApp'),
      home: const LoginPage(),
    );
  }
}

// 💡LoginPage
class LoginPage extends StatefulWidget {
  // const → makes the widget instance constant (if possible).
  // super.key → passes the optional Key parameter to the parent StatefulWidget class, allowing Flutter to track the widget’s identity during rebuilds.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole = "Visually Impaired"; // default value

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == "admin" && password == "1234") {
      _logger.i("Login success: $username");

      // Navigate to MyHomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // const MyHomePage(title: 'Flutter Demo Home Page'),
              const MyHomePage(),
        ),
      );
    } else if (username.isEmpty && password.isEmpty) {
      _logger.w("Empty credentials: $username");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter username and password")),
      );
    } else {
      _logger.w("Login failed: $username");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password")),
      );
    }
  }

  Widget _buildRoleCard({required IconData icon, required String label}) {
    final bool isSelected = _selectedRole == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = label;
          _logger.d("label $label");
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              // ? Theme.of(context).primaryColor
              ? Color(0xFF1193d4)
              // : Colors.black.withOpacity(0.05),
              : Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 48,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.black26,
                    width: 2,
                  ),
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 14,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 👇 Add SVG here
            SvgPicture.asset('assets/icons/blind.svg', height: 100),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            // Welcome
            const Text(
              "Project GABAY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1c1c1e),
                fontFamily: 'Inter',
              ),
            ),
            // const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            // Placeholder
            const Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF636366),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 22.0)),
            // Username
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: Color.fromARGB(100, 197, 197, 197),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 14.0)),
            // Password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                filled: true,
                fillColor: Color.fromARGB(100, 197, 197, 197),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              obscureText: true,
            ),
            // Forgot Password
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // remove extra padding
                    minimumSize: Size.zero, // no forced button size
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // shrink touch area
                    backgroundColor: Colors.transparent, // no background
                    overlayColor:
                        Colors.transparent, // remove ripple background
                  ),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14, color: Color(0xff1193d4)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _login,
            //   child: const Text("Login"),
            // ),
            SizedBox(
              width: double.infinity, // full width
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1193d4),
                  foregroundColor:
                      Colors.black87, // text color (like text-background-dark)
                  padding: const EdgeInsets.symmetric(vertical: 16), // py-3
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // rounded-lg
                  ),
                  elevation: 0,
                ),
                // .copyWith(
                //   // hover/pressed effect
                //   overlayColor: WidgetStateProperty.resolveWith((states) {
                //     if (states.contains(WidgetState.pressed)) {
                //       // return const Color.fromRGBO(25, 230, 128, 0.9); // hover:bg-primary/90
                //       return const Color(0xff1193d4);
                //     }
                //     return null;
                //   }),
                // ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 14, // text-sm
                    fontWeight: FontWeight.w900, // font-bold
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            // Space before register
            const SizedBox(height: 10),
            // Register
            SizedBox(
              width: double.infinity, // full width
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFc8e3f0),
                  foregroundColor:
                      Colors.black87, // text color (like text-background-dark)
                  padding: const EdgeInsets.symmetric(vertical: 16), // py-3
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // rounded-lg
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 14, // text-sm
                    fontWeight: FontWeight.w900, // font-bold
                    color: Color(0xff1193d4),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            // RoleSelection(),
            // Space before Roles
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Select Your Role",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  // const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: [
                      _buildRoleCard(
                        icon: Icons.accessibility_new,
                        label: "Visually Impaired",
                      ),
                      _buildRoleCard(icon: Icons.group, label: "Caregiver"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
  // int _currentIndex = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      print("Sample $_counter");
      _logger.d("Debugging: $_counter");
      _counter++;
    });
  }

  // Pages for each tab
  // static const List<Widget> _pages = <Widget>[
  //   Center(child: Text("🏠 Home Page", style: TextStyle(fontSize: 24))),
  //   Center(child: Text("📜 History Page", style: TextStyle(fontSize: 24))),
  //   Center(child: Text("🔔 Alerts Page", style: TextStyle(fontSize: 24))),
  //   Center(child: Text("⚙️ Settings Page", style: TextStyle(fontSize: 24))),
  // ];

  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    AlertsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _logger.d("_selectedIndex: $_selectedIndex");
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // 💡Scaffold inside MyHomePage
    return Scaffold(
      extendBodyBehindAppBar: false,
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // automaticallyImplyLeading: false,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   // title: Text(widget.title),
      //   // title: const Text("Home"),
      // ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     //
      //     // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      //     // action in the IDE, or press "p" in the console), to see the
      //     // wireframe for each widget.
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text('You have pushed the button this many times:'),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // so 4 items fit
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alerts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
        // currentIndex: _currentIndex,
        // onTap: (index) {
        //   setState(() {
        //     _logger.d("_currentIndex: $_currentIndex");
        //     _currentIndex = index;
        //   });
        // },
        // items: const [
        //   BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //   BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        //   BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
        //   BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Initial sample code
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(child-
    //
    //
    //
    //
    //
    //: Text("Home Page", style: TextStyle(fontSize: 24)));
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF6F7F8), // background-light
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFF6F7F8).withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        // leading: const Icon(Icons.menu, color: Color(0xFF616161)),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cane Connection
              const Text(
                "Cane Connection",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Connect to Cane",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212121),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Tap to establish a Bluetooth connection with your smart cane.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF757575),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF1193d4,
                              ), // primary
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.bluetooth,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Connect",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuB0Qie9R9XcdEYFEMKNMuTtcg2BU7tRpC1ls6BqJ-6zUxx_9LvtZBkOZlElo5NYrS3K7bXI4AmFRWFcZNoYLSUaSGTJbQtvTEN1j1Uq2kBexlBH6Vrhyo_oA_QFjubxEcd_0UJdF1fbe4adWcOeX5d0HRhGsVcRb8gCUAfeBtGgdf8PMxRUaRk0hLyCEZJOF_E9LLWVQ9nxulnKoNASs8Z2fXiHQJlEHBOoL9O4FhNTGjlbYkKWWc2sSrEXitiOrd8Q5WBNRtV_LmA",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Cane Status
              const Text(
                "Cane Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  statusTile("Battery", "85%", Colors.black87),
                  statusTile("Bluetooth", "Connected", Colors.green),
                  statusTile("Heart Rate", "72 bpm", Colors.black87),
                ],
              ),
              const SizedBox(height: 24),

              // Alerts
              const Text(
                "Alerts",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFCDD2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.warning, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      "Fall Detected",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // SOS Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(60),
                    shadowColor: Colors.black.withValues(alpha: 0.2),
                    elevation: 6,
                  ),
                  onPressed: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.sos, size: 50, color: Colors.white),
                      SizedBox(height: 4),
                      Text(
                        "SOS",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Mic Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x331193d4), // primary/20
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.mic,
                    size: 40,
                    color: Color(0xFF1193d4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // helper widget for status
  Widget statusTile(String title, String value, Color valueColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF757575))),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, color: valueColor),
          ),
        ],
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("History Page", style: TextStyle(fontSize: 24)));
  }
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Alerts Page", style: TextStyle(fontSize: 24)));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings Page Hello", style: TextStyle(fontSize: 24)),
    );
  }
}
