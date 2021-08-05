import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sample/add_user.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  _ShowUserState createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final String query = """
  query  {
  User {
    email
    id
    name
  }
}
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("show user"),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(query),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: result.data!['User'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(result.data!['User'][index]['name']),
                      subtitle: Text(result.data!['User'][index]['email']),
                      trailing:
                          Text(result.data!['User'][index]['id'].toString()));
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            // ignore: non_constant_identifier_names
            context,
            MaterialPageRoute(builder: (Context) => AddUser())),
      ),
    );
  }
}
