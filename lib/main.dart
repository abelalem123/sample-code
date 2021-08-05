import 'package:flutter/material.dart';
import 'package:sample/add_user.dart';
import 'package:sample/show_user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink("http://192.168.1.10:5000/");
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Registration Form',
        debugShowCheckedModeBanner: false,
        home: AddUser(),
      ),
    );
  }
}
