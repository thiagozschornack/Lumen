# Mantém a ponte JavaScript -> Android usada pelo jogo
-keepclassmembers class br.com.empreenderthz.lumen.MainActivity$LumenBridge {
    @android.webkit.JavascriptInterface <methods>;
}
-keepattributes JavascriptInterface
