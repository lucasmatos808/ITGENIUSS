import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IT Genius',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const LoginPage(), // Troque para sua tela inicial real
    );
  }
}

// Tela de Login
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewPage(
                      url: 'https://www.ITGENIUS.com',
                      title: 'IT Genius',
                    ),
                  ),
                );
              },
              child: const Text(
                'Abrir site IT Genius',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 20),
                _buildTagline(),
                const SizedBox(height: 30),
                _buildEmailField(emailController),
                const SizedBox(height: 15),
                _buildPasswordField(passwordController),
                const SizedBox(height: 20),
                _buildLoginButton(context, emailController, passwordController),
                const SizedBox(height: 10),
                _buildForgotPasswordButton(context),
                const SizedBox(height: 10),
                _buildRegisterButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        '../LOGO.png', // Substitua pelo caminho do seu logo
        height: 120,
      ),
    );
  }

  Widget _buildTagline() {
    return const Text(
      '“IT Genius, Uma jornada de conhecimento em TI”.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'E-mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Senha',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildLoginButton(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, preencha todos os campos.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        // Busca os dados cadastrados
        final userData = await LocalStorage.getUserData();
        final registeredEmail = userData['userEmail'] ?? '';
        final registeredPassword = userData['userPassword'] ?? '';

        if (email == registeredEmail && password == registeredPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail ou senha inválidos!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
        );
      },
      child: const Text(
        'Recuperar senha',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
      ),
      child: const Text(
        'Cadastro',
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}

//Tela de Cadastro
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 20),
                _buildNameField(nameController),
                const SizedBox(height: 15),
                _buildEmailField(emailController),
                const SizedBox(height: 15),
                _buildPasswordField(passwordController),
                const SizedBox(height: 20),
                _buildRegisterButton(context, nameController, emailController,
                    passwordController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        '../LOGO.png', // Replace with your logo asset
        height: 120,
      ),
    );
  }

  Widget _buildNameField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Nome',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'E-mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Senha',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return ElevatedButton(
      onPressed: () {
        final name = nameController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        if (name.isEmpty || email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, preencha todos os campos.'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          _registerUser(name, email, password, context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
      child: const Text(
        'Cadastrar',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _registerUser(
      String name, String email, String password, BuildContext context) async {
    await LocalStorage.saveUserData(name, email, password, 0, 0, 0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}

//Tela de Recuperação de Senha
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 20),
                _buildEmailField(emailController),
                const SizedBox(height: 20),
                _buildNewPasswordField(newPasswordController),
                const SizedBox(height: 20),
                _buildConfirmPasswordField(confirmPasswordController),
                const SizedBox(height: 20),
                _buildResetButton(context, emailController,
                    newPasswordController, confirmPasswordController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        '../LOGO.png', // Replace with your logo asset
        height: 120,
      ),
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'E-mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildNewPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Nova Senha',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Confirmar Senha',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildResetButton(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController newPasswordController,
      TextEditingController confirmPasswordController) {
    return ElevatedButton(
      onPressed: () {
        final email = emailController.text.trim();
        final newPassword = newPasswordController.text.trim();
        final confirmPassword = confirmPasswordController.text.trim();

        if (email.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, preencha todos os campos.'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (newPassword != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('As senhas não coincidem.'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
      child: const Text(
        'Redefinir Senha',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

//Tela de Perfil
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int totalQuestions = 10; // Você pode ajustar conforme sua lógica
  int completada = 0;

  @override
  void initState() {
    super.initState();
    _loadUserQuizData();
  }

  Future<void> _loadUserQuizData() async {
    final userData = await LocalStorage.getUserData();
    setState(() {
      score = userData['score'] ?? 0;
      correctAnswers = userData['correctAnswers'] ?? 0;
      wrongAnswers = userData['wrongAnswers'] ?? 0;
      totalQuestions = correctAnswers + wrongAnswers;
      completada = totalQuestions > 0
          ? ((correctAnswers + wrongAnswers) / totalQuestions * 100).toInt()
          : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 450,
                  width: 500,
                  margin: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 8,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: 320,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "$completada% ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple.shade700),
                                        ),
                                        const TextSpan(
                                          text: "Completada",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple),
                                        ),
                                        TextSpan(
                                          text: " $totalQuestions ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple.shade700),
                                        ),
                                        const TextSpan(
                                            text: "Total Questões",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.purple)),
                                      ],
                                    ),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "${correctAnswers.toString().padLeft(2, '0')} ",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 18),
                                        ),
                                        const TextSpan(
                                            text: "Corretas",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text:
                                            "${wrongAnswers.toString().padLeft(2, '0')} ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 18),
                                      ),
                                      const TextSpan(
                                          text: "Incorretas",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),

            // Botão circular central
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizPage()),
                      ).then((_) =>
                          _loadUserQuizData()); // Atualiza ao voltar do quiz
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: const Color.fromARGB(255, 1, 84, 172),
                      padding: const EdgeInsets.all(24),
                      elevation: 4,
                    ),
                    child: const Icon(Icons.lightbulb,
                        color: Colors.white, size: 36),
                  ),
                  const SizedBox(height: 8),
                  const Text("Iniciar", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const Spacer(),

            // Barra inferior com ícones
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye,
                            color: Color(0xFFBCA16B), size: 32),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RankingPage(),
                            ),
                          );
                        },
                      ),
                      const Text("Ranking",
                          style: TextStyle(color: Color(0xFFBCA16B))),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings,
                            color: Colors.purple, size: 32),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final userData = await LocalStorage.getUserData();
                          final TextEditingController emailController =
                              TextEditingController(
                            text: userData['name'] ?? '',
                          );

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Alterar E-mail'),
                                content: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Novo e-mail',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final newEmail =
                                          emailController.text.trim();
                                      if (newEmail.isNotEmpty) {
                                        // Atualiza apenas o e-mail no SharedPreferences
                                        await prefs.setString(
                                            'userName', newEmail);
                                        setState(() {}); // Atualiza a tela
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'E-mail atualizado com sucesso!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Salvar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const Text("Config",
                          style: TextStyle(color: Colors.purple)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share,
                            color: Color(0xFF5C6BC0), size: 32),
                        onPressed: () {
                          Share.share(
                            'Confira meu perfil no IT Genius! 💡\n'
                            'Pontuação: $score pt\n'
                            'Corretas: ${correctAnswers.toString().padLeft(2, '0')}\n'
                            'Incorretas: ${wrongAnswers.toString().padLeft(2, '0')}\n'
                            'Baixe o app e desafie-se também!',
                            subject: 'Meu perfil no IT Genius',
                          );
                        },
                      ),
                      const Text("Share",
                          style: TextStyle(color: Color(0xFF5C6BC0))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _timeRemaining = 20; // Tempo inicial em segundos
  late Timer _timer;

  final List<Map<String, dynamic>> allQuestions = [
    {
      'question':
          'Qual das seguintes opções NÃO é uma linguagem de programação?',
      'options': [
        {'text': 'HTML', 'isCorrect': true},
        {'text': 'DART', 'isCorrect': false},
        {'text': 'JAVA', 'isCorrect': false},
        {'text': 'C++', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que significa a sigla CPU?',
      'options': [
        {'text': 'Central Processing Unit', 'isCorrect': true},
        {'text': 'Central Programming Unit', 'isCorrect': false},
        {'text': 'Computer Processing Unit', 'isCorrect': false},
        {'text': 'Control Processing Unit', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual é a função do protocolo HTTP?',
      'options': [
        {'text': 'Transferir arquivos', 'isCorrect': false},
        {'text': 'Transferir páginas web', 'isCorrect': true},
        {'text': 'Gerenciar redes', 'isCorrect': false},
        {'text': 'Proteger dados', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual é o sistema operacional mais usado no mundo?',
      'options': [
        {'text': 'Linux', 'isCorrect': false},
        {'text': 'Windows', 'isCorrect': true},
        {'text': 'macOS', 'isCorrect': false},
        {'text': 'Android', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um algoritmo?',
      'options': [
        {'text': 'Uma linguagem de programação', 'isCorrect': false},
        {
          'text': 'Uma sequência de passos para resolver um problema',
          'isCorrect': true
        },
        {'text': 'Um tipo de hardware', 'isCorrect': false},
        {'text': 'Um software de edição', 'isCorrect': false},
      ],
    },
    {
      'question':
          'Qual é a principal linguagem usada para desenvolvimento web?',
      'options': [
        {'text': 'Python', 'isCorrect': false},
        {'text': 'JavaScript', 'isCorrect': true},
        {'text': 'C++', 'isCorrect': false},
        {'text': 'Ruby', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um banco de dados relacional?',
      'options': [
        {
          'text': 'Um banco de dados que usa tabelas para organizar dados',
          'isCorrect': true
        },
        {
          'text': 'Um banco de dados que armazena apenas imagens',
          'isCorrect': false
        },
        {'text': 'Um banco de dados que não usa tabelas', 'isCorrect': false},
        {
          'text': 'Um banco de dados que só funciona offline',
          'isCorrect': false
        },
      ],
    },
    {
      'question': 'Qual é a principal função de um firewall?',
      'options': [
        {'text': 'Proteger contra vírus', 'isCorrect': false},
        {'text': 'Controlar o tráfego de rede', 'isCorrect': true},
        {'text': 'Aumentar a velocidade da internet', 'isCorrect': false},
        {'text': 'Gerenciar senhas', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que significa a sigla IoT?',
      'options': [
        {'text': 'Internet of Things', 'isCorrect': true},
        {'text': 'Internet of Technology', 'isCorrect': false},
        {'text': 'Integration of Technology', 'isCorrect': false},
        {'text': 'Internet of Tools', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual é a função de um sistema operacional?',
      'options': [
        {'text': 'Gerenciar hardware e software', 'isCorrect': true},
        {'text': 'Criar aplicativos', 'isCorrect': false},
        {'text': 'Proteger dados', 'isCorrect': false},
        {'text': 'Transferir arquivos', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um byte?',
      'options': [
        {'text': 'Unidade de armazenamento de dados', 'isCorrect': true},
        {'text': 'Tipo de processador', 'isCorrect': false},
        {'text': 'Sistema operacional', 'isCorrect': false},
        {'text': 'Linguagem de programação', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um sistema operacional mobile?',
      'options': [
        {'text': 'Android', 'isCorrect': true},
        {'text': 'Windows 10', 'isCorrect': false},
        {'text': 'Ubuntu Server', 'isCorrect': false},
        {'text': 'Photoshop', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que significa a sigla RAM?',
      'options': [
        {'text': 'Random Access Memory', 'isCorrect': true},
        {'text': 'Read Access Memory', 'isCorrect': false},
        {'text': 'Run Access Memory', 'isCorrect': false},
        {'text': 'Rapid Access Memory', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual linguagem é usada para estilizar páginas web?',
      'options': [
        {'text': 'CSS', 'isCorrect': true},
        {'text': 'HTML', 'isCorrect': false},
        {'text': 'Python', 'isCorrect': false},
        {'text': 'SQL', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um loop em programação?',
      'options': [
        {'text': 'Estrutura de repetição', 'isCorrect': true},
        {'text': 'Tipo de variável', 'isCorrect': false},
        {'text': 'Função matemática', 'isCorrect': false},
        {'text': 'Erro de sintaxe', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um banco de dados relacional?',
      'options': [
        {'text': 'MySQL', 'isCorrect': true},
        {'text': 'MongoDB', 'isCorrect': false},
        {'text': 'Redis', 'isCorrect': false},
        {'text': 'Firebase', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um IP?',
      'options': [
        {'text': 'Endereço de rede', 'isCorrect': true},
        {'text': 'Tipo de processador', 'isCorrect': false},
        {'text': 'Sistema operacional', 'isCorrect': false},
        {'text': 'Linguagem de programação', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um navegador de internet?',
      'options': [
        {'text': 'Google Chrome', 'isCorrect': true},
        {'text': 'Windows', 'isCorrect': false},
        {'text': 'Excel', 'isCorrect': false},
        {'text': 'Linux', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um servidor?',
      'options': [
        {'text': 'Computador que fornece serviços a outros', 'isCorrect': true},
        {'text': 'Programa de edição de texto', 'isCorrect': false},
        {'text': 'Dispositivo de entrada', 'isCorrect': false},
        {'text': 'Tipo de memória', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um periférico de entrada?',
      'options': [
        {'text': 'Teclado', 'isCorrect': true},
        {'text': 'Monitor', 'isCorrect': false},
        {'text': 'Impressora', 'isCorrect': false},
        {'text': 'Caixa de som', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um software?',
      'options': [
        {'text': 'Conjunto de instruções para o computador', 'isCorrect': true},
        {'text': 'Parte física do computador', 'isCorrect': false},
        {'text': 'Cabo de energia', 'isCorrect': false},
        {'text': 'Tipo de processador', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um exemplo de hardware?',
      'options': [
        {'text': 'Placa-mãe', 'isCorrect': true},
        {'text': 'Windows', 'isCorrect': false},
        {'text': 'Word', 'isCorrect': false},
        {'text': 'Photoshop', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um algoritmo de busca?',
      'options': [
        {'text': 'Método para encontrar dados', 'isCorrect': true},
        {'text': 'Tipo de processador', 'isCorrect': false},
        {'text': 'Sistema operacional', 'isCorrect': false},
        {'text': 'Linguagem de programação', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um protocolo de e-mail?',
      'options': [
        {'text': 'SMTP', 'isCorrect': true},
        {'text': 'HTTP', 'isCorrect': false},
        {'text': 'FTP', 'isCorrect': false},
        {'text': 'SSH', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um backup?',
      'options': [
        {'text': 'Cópia de segurança dos dados', 'isCorrect': true},
        {'text': 'Tipo de vírus', 'isCorrect': false},
        {'text': 'Sistema operacional', 'isCorrect': false},
        {'text': 'Linguagem de programação', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um sistema de controle de versão?',
      'options': [
        {'text': 'Git', 'isCorrect': true},
        {'text': 'Excel', 'isCorrect': false},
        {'text': 'Word', 'isCorrect': false},
        {'text': 'PowerPoint', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um domínio na internet?',
      'options': [
        {'text': 'Nome que identifica um site', 'isCorrect': true},
        {'text': 'Tipo de processador', 'isCorrect': false},
        {'text': 'Sistema operacional', 'isCorrect': false},
        {'text': 'Linguagem de programação', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um exemplo de linguagem de marcação?',
      'options': [
        {'text': 'HTML', 'isCorrect': true},
        {'text': 'Python', 'isCorrect': false},
        {'text': 'Java', 'isCorrect': false},
        {'text': 'C#', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um cookie na web?',
      'options': [
        {
          'text': 'Arquivo que armazena informações do usuário',
          'isCorrect': true
        },
        {'text': 'Tipo de vírus', 'isCorrect': false},
        {'text': 'Sistema operacional', 'isCorrect': false},
        {'text': 'Linguagem de programação', 'isCorrect': false},
      ],
    },
    {
      'question': 'Qual destes é um exemplo de inteligência artificial?',
      'options': [
        {'text': 'Reconhecimento de voz', 'isCorrect': true},
        {'text': 'Monitor', 'isCorrect': false},
        {'text': 'Teclado', 'isCorrect': false},
        {'text': 'HD', 'isCorrect': false},
      ],
    },
    {
      'question': 'O que é um endereço MAC?',
      'options': [
        {'text': 'Identificador único de uma placa de rede', 'isCorrect': true},
        {'text': 'Sistema operacional da Apple', 'isCorrect': false},
        {'text': 'Tipo de memória', 'isCorrect': false},
        {'text': 'Linguagem de programação', 'isCorrect': false},
      ],
    },
  ];

  late List<Map<String, dynamic>> questions; // Perguntas selecionadas
  String? _selectedOption; // Armazena a opção selecionada
  bool? _isCorrect; // Indica se a resposta está correta
  int _currentQuestionIndex = 0; // Índice da pergunta atual
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectRandomQuestions();
    _startTimer();
  }

  void _selectRandomQuestions() {
    questions = List<Map<String, dynamic>>.from(allQuestions);
    questions.shuffle(Random());
    questions = questions.sublist(0, 10);
    setState(() {
      _isLoading = false;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tempo esgotado!'),
            backgroundColor: Colors.red,
          ),
        );
        _nextQuestion();
      }
    });
  }

  Future<void> _nextQuestion() async {
    _timer.cancel(); // Cancela o timer atual antes de avançar
    ScaffoldMessenger.of(context).clearSnackBars(); // Limpa o feedback anterior
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
        _isCorrect = null;
        _timeRemaining = 20;
      });
      _startTimer();
    } else {
      // Calcule os resultados
      int correct = 0;
      int wrong = 0;
      for (var q in questions) {
        final userAnswer = q['userAnswer'];
        final correctOption = (q['options'] as List)
            .firstWhere((opt) => opt['isCorrect'] == true)['text'];
        if (userAnswer == correctOption) {
          correct++;
        } else {
          wrong++;
        }
      }
      int score = correct * 10;
      int completada = ((questions.length) / questions.length * 100).toInt();

      // Salve os dados no LocalStorage
      final userData = await LocalStorage.getUserData();
      final name = userData['name'] ?? 'Usuário';
      final email = userData['userEmail'] ?? '';
      final password = userData['userPassword'] ?? '';
      await LocalStorage.saveUserData(
          name, email, password, score, correct, wrong);
      await LocalStorage.saveRankingData(name, score);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            completada: completada,
            totalQuestions: questions.length,
            correctAnswers: correct,
            wrongAnswers: wrong,
            score: score,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Purple rectangle
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Question ${_currentQuestionIndex + 1}/${questions.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tempo Restante',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      value: _timeRemaining / 20,
                                      color: Colors.purple,
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  ),
                                  Text(
                                    '$_timeRemaining',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            currentQuestion['question'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            maxLines: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          // Options
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                    (currentQuestion['options'] as List<Map<String, dynamic>>)
                        .map((option) => _buildOption(
                            context, option['text'], option['isCorrect']))
                        .toList(),
              ),
            ),
          ),

          // Skip button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Pular',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String text, bool isCorrect) {
    final isSelected = _selectedOption == text;
    final color =
        isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.white;
    final borderColor = isSelected ? color : Colors.purple;

    return GestureDetector(
      onTap: () {
        if (_selectedOption == null) {
          setState(() {
            _selectedOption = text;
            _isCorrect = isCorrect;
            // Salva a resposta do usuário na pergunta atual
            questions[_currentQuestionIndex]['userAnswer'] = text;
          });

          // Exibe feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isCorrect ? 'Correto!' : 'Errado!'),
              backgroundColor: isCorrect ? Colors.green : Colors.red,
            ),
          );

          // Avança para a próxima pergunta após um pequeno atraso
          Future.delayed(const Duration(seconds: 1), _nextQuestion);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                softWrap: true,
                maxLines: 3, // ou null para ilimitado
                overflow: TextOverflow.visible,
              ),
            ),
            Icon(
              isSelected
                  ? (isCorrect ? Icons.check_circle : Icons.cancel)
                  : Icons.circle_outlined,
              color: isSelected ? Colors.white : Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  final int completada;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int score;

  const ResultPage({
    super.key,
    required this.completada,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int completada = 0;
  int totalQuestions = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _loadResultData();
  }

  Future<void> _loadResultData() async {
    final userData = await LocalStorage.getUserData();
    setState(() {
      score = userData['score'] ?? widget.score;
      correctAnswers = userData['correctAnswers'] ?? widget.correctAnswers;
      wrongAnswers = userData['wrongAnswers'] ?? widget.wrongAnswers;
      totalQuestions = correctAnswers + wrongAnswers;
      completada = totalQuestions > 0
          ? ((correctAnswers + wrongAnswers) / totalQuestions * 100).toInt()
          : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Topo roxo com círculo de pontos
            Stack(
              children: [
                Container(
                  height: 350,
                  width: 500,
                  margin: EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Botão voltar
                      Positioned(
                        top: 8,
                        left: 8,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      // Círculo de pontos
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: const Color(0xFFE1BEE7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Seus Pontos",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "$score pt",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card branco com sombra
                Positioned(
                  top: 280,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: 320,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "$completada% ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple.shade700),
                                      ),
                                      const TextSpan(
                                        text: "Completada    ",
                                        style: TextStyle(color: Colors.purple),
                                      ),
                                      TextSpan(
                                        text: "$totalQuestions ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple.shade700),
                                      ),
                                      const TextSpan(
                                          text: "Total Questões",
                                          style:
                                              TextStyle(color: Colors.purple)),
                                    ],
                                  ),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${correctAnswers.toString().padLeft(2, '0')} ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 18),
                                      ),
                                      const TextSpan(
                                          text: "Corretas",
                                          style:
                                              TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${wrongAnswers.toString().padLeft(2, '0')} ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 18),
                                      ),
                                      const TextSpan(
                                          text: "Incorretas",
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),

            // Botão circular central
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: const Color.fromARGB(255, 1, 84, 172),
                      padding: const EdgeInsets.all(24),
                      elevation: 4,
                    ),
                    child: const Icon(Icons.refresh,
                        color: Colors.white, size: 36),
                  ),
                  const SizedBox(height: 8),
                  const Text("Jogar Novamente", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const Spacer(),

            // Barra inferior com ícones
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye,
                            color: Color(0xFFBCA16B), size: 32),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RankingPage()),
                          );
                        },
                      ),
                      const Text("Ranking",
                          style: TextStyle(color: Color(0xFFBCA16B))),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.person,
                            color: Colors.purple, size: 32),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          );
                        },
                      ),
                      const Text("Home",
                          style: TextStyle(color: Colors.purple)),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share,
                            color: Color(0xFF5C6BC0), size: 32),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Compartilhar Resultados"),
                                content: const Text(
                                    "Deseja compartilhar seus resultados?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Compartilhar usando share_plus
                                      Share.share(
                                        'Confira meu resultado no IT Genius! 💡\n'
                                        'Pontuação: $score pt\n'
                                        'Corretas: $correctAnswers\n'
                                        'Incorretas: $wrongAnswers\n'
                                        'Baixe o app e desafie-se também!',
                                        subject: 'Meu resultado no IT Genius',
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Compartilhar"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const Text("Share",
                          style: TextStyle(color: Color(0xFF5C6BC0))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<Map<String, dynamic>> rankings = [];

  @override
  void initState() {
    super.initState();
    _loadRanking();
  }

  Future<void> _loadRanking() async {
    final data = await LocalStorage.getRankingData();
    setState(() {
      rankings = List<Map<String, dynamic>>.from(data)
        ..sort((a, b) => b['score'].compareTo(a['score']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EAFE),
      body: SafeArea(
        child: Column(
          children: [
            // Topo roxo com coroa e botão voltar
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 8,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Icon(
                            Icons.emoji_events,
                            color: Colors.amber.shade400,
                            size: 64,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card branco com lista de ranking
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: rankings.isEmpty
                        ? const Center(child: Text("Nenhum ranking disponível"))
                        : ListView.separated(
                            padding: const EdgeInsets.only(
                                top: 32, left: 16, right: 16, bottom: 16),
                            itemCount: rankings.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final item = rankings[index];
                              final position =
                                  (index + 1).toString().padLeft(2, '0');
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        position,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          item["name"],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: Text(
                                        "${item['score']}pt",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, this.title = 'WebView'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: WebViewWidget(
        controller: WebViewController()..loadRequest(Uri.parse(url)),
      ),
    );
  }
}

class LocalStorage {
  static Future<void> saveUserData(String name, String email, String password,
      int score, int correctAnswers, int wrongAnswers) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userEmail', email);
    await prefs.setString('userPassword', password);
    await prefs.setInt('userScore', score);
    await prefs.setInt('correctAnswers', correctAnswers);
    await prefs.setInt('wrongAnswers', wrongAnswers);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName') ?? 'Usuário';
    final email = prefs.getString('userEmail') ?? '';
    final password = prefs.getString('userPassword') ?? '';
    final score = prefs.getInt('userScore') ?? 0;
    final correctAnswers = prefs.getInt('correctAnswers') ?? 0;
    final wrongAnswers = prefs.getInt('wrongAnswers') ?? 0;

    return {
      'name': name,
      'userEmail': email,
      'userPassword': password,
      'score': score,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
    };
  }

  static Future<List<Map<String, dynamic>>> getRankingData() async {
    final prefs = await SharedPreferences.getInstance();
    final ranking = prefs.getStringList('ranking') ?? [];
    return ranking.map((item) {
      final parts = item.split('|');
      return {
        'name': parts[0],
        'score': int.parse(parts[1]),
      };
    }).toList();
  }

  static Future<void> saveRankingData(String name, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final ranking = prefs.getStringList('ranking') ?? [];
    ranking.add('$name|$score');
    await prefs.setStringList('ranking', ranking);
  }
}
