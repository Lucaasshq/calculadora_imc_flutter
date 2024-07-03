import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors/app_colors.dart';
import './model/imc.dart';

// ignore: must_be_immutable
class ImcPage extends StatefulWidget {
  const ImcPage({
    super.key,
  });

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final _form = GlobalKey<FormState>();
  String infoText = 'Informe seus dados';

  calcular() {
    try {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;

      Imc imcClass = Imc(peso, altura);
      double imc = imcClass.peso / (imcClass.altura * imcClass.altura);
      

      if (imc < 18.5) {
        infoText = '${imc.toStringAsFixed(2)} Abaixo do peso';
      } else if (imc < 25) {
        infoText = '${imc.toStringAsFixed(2)} Peso normal';
      } else if (imc < 30) {
        infoText = '${imc.toStringAsFixed(2)} Sobrepeso';
      } else if (imc < 35) {
        infoText = '${imc.toStringAsFixed(2)} Obesidade Grau I';
      } else if (imc < 40) {
        infoText = '${imc.toStringAsFixed(2)} Obesidade Grau II';
      } else {
        infoText = '${imc.toStringAsFixed(2)} Obesidade Grau III';
      }
    } catch (e) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira um número válido')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: pesoController,
                      style: const TextStyle(fontSize: 25),
                      decoration: const InputDecoration(
                        labelText: 'Peso (KG)',
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: Text('Ex: 60'),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe um Peso valido';
                        } else {
                          (double.parse(value));
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          /* peso = (value.isEmpty) ? 0 : double.parse(value); */
                        });
                      },
                    ),
                    TextFormField(
                      controller: alturaController,
                      style: const TextStyle(fontSize: 25),
                      decoration: const InputDecoration(
                        labelText: 'Altura (CM)',
                        prefixIcon: Icon(Icons.height),
                        suffixIcon: Text('Ex: 180'),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe uma altura valida';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          /* altura = (value.isEmpty) ? 0 : double.parse(value); */
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _form.currentState!.validate();
                    setState(() {
                      calcular();
                    });
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.verdeP)),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                        color: AppColors.pretoP,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                infoText,
                style: const TextStyle(
                    color: AppColors.verdeP,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    pesoController.text = '';
                    alturaController.text = '';
                  });
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.vermelhoP)),
                child: const Text(
                  'Resetar',
                  style: TextStyle(
                      color: AppColors.pretoP,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
