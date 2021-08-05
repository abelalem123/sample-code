import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:math' as math;

import 'package:sample/show_user.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

//   mutation Insert_user(\$email: String, \$id: Int, \$name: String) {
//   insert_User(objects: {email: \$email, id: \$id, name: \$name}) {
//     affected_rows
//   }
// }

  String mutation = """
  mutation (\$firstName:String,\$lastName:String,\$middleName:String,\$phone_no:Int,\$email:String,\$password:String){
  preRegister(userInfo:{firstName:\$firstName,lastName:\$lastName,middleName:\$middleName,phone_no:\$phone_no,email:\$email,password:\$password}) {
    message
  }
}
  """
      .replaceAll('\n', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql(mutation),
          update: (GraphQLDataProxy cache, QueryResult? result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            print('finished gg');
          },
        ),
        builder: (
          RunMutation runMutation,
          QueryResult? result,
        ) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(helperText: "Enter First Name"),
                    controller: _firstNameController,
                  ),
                  TextField(
                    decoration:
                        InputDecoration(helperText: "Enter middle name"),
                    controller: _middleNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(helperText: "Enter last name"),
                    controller: _lastNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(helperText: "Enter Email"),
                    controller: _emailController,
                  ),
                  TextField(
                    decoration: InputDecoration(helperText: "Enter password"),
                    controller: _passwordController,
                  ),
                  TextField(
                    decoration:
                        InputDecoration(helperText: "Enter phone number"),
                    controller: _phoneNumberController,
                  ),
                  MaterialButton(
                      child: Text('Add User'),
                      color: Colors.blue,
                      onPressed: () => runMutation({
                            'email': _emailController.text,
                            'firstName': _firstNameController.text,
                            'middleName': _middleNameController.text,
                            'lastName': _lastNameController.text,
                            'password': _passwordController.text,
                            'phone_no': int.parse(_phoneNumberController.text),
                          }))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
