// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(30, 107, 107, 107),
        title: Text(
          'Feedback List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/bg2.jpg"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        )),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data available');
            }

            final feedbackDocuments = snapshot.data!.docs;

            return ListView.builder(
              itemCount: feedbackDocuments.length,
              itemBuilder: (context, index) {
                final feedbackData =
                    feedbackDocuments[index].data() as Map<String, dynamic>;
                final feedbackepolicename =
                    feedbackData['Police Officer(s) Name(s)'] as String?;
                final feedbackeratting = feedbackData['Ratting'] as String?;
                final feedbackecomments =
                    feedbackData['Additional Comments'] as String?;
                final feedbackname = feedbackData['User name'] as String?;
                final feedbackphone = feedbackData['User Phone no'] as String?;
                final feedbackmail = feedbackData['User Email id'] as String?;
                final feedstation =
                    feedbackData['Police station detail'] as String?;
                return ListTile(
                  subtitle: Container(
                    width: 420,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User name:$feedbackname',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'User Phone no:$feedbackphone',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'User Email id:$feedbackmail',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Police station detail$feedstation',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Police Officer Name:$feedbackepolicename',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text('Ratting:$feedbackeratting',
                                style: TextStyle(fontSize: 16)),
                            Text('Additional Comments:$feedbackecomments',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
