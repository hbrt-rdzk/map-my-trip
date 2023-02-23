import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mapmytrip/services/models.dart';
import 'package:mapmytrip/services/auth.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ??
        {}); //operator ?? zwraca wartość lewą jeśli wartość lewa nie jest typu null, jeśli jest zwraca prawą
  }

  Future<UserData> getUser(String email) async {
    var ref = _db.collection('users').doc(email);
    var snapshot = await ref.get();
    var data = snapshot.data();
    var user = UserData.fromJson(data!);
    return user;
  }

  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }
  
  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!; // assertion operator, trzeba mieć pewnośc, źe user nie jest null.
    var ref = _db.collection('reports').doc(user.uid);
    var data = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id]),
       }
    };
    return ref.set(data, SetOptions(merge: true));
  }
}