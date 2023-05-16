import 'package:app/core/api/login-service.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginApi();
    return Container(
      padding: const EdgeInsets.only(top: 0, right: 10, bottom: 10, left: 10),
      color: primaryColor,
      child: Column(
        children: [
          Divider(
            color: sixthColor,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  LoginApi.logout(context);
                },
                child: const Text(
                  'Sair',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Nome do usuário',
                    style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 10,
                  ),
                  Icon(
                    Icons.settings,
                    color: secondaryColor,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: fifthColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: const [
                        Text(
                          "100 XP",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                        Text("Total de pontos")
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: fifthColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: const [
                        Text(
                          "100 XP",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                        Text("Total de pontos")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
