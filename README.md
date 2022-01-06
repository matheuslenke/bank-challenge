# Desafio iOS - Mentorias
---

## Olá, fico muito feliz por você participar do meu desafio iOS!

---

## Como será seu desafio

Utilizando a nossa [API](https://bank-statement-bff.herokuapp.com/), você deverá criar uma app que apresente o saldo e as movimentações financeiras de um usuário, uma tela com os detalhes da movimentação selecionada e a opção de compartilhamento do mesmo. O layout deverá ser semelhante ao apresentado neste `README`. Legal, certo?

Pense no desafio como uma oportunidade de mostrar todo o seu conhecimento. Faça-o com calma! Você pode combinar o tempo com nosso time de RH!
Vamos avaliar como você lida com as seguintes situações:

- Consumo de APIs;
- Construção de Layout a partir de um modelo de tela;
- Persistência de dados (Ocultar saldo);
- Estruturação de layout;
- Lógicas de apresentação de variações de layout;
- Fluxo da aplicação.

Os pré-requisitos são: 

1. que o código seja feito em Swift, de preferência na versão mais atual, dando suporte a iOS 13.0.0+.
1. que você siga nossa [Style Guide](https://github.com/micheltlutz/ml-swift-styleguide). 

Fora isso, sinta-se a vontade para:

- Usar ou não usar bibliotecas;
- Estruturar seu layout com storyboards, xibs ou ViewCode (ViewCode será um diferencial);
- Adotar a arquitetura de visualização (Pattern) que você quiser.

A qualidade muito importante se você conseguir crie testes automatizados. Entretanto, sei que não é um tópico dominado por todos, por isso aceito desafios com todos os perfis e diferentes momentos de experiência e conhecimento técnico.

---

## Features

* Tratamento de erros e apresentação de: Error generico, loading;
* Buscar saldo da rota `myBalance`;
* Ao tocar no ícone de olho do saldo, o mesmo deve ser escondido e apresentado conforme modelo de tela anexado.
 * 	OBS: Esta flag deverá ser persistida.
* Buscar lista de itens do extrato da rota `myStatement` com paginação de 10 itens por request(scroll infinito);
* Ao tocar em um item do extrato deverá abrir uma tela de detalhes.
* A tela de detalhes deverá consumir a rota de `myStatement/detail` informando o `id` do item selecionado como parâmetro;
* Ao tocar no botão de compartilhar, deverá ser compartilhada a imagem da área de informações do comprovante abrindo a alert padrão do iOS.

---

## Api

[Documentação](https://bank-statement-bff.herokuapp.com)

Seu token deve ser enviado no header de todas as requisições como header param `token`

Token: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c`

---

## Layout

![ColorPallet](assets/CollorPallet.png)


<img src="assets/iPhone X, XS, 11 Pro – 1.png"
alt="" width="375" height="812" border="1" /> | <img src="assets/iPhone X, XS, 11 Pro – 2.png"
alt="" width="375" height="812" border="1" />

<img src="assets/iPhone X, XS, 11 Pro – 3.png"
alt="" width="375" height="812" border="1" /> | <img src="assets/iPhone X, XS, 11 Pro – 4.png"
alt="Compartilhamento" width="375" height="812" border="1" />

### Imagem a ser compartilhada:

<img src="assets/Compartilhar.png"
alt="Comprovante" width="375" height="562" border="1" />

---

## Processo de submissão

Depois de implementar a solução, envie um Pull Request para este repositório. O processo de Pull Request funciona da seguinte maneira:

Faça um fork deste repositório (não clonar direto!);
Faça seu projeto neste fork;
Commit e suba as alterações para o SEU fork;
Pela interface do Github, envie um Pull Request;
Deixe o fork público para facilitar a inspeção do código.

:exclamation: **ATENÇÃO** :exclamation:

Não tente fazer o PUSH diretamente para ESTE repositório!

## Copyright

Copyright ícones: [zondicons](https://www.iconfinder.com/iconsets/zondicons)