



import 'package:flutter/material.dart';

class ConsultantsItem extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String role;

  ConsultantsItem(
      this.email, this.firstName, this.lastName, this.role);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //height: 300,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        firstName,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Colors.black54),
                      ),
                      Text(
                        lastName,
                        style: TextStyle(color: Colors.black54),
                      )
                    ],
                  ),
              SizedBox(
                height: 10,
              ),
                  Text(
                    email,
                    style: TextStyle(color: Colors.black54),
                  ) ,
                  Text(
                    role,
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
