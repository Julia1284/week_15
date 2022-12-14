import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:week_9/content/loginpage_content.dart';
import 'package:week_9/data/users.dart';
import 'package:sizer/sizer.dart';
// import 'package:week_9/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// объявляем переменные
  var remember;
  String name = '';
  String surname = '';
  String email = '';
  String password = '';
  String phoneNumber = '';
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
// в функцию как аргумент получаем значение булевое, и кладем его в память (нажата галочка или нет)
  Future changeLaunch(launch) async {
    await UserPreferences().setLaunch(launch);
  }

  @override
  void initState() {
    super.initState();
    email = UserPreferences().getEmail() ?? '';
    password = UserPreferences().getPassword() ?? '';
    name = UserPreferences().getUsername() ?? '';
    phoneNumber = UserPreferences().getPhoneNumber() ?? '';
    remember = UserPreferences().getLaunch() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = SizerUtil.orientation == Orientation.landscape;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Вход в систему'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                height: 100.h,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset('assets/images/login.png'),
                    Stack(children: const [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/login.png'),
                          radius: 90,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    SizerUtil.deviceType == DeviceType.tablet
                        ? Container(
                            width: isLandscape ? 80.w : 70.w,
                            child: TextFormField(
                              controller: controllerEmail,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.email)),
                            ),
                          )
                        : Container(
                            width: isLandscape ? 80.w : 100.w,
                            child: TextFormField(
                              controller: controllerEmail,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.email)),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizerUtil.deviceType == DeviceType.tablet
                        ? Container(
                            width: isLandscape ? 80.w : 70.w,
                            child: TextFormField(
                              controller: controllerPassword,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.password)),
                              obscureText: true,
                            ),
                          )
                        : Container(
                            width: isLandscape ? 80.w : 100.w,
                            child: TextFormField(
                              controller: controllerPassword,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.password)),
                              obscureText: true,
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 180,
                        child: CheckboxListTile(
                          value: remember,
                          // меняем значение checkBox
                          onChanged: (value) {
                            setState(() {
                              remember = value!;
                            });
                          },
                          title: const Text('Remember'),
                        ),
                      ),
                    ]),
                    Container(
                      width: 50.w,
                      child: OutlinedButton.icon(
                          // при нажатии проверяем совпадает ли логин и пароль с теми, что сохранены в памяти,
                          //если да, то переходим на страницу пользователя, если нет, то получаем сообщение об ошибке
                          //  а также записываем в память значение remember
                          onPressed: () {
                            email = UserPreferences().getEmail()!;
                            password = UserPreferences().getPassword()!;
                            if (controllerEmail.text == email &&
                                controllerPassword.text == password) {
                              Navigator.pushNamed(context, '/userpage');
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Login and password are wrong'),
                                backgroundColor: Colors.red,
                              ));
                            }
                            changeLaunch(remember);
                          },
                          icon: const Icon(Icons.login),
                          label: const Text('Login')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        //  переходим на страницу регистрации
                        onPressed: () =>
                            Navigator.pushNamed(context, '/formpage'),
                        child: const Text('Register'))
                  ],
                ),
              ),
            )));
  }
}
