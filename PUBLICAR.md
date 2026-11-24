# Como colocar o DATA CENTER no ar com o GitHub

Resultado: o site fica num endereço do tipo `https://SEU-UTILIZADOR.github.io/datacenter/`, aberto em qualquer
navegador e instalável como aplicativo. Cada pessoa entra com o seu Gmail e depois com o nome e a senha do cadastro.

O GitHub guarda apenas o site. Os dados (pagamentos, chats, ficheiros) ficam no Firebase, protegidos pelas regras
de `firestore.rules`. O plano gratuito de ambos chega para começar.

## A. Criar o repositório no GitHub (sem instalar nada)
1. Crie uma conta em https://github.com/signup (se já tiver, entre).
2. Clique em **+** (canto superior direito) e depois em **New repository**.
3. Em *Repository name* escreva `datacenter`. Escolha **Public** (o GitHub Pages gratuito exige repositório público).
   Clique em **Create repository**.
4. Na página do repositório clique em **uploading an existing file**.
5. Abra a pasta `datacenter` deste pacote e **arraste todo o conteúdo** (ficheiros e a pasta, se houver) para a página.
   Se não conseguir arrastar os ficheiros que começam por ponto (`.nojekyll`, `.gitignore`), pode deixá-los de fora.
6. Em baixo, clique em **Commit changes**.

*Alternativa automática (Windows):* instale o Git e o GitHub CLI, depois execute `publicar.bat`. Em Mac/Linux, execute
`publicar.sh`. Ambos criam o repositório, enviam os ficheiros e activam o Pages.

## B. Preparar a base de dados (Firebase)
1. Abra https://console.firebase.google.com e clique em **Criar projecto** (plano gratuito Spark).
2. **Authentication** > **Sign-in method** > **Google** > activar.
3. **Firestore Database** > **Criar base de dados** > modo de **produção**.
4. No separador **Regras** do Firestore, apague tudo, cole o conteúdo de `firestore.rules` e clique em **Publicar**.
5. Crie o seu acesso de proprietário: no Firestore inicie a colecção `roles` e crie um documento cujo ID é o **seu
   Gmail em minúsculas**, com o campo `level` (texto) = `owner`. Para cada administrador, outro documento com o Gmail
   dele e `level` = `admin`. Os clientes não precisam deste passo.
6. **Definições do projecto** (engrenagem) > **As suas aplicações** > ícone **Web (</>)** > registe a aplicação e copie
   o `firebaseConfig`.
7. No GitHub, abra o ficheiro `config.js` do repositório, clique no lápis (**Edit**), cole cada valor no lugar de
   `COLE_AQUI` e clique em **Commit changes**.

## C. Activar o site (GitHub Pages)
1. No repositório: **Settings** > **Pages**.
2. Em *Build and deployment* escolha **Deploy from a branch**, *Branch*: `main`, pasta `/ (root)` e clique em **Save**.
3. Espere 1 a 2 minutos e actualize a página: aparece o endereço `https://SEU-UTILIZADOR.github.io/datacenter/`.
4. Volte ao Firebase: **Authentication** > **Settings** > **Authorized domains** > **Adicionar domínio** e escreva
   `SEU-UTILIZADOR.github.io` (sem `https://` e sem o nome do repositório).

## D. Primeiro acesso
1. Abra o endereço, clique em **Entrar com Google (Gmail)** e use o Gmail do proprietário.
2. Escolha **Entrar como administrador** e use o nome do administrador principal e a senha (vazia se ainda não definiu;
   depois use **Alterar senha**).
3. Em **Utilizadores** cadastre clientes e administradores. Em **Definições > Partilhar acesso** gera os convites com
   o link e o código QR.

## E. Instalar como aplicativo
- Computador (Chrome ou Edge): ícone **Instalar** na barra de endereço.
- Android (Chrome): menu ⋮ > **Instalar aplicação**. iPhone (Safari): Partilhar > **Adicionar ao ecrã principal**.

## F. Actualizar o site no futuro
No repositório, abra o ficheiro a mudar, clique no lápis (**Edit**) e depois em **Commit changes**; ou use
**Add file > Upload files** para enviar uma versão nova de `index.html`. O site actualiza em 1 a 2 minutos.

## Notas importantes
- O código do site é público; os dados não. Nunca escreva senhas nos ficheiros do repositório.
- Ficheiros de trabalhos (até 10 MB) são guardados em blocos no Firebase; cada ficheiro grande gasta leituras e escritas
  do plano gratuito. Com muitos ficheiros grandes, considere o plano pago do Firebase.
- Domínio próprio (por exemplo, datacenter.co.mz): Settings > Pages > Custom domain.
- Se algo falhar: "Falta configurar" = passo B7; janela do Google com erro de domínio = passo C4; dados em branco =
  passo B4; Gmail não reconhecido como administrador = passo B5 (letras minúsculas).
