// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:wise_crypto/core/extensions/string_extensions.dart';
// import 'package:wise_crypto/domain/auth/entity/profile_entity/profile_entity.dart';

// import '../../app/locator.dart';
// import '../../data/local_data_source/local_data_keys.dart';
// import '../../data/local_data_source/local_data_source.dart';

// class ChatUtils {
//   ChatUtils._privateConstructor() {
//     currentUser =
//         sl<LocalDataSource>().getValue<ProfileEntity>(LocalDataKeys.user);
//   }

//   /// Singleton instance.
//   static final ChatUtils instance = ChatUtils._privateConstructor();
//   final _fireStore = FirebaseFirestore.instance;
//   final _localDataSource = sl<LocalDataSource>();
//   ProfileEntity? currentUser;

//   /// Creates [types.User] in Firebase to store name and avatar used on
//   /// rooms list.
//   Future<void> createUserInFirestore(types.User user) async {
//     await _fireStore.collection("users").doc(user.id).set({
//       'createdAt': FieldValue.serverTimestamp(),
//       'firstName': user.firstName,
//       'imageUrl': user.imageUrl,
//       'lastName': user.lastName,
//       'lastSeen': FieldValue.serverTimestamp(),
//       'metadata': user.metadata,
//       'role': user.role?.toShortString(),
//       'updatedAt': FieldValue.serverTimestamp(),
//     });
//   }

//   /// Removes message document.
//   Future<void> deleteMessage(String roomId, String messageId) async {
//     await _fireStore
//         .collection('${"rooms"}/$roomId/messages')
//         .doc(messageId)
//         .delete();
//   }

//   /// Removes room document.
//   Future<void> deleteRoom(String roomId) async {
//     await _fireStore.collection("rooms").doc(roomId).delete();
//   }

//   /// Removes [types.User] from `users` collection in Firebase.
//   Future<void> deleteUserFromFirestore(String userId) async {
//     await _fireStore.collection("users").doc(userId).delete();
//   }

//   Future<types.Room> createRoom(
//     types.User otherUser,
//   ) async {
//     final userIds = [currentUser?.id.toString(), otherUser.id]..sort();
//     final roomQuery = await _fireStore
//         .collection("rooms")
//         .where('type', isEqualTo: types.RoomType.direct.toShortString())
//         .where('userIds', isEqualTo: userIds)
//         .limit(1)
//         .get();

//     // Check if room already exist.
//     if (roomQuery.docs.isNotEmpty) {
//       final room = (await _processRoomsQuery(
//               query: roomQuery,
//               instance: _fireStore,
//               usersCollectionName: "users",
//               firebaseUser: currentUser!))
//           .first;
//       return room;
//     }

//     final oldRoomQuery = await _fireStore
//         .collection("rooms")
//         .where('type', isEqualTo: types.RoomType.direct.toShortString())
//         .where('userIds', isEqualTo: userIds.reversed.toList())
//         .limit(1)
//         .get();

//     // Check if room already exist.
//     if (oldRoomQuery.docs.isNotEmpty) {
//       final room = (await _processRoomsQuery(
//               firebaseUser: currentUser!,
//               usersCollectionName: "users",
//               instance: _fireStore,
//               query: oldRoomQuery))
//           .first;

//       return room;
//     }

//     final cUser = await _fetchUser(
//       _fireStore,
//       currentUser?.id.toString() ?? "",
//       "users",
//     );
//     // Create new room with sorted user ids array.
//     final room = await _fireStore.collection("rooms").add({
//       'createdAt': FieldValue.serverTimestamp(),
//       'imageUrl': null,
//       // 'metadata': metadata,
//       'name': null,
//       'type': types.RoomType.direct.toShortString(),
//       'updatedAt': FieldValue.serverTimestamp(),
//       'userIds': userIds,
//       'userRoles': null,
//     });

//     return types.Room(
//       id: room.id,
//       type: types.RoomType.direct,
//       users: [types.User.fromJson(cUser), otherUser],
//     );
//   }

//   /// Returns a stream of changes in a room from Firebase.
//   Stream<types.Room> room(String roomId) {
//     return _fireStore.collection("rooms").doc(roomId).snapshots().asyncMap(
//           (doc) => _processRoomDocument(
//               doc: doc,
//               instance: _fireStore,
//               user: currentUser!,
//               usersCollectionName: "users"),
//         );
//   }

//   Stream<List<types.Room>> rooms() {
//     final fu = currentUser;

//     if (fu == null) return const Stream.empty();

//     final collection = _fireStore.collection("rooms").where('userIds', arrayContains: "${fu.id}");

//     return collection.snapshots().asyncMap((query) => _processRoomsQuery(
//         firebaseUser: currentUser!,
//         instance: _fireStore,
//         query: query,
//         usersCollectionName: "users"));
//   }

//   Stream<List<types.Message>> messages(
//     types.Room room, {
//     List<Object?>? endAt,
//     List<Object?>? endBefore,
//     int? limit,
//     List<Object?>? startAfter,
//     List<Object?>? startAt,
//   }) {
//     var query = _fireStore
//         .collection('${"rooms"}/${room.id}/messages')
//         .orderBy('createdAt', descending: true);

//     if (endAt != null) {
//       query = query.endAt(endAt);
//     }

//     if (endBefore != null) {
//       query = query.endBefore(endBefore);
//     }

//     if (limit != null) {
//       query = query.limit(limit);
//     }

//     if (startAfter != null) {
//       query = query.startAfter(startAfter);
//     }

//     if (startAt != null) {
//       query = query.startAt(startAt);
//     }

//     return query.snapshots().map(
//           (snapshot) => snapshot.docs.fold<List<types.Message>>(
//             [],
//             (previousValue, doc) {
//               final data = doc.data();
//               final author = room.users.firstWhere(
//                 (u) => u.id == data['authorId'],
//                 orElse: () => types.User(id: data['authorId'] as String),
//               );

//               data['author'] = author.toJson();
//               data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
//               data['id'] = doc.id;
//               data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

//               return [...previousValue, types.Message.fromJson(data)];
//             },
//           ),
//         );
//   }

//   /// Sends a message to the Firestore. Accepts any partial message and a
//   /// room ID. If arbitraty data is provided in the [partialMessage]
//   /// does nothing.
//   void sendMessage(dynamic partialMessage, String roomId) async {
//     types.Message? message;

//     if (partialMessage is types.PartialCustom) {
//       message = types.CustomMessage.fromPartial(
//         author: types.User(id: currentUser!.id.toString()),
//         id: '',
//         partialCustom: partialMessage,
//       );
//     } else if (partialMessage is types.PartialFile) {
//       message = types.FileMessage.fromPartial(
//         author: types.User(id: currentUser!.id.toString()),
//         id: '',
//         partialFile: partialMessage,
//       );
//     } else if (partialMessage is types.PartialImage) {
//       message = types.ImageMessage.fromPartial(
//         author: types.User(id: currentUser!.id.toString()),
//         id: '',
//         partialImage: partialMessage,
//       );
//     } else if (partialMessage is types.PartialText) {
//       message = types.TextMessage.fromPartial(
//         author: types.User(id: currentUser!.id.toString()),
//         id: '',
//         partialText: partialMessage,
//       );
//     }

//     if (message != null) {
//       final messageMap = message.toJson();
//       messageMap.removeWhere((key, value) => key == 'author' || key == 'id');
//       messageMap['authorId'] = currentUser!.id.toString();
//       messageMap['createdAt'] = FieldValue.serverTimestamp();
//       messageMap['updatedAt'] = FieldValue.serverTimestamp();

//       await _fireStore
//           .collection('${"rooms"}/$roomId/messages')
//           .add(messageMap);

//       await _fireStore
//           .collection("rooms")
//           .doc(roomId)
//           .update({'updatedAt': FieldValue.serverTimestamp()});
//     }
//   }

//   void updateMessage(types.Message message, String roomId) async {
//     if (message.author.id != currentUser!.id.toString()) return;

//     final messageMap = message.toJson();
//     messageMap.removeWhere(
//       (key, value) => key == 'author' || key == 'createdAt' || key == 'id',
//     );
//     messageMap['authorId'] = message.author.id;
//     messageMap['updatedAt'] = FieldValue.serverTimestamp();

//     await _fireStore
//         .collection('${"rooms"}/$roomId/messages')
//         .doc(message.id)
//         .update(messageMap);
//   }
// }

// Future<List<types.Room>> _processRoomsQuery({
//   required ProfileEntity firebaseUser,
//   required FirebaseFirestore instance,
//   required QuerySnapshot<Map<String, dynamic>> query,
//   required String usersCollectionName,
// }) async {
//   final futures = query.docs.map(
//     (doc) => _processRoomDocument(
//       doc: doc,
//       user: firebaseUser,
//       instance: instance,
//       usersCollectionName: usersCollectionName,
//     ),
//   );

//   return await Future.wait(futures);
// }

// /// Returns a [types.Room] created from Firebase document.
// Future<types.Room> _processRoomDocument({
//   required DocumentSnapshot<Map<String, dynamic>> doc,
//   required ProfileEntity user,
//   required FirebaseFirestore instance,
//   required String usersCollectionName,
// }) async {
//   final data = doc.data()!;

//   data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
//   data['id'] = doc.id;
//   data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

//   var imageUrl = data['imageUrl'] as String?;
//   var name = data['name'] as String?;
//   final type = data['type'] as String;
//   final userIds = data['userIds'] as List<dynamic>;
//   final userRoles = data['userRoles'] as Map<String, dynamic>?;

//   final users = await Future.wait(
//     userIds.map(
//       (userId) => _fetchUser(
//         instance,
//         userId as String,
//         usersCollectionName,
//         role: userRoles?[userId] as String?,
//       ),
//     ),
//   );

//   if (type == types.RoomType.direct.toShortString()) {
//     try {
//       final otherUser = users.firstWhere(
//         (u) => u['id'] != user.id.toString(),
//       );

//       imageUrl = otherUser['imageUrl'] as String?;
//       name = '${otherUser['firstName'] ?? ''} ${otherUser['lastName'] ?? ''}'
//           .trim();
//     } catch (e) {
//       // Do nothing if other user is not found, because he should be found.
//       // Consider falling back to some default values.
//     }
//   }

//   data['imageUrl'] = imageUrl;
//   data['name'] = name;
//   data['users'] = users;

//   if (data['lastMessages'] != null) {
//     final lastMessages = data['lastMessages'].map((lm) {
//       final author = users.firstWhere(
//         (u) => u['id'] == lm['authorId'],
//         orElse: () => {'id': lm['authorId'] as String},
//       );

//       lm['author'] = author;
//       lm['createdAt'] = lm['createdAt']?.millisecondsSinceEpoch;
//       lm['id'] = lm['id'] ?? '';
//       lm['updatedAt'] = lm['updatedAt']?.millisecondsSinceEpoch;

//       return lm;
//     }).toList();

//     data['lastMessages'] = lastMessages;
//   }

//   return types.Room.fromJson(data);
// }

// /// Fetches user from Firebase and returns a promise.
// Future<Map<String, dynamic>> _fetchUser(
//   FirebaseFirestore instance,
//   String userId,
//   String usersCollectionName, {
//   String? role,
// }) async {
//   final doc = await instance.collection(usersCollectionName).doc(userId).get();

//   final data = doc.data()!;

//   data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
//   data['id'] = doc.id;
//   data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
//   data['role'] = role;
//   data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

//   return data;
// }
