# LUMEN — app Android

Projeto Android nativo do **LUMEN — Os Guardiões dos Mundos Perdidos** (EmpreenderTHZ Games), Versão 2 do jogo (Mundo 1 completo, com o guardião Raizeiro).

- Pacote: `br.com.empreenderthz.lumen`
- Versão do app: 2.0.0 (versionCode 1)
- Android 7.0 ou mais novo (minSdk 24), alvo Android 16 (targetSdk 36)
- Funciona **100% offline**: o jogo, o Three.js e as fontes estão dentro do app. O app não pede nenhuma permissão.

## O que foi adaptado para Android

- Tela cheia imersiva, em paisagem, com a tela sempre acesa durante o jogo e suporte a notch e câmera frontal.
- Botão/gesto **voltar**: na partida, pausa; nos menus, volta à tela anterior; no diálogo, pula a cena; na tela inicial, avisa "toque em voltar de novo para sair".
- Ao sair do app ou receber uma ligação, o jogo pausa sozinho, salva o progresso e silencia o som.
- Botão **Sair do jogo** na tela inicial (só aparece no app).
- Menus refeitos para caber em celular deitado (menu inicial em duas colunas, painéis compactos).
- Progresso salvo no aparelho e incluído no backup do Google.
- Controle (gamepad) e teclado Bluetooth continuam funcionando.

## Como gerar o APK

### Opção 1 — Android Studio (no seu computador)

1. Instale o Android Studio (versão de 2025 ou mais nova).
2. **File → Open** e escolha a pasta `LUMEN-Android`. Espere a sincronização do Gradle terminar.
3. Para testar no celular: ative a depuração USB, conecte e clique em **Run ▶**.
4. Para gerar o arquivo: **Build → Generate App Bundles or APKs → Generate APKs**. O APK fica em `app/build/outputs/apk/debug/`.

### Opção 2 — GitHub (sem instalar nada)

1. Crie um repositório no GitHub e envie esta pasta inteira.
2. Abra a aba **Actions**: o fluxo **Build Android** roda sozinho a cada envio para `main`.
3. No fim da execução, baixe o artefato **LUMEN-debug-apk** e instale no celular.

## Publicar na Google Play

A Play exige um pacote **.aab assinado**.

1. Crie a chave de assinatura (uma vez só; **guarde o arquivo e as senhas**: sem eles você não consegue atualizar o app):
   ```
   keytool -genkeypair -v -keystore lumen-release.jks -alias lumen -keyalg RSA -keysize 2048 -validity 10000
   ```
2. Crie o arquivo `keystore.properties` na raiz do projeto (ele não vai para o Git):
   ```
   storeFile=lumen-release.jks
   storePassword=SUA_SENHA
   keyAlias=lumen
   keyPassword=SUA_SENHA
   ```
3. Gere: `./gradlew bundleRelease` (ou **Build → Generate Signed App Bundle** no Android Studio). O arquivo sai em `app/build/outputs/bundle/release/app-release.aab`.

Pelo GitHub: cadastre em **Settings → Secrets and variables → Actions** os secrets `KEYSTORE_BASE64` (resultado de `base64 -w0 lumen-release.jks`), `KEYSTORE_PASSWORD`, `KEY_ALIAS` e `KEY_PASSWORD`. O fluxo passa a gerar também o artefato **LUMEN-release-aab**.

Na Play Console: use `store/play-store-icon-512.png` como ícone da loja, a capa do jogo como base da arte de destaque (1024×500) e classifique a faixa etária pelo questionário IARC. Por ser um app que não coleta dados, a seção "Segurança dos dados" pode declarar que nenhum dado é coletado ou compartilhado.

## Atualizar o jogo

O jogo fica em `app/src/main/assets/www/index.html`. Para uma nova versão:

1. Substitua o `index.html` pela versão nova, mantendo as linhas que carregam `three.min.js` e `fonts/fonts.css` (em vez dos endereços da internet) e o bloco **ANDROID** do script.
2. Aumente `versionCode` (ex.: 2) e `versionName` em `app/build.gradle.kts`.
3. Gere um novo `.aab` com a mesma chave.

## Estrutura

```
app/src/main/assets/www/      jogo (index.html, three.min.js, fonts/)
app/src/main/java/.../MainActivity.java   WebView em tela cheia + botão voltar
app/src/main/res/             ícones, tema e tela de abertura
.github/workflows/android.yml build automático
store/                        ícone 512×512 para a Play Store
```

Licenças de terceiros incluídas: Three.js r149 (MIT, `three-LICENSE.txt`), Grandstander e Atkinson Hyperlegible (SIL OFL, pasta `fonts/`).
