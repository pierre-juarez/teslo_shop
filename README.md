# teslo_shop

App for Teslo Shop, a shop that sells Tesla products. 🚀

# 🧼 Linter y Análisis Estático en Flutter

Este proyecto utiliza un archivo personalizado `analysis_options.yaml` para aplicar reglas de estilo y buenas prácticas en el código Dart/Flutter.

---

## 📄 ¿Qué es `analysis_options.yaml`?

Es un archivo de configuración donde definimos reglas de lint (estilo de código), que ayudan a mantener el código:

- Limpio
- Legible
- Consistente
- Evitando errores comunes

Ejemplo de reglas activas:

```yaml
linter:
  rules:
    - prefer_single_quotes # Usa comillas simples en vez de dobles
    - require_trailing_commas # Requiere comas al final de estructuras multilínea
    - prefer_final_locals # Usa `final` en variables locales inmutables
    - prefer_const_constructors # Usa constructores const donde sea posible
    - unnecessary_brace_in_string_interps # Evita llaves innecesarias en interpolación
```

Puedes ver el listado completo en el archivo `analysis_options.yaml`.

---

## 📊 ¿Cómo analizar el código?

Para revisar tu código buscando advertencias o errores que violen las reglas:

```bash
flutter analyze
```

Esto mostrará todos los **warnings** y **errores** estáticos en tu proyecto.

---

## 🛠️ ¿Cómo corregir automáticamente los problemas?

Dart ofrece una herramienta para aplicar fixes automáticamente. Simplemente ejecuta:

```bash
dart fix --apply
```

Si quieres ver primero qué cambios se harán:

```bash
dart fix --dry-run
```

---

## ✅ Workflow recomendado

```bash
flutter clean
flutter pub get
flutter analyze
dart fix --apply
```

Esto asegura que tu código esté bien formateado, libre de errores y siguiendo buenas prácticas.

---

¡Listo! Con esto mantendrás tu proyecto en buena forma y tu código más profesional 😎.
