import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chatservice.dart';
import 'chatpage.dart';
import 'loginpage.dart';

class Homepage extends StatefulWidget {
  final String loggedInEmail;

  Homepage({required this.loggedInEmail});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ChatService chatService = ChatService();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _authService.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                            onTap: () {
                              togglePages();
                            },
                          ))); // Navigate back to the login screen
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(
              "Welcome, ${widget.loggedInEmail}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Error fetching users. Please try again later.",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        }
        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return const Center(
            child: Text(
              "No users found. Start a conversation by inviting others!",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          );
        }

        final users = snapshot.data as List<Map<String, dynamic>>;
        final filteredUsers = users
            .where((user) => user["email"] != widget.loggedInEmail)
            .toList();

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return _buildUserListItem(filteredUsers[index], context);
          },
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          userData["email"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          "Tap to chat",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPages(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      ),
    );
  }

  bool showLogin = false;

  void togglePages() {
    setState(() {
      showLogin = true;
    });
  }
}
