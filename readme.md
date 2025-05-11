# 📱 EventsApp Flutter

Una aplicación móvil desarrollada en **Flutter + Riverpod** para visualizar, filtrar, y gestionar eventos urbanos. Incluye autenticación, favoritos, detalles de eventos, calendario interactivo y más.
---

## ✍️ Autor

Desarrollado por @nayvilla
Proyecto académico y funcional para exploración de eventos.
---

## 🎥 Video de Funcionamiento

Aquí puedes ver una demostración completa de cómo funciona la aplicación:

👉 
---

## 🔧 Tecnologías

- **Flutter 3.x**
- **Riverpod 2.x**
- **REST API** (Glitch o Localhost)
- **Table Calendar**
- **HTTP**
- **State Management con MVVM**
---

## 📂 Estructura del proyecto
```bash
lib/
├── assets/ # Recursos gráficos y estáticos
├── core/ # Configuración global y providers (tema, API, etc.)
├── data/ # Lógica de conexión (datasources + repositories)
├── models/ # Modelos de datos (UserModel, EventModel)
├── routes/ # Definición de rutas de navegación
├── viewmodels/ # ViewModels usando patrón MVVM con Riverpod
├── views/ # Vistas principales (Home, Login, Registro, etc.)
├── widgets/ # Widgets reutilizables (cards, loaders, etc.)
└── main.dart # Punto de entrada de la app
```
---

## 🌐 API REST

La app se conecta a un backend REST que puedes cambiar fácilmente en:

```dart
// lib/core/constants/api_constants.dart

enum Environment { local, production }

class ApiConfig {
  static const Environment env = Environment.production;

  static String get baseUrl {
    switch (env) {
      case Environment.local:
        return 'http://localhost:3000';
      case Environment.production:
        return 'https://ivory-cyclic-colby.glitch.me';
    }
  }
}
```
---

## 🔗 Repositorio del backend
https://github.com/nayvilla/Backend-EventsApp
---

## 🧪 Funcionalidades

✅ Autenticación (Login, Registro)

✅ Vista de eventos con categorías, buscador y destacados

✅ Vista de detalle con toda la información de un evento

✅ Agregar y consultar favoritos por usuario

✅ Calendario interactivo con eventos del día

✅ Soporte de múltiples temas (Viu, Claro, Oscuro)

✅ Navegación estructurada con rutas nombradas

✅ Arquitectura MVVM desacoplada
---

## 🚀 ¿Cómo ejecutar?

1. Clona este repositorio:

```bash
git clone https://github.com/tu_usuario/EventsApp.git
cd EventsApp
```

2. Instala dependencias:

```bash
flutter pub get
```

3. Lanza el proyecto:

```bash
flutter run
```
---
