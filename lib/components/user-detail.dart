import 'package:app/core/api/login-service.dart';
import 'package:app/core/domain/matricula/matricula.dart';
import 'package:app/screens/usuario.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail(this.matricula, {Key? key}) : super(key: key);

  final Matricula matricula;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsuarioWidget(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.settings,
                      color: secondaryColor,
                      size: 30,
                    ),
                  ),
                  Text(
                    matricula.usuario.nome,
                    style: TextStyle(
                        color: secondaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  LoginApi.logout(context);
                },
                child: const Text(
                  'Sair',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
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
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_events,
                            size: 40, color: Colors.orangeAccent),
                        // mudar de acordo com a liga atual
                        Container(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            "Liga de alguma coisa",
                            style: TextStyle(color: ninthColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
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
                      children: [
                        Text(
                          "${matricula.totalPontuacao} XP",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: eighthColor),
                        ),
                        Text(
                          "Total de pontos",
                          style: TextStyle(color: ninthColor),
                        )
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
