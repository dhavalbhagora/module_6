import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/message.dart';

class ChatService {
  //get messages
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("chatapp1").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return {
          "email": user["email"],
          "uid": user["uid"],
        };
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, String message) async {
    try {
      // Get current user info
      final String? currentUserID = _auth.currentUser?.uid;
      final String? currentUserEmail = _auth.currentUser?.email;

      if (currentUserID == null || currentUserEmail == null) {
        throw Exception("Current user is not signed in.");
      }

      // Convert Timestamp to a String
      final String formattedTimestamp =
          Timestamp.now().toDate().toIso8601String();

      // Create a new message
      Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: formattedTimestamp, // Pass as a String
      );

      // Construct chat room ID for the two users
      List<String> ids = [currentUserID, receiverID];
      ids.sort(); // Ensure uniqueness
      String chatRoomID = ids.join('_');

      // Add message to Firestore
      await _firestore
          .collection("chat_rooms")
          .doc(chatRoomID)
          .collection("messages")
          .add(newMessage.toMap());
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
