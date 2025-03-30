# 🎮 Cinemapedia

**Cinemapedia** es una aplicación desarrollada en Flutter que te permite explorar un extenso catálogo de películas. Encuentra tus favoritas, descubre las más populares del momento, consulta estrenos, películas mejor calificadas y recibe recomendaciones. Además, puedes guardar tus favoritas y ver el reparto completo de cada película.

---

## 🚀 Características

- 🔎 Buscar tu película favorita.
- 📈 Ver películas populares en tiempo real.
- 🗓️ Explorar próximos estrenos.
- 🌟 Consultar las películas mejor calificadas de la historia.
- 🎯 Recibir recomendaciones personalizadas.
- ❤️ Agregar películas a tu lista de favoritas.
- 👨‍🎤 Ver los actores que participaron en cada película.

---

## 💪 Tecnologías y dependencias

- **Flutter** (SDK ^3.5.0)
- **Dart**
- **Riverpod**
- **Isar** (Base de datos local)
- **GoRouter**
- **Dio** (Consumo de API)

**Dependencias utilizadas:**

```yaml
dependencies:
  animate_do: ^3.3.4
  card_swiper: ^3.0.1
  dio: ^5.7.0
  flutter:
    sdk: flutter
  flutter_dotenv: ^5.2.1
  flutter_riverpod: ^2.6.1
  flutter_staggered_grid_view: ^0.7.0
  go_router: ^14.3.0
  intl: ^0.20.1
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.5

dev_dependencies:
  build_runner: 2.4.13
  flutter_lints: ^4.0.0
  flutter_test:
    sdk: flutter
  isar_generator: ^3.1.0+1
```

---

## 📆 Instalación y configuración

1. **Clona el repositorio:**

```bash
git clone https://github.com/tu-usuario/cinemapedia.git
cd cinemapedia
```

2. **Instala las dependencias:**

```bash
flutter pub get
```

3. **Configura tu archivo de entorno:**

- Copia el archivo `.env.template` y renómbralo como `.env`.
- Reemplaza la variable `TMDB` con tu propia API Key de TheMovieDB.

4. **Genera los archivos de Isar:**

```bash
dart run build_runner build
```

5. **¡Ejecuta la app!**

```bash
flutter run
```

---

## 🧪 Requisitos

- Flutter SDK ^3.5.0
- Dart
- Emulador o dispositivo físico android/ios para pruebas

---



## ✍️ Autor

Hecho con 🎮 por **Daniel pachper**
