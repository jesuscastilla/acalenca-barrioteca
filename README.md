# Barrioteca Acalencá

Biblioteca vecinal autogestionada de Salobreña (Granada). Sistema de préstamos y catálogo con software libre: **SLiMS** (backend PHP/MariaDB) + **PWA** (frontend React/TypeScript) + **App Android** (Trusted Web Activity).

---

## Repositorios

Este es el **monorepo de documentación**. El código fuente está en repos separados:

| Repositorio | Descripción | URL |
|------------|-------------|-----|
| **PWA (Frontend)** | React 19 + Vite + Tailwind + TypeScript | [github.com/jesuscastilla/acalenca-barrioteca-app](https://github.com/jesuscastilla/acalenca-barrioteca-app) |
| **SLiMS (Backend)** | SLiMS 9.7.2 + API REST (PHP/MariaDB) | [github.com/jesuscastilla/acalenca-barrioteca](https://github.com/jesuscastilla/acalenca-barrioteca) |
| **Monorepo (docs)** | Documentación, guías, app Android | [github.com/jesuscastilla/acalenca-barrioteca-completo](https://github.com/jesuscastilla/acalenca-barrioteca-completo) |

---

## Arquitectura

```
+------------------------------------------------------+
|                https://pelotxo.synology.me            |
|                   NAS Synology                        |
|                                                       |
|  /barrioteca/          /slims/                        |
|  +----------------+   +------------------------+      |
|  | PWA (React)    |-->| SLiMS API (PHP)        |      |
|  | api-proxy.php  |   | api/index.php          |      |
|  | manifest.json  |   | CirculationController  |      |
|  | sw.js          |   | BiblioController       |      |
|  | icon*.png      |   | MariaDB                |      |
|  +----------------+   +------------------------+      |
|                                                       |
|  App Android (.apk) ---> https://pelotxo.synology.me  |
|       (Trusted Web Activity)                          |
+------------------------------------------------------+
```

- La PWA se comunica con la API de SLiMS mediante un proxy PHP (`api-proxy.php`)
- La app Android usa **Trusted Web Activity** para abrir la PWA en pantalla completa sin barra de navegación
- Todo se aloja en un NAS Synology autogestionado, sin servidores externos
- **HTTPS obligatorio** (Let's Encrypt desde Synology) para que PWA y Service Workers funcionen

---

## App Android

La PWA se ha convertido en una **app Android nativa** (`.apk` y `.aab`) mediante [PWABuilder](https://pwabuilder.com).

### Datos técnicos

| Dato | Valor |
|------|-------|
| Package ID | `barrioteca.app.pelotxo` |
| minSdkVersion | 23 (Android 6.0) |
| targetSdkVersion | 35 |
| URL | `https://pelotxo.synology.me/barrioteca` |
| Tipo | Trusted Web Activity (Chrome Custom Tab) |
| Cámara | Si (escáner de códigos de barras ISBN/ASIN) |

### Actualizar la app

La app Android carga la web en vivo, por lo que **no necesita actualizaciones manuales**. Si modificas la PWA en el NAS, los cambios se reflejan automáticamente en la app.

Para publicar una nueva versión en Google Play, consulta [`GUIA_APK.md`](GUIA_APK.md).

### Archivos de la app

| Archivo | Descripción |
|---------|-------------|
| `Barrioteca Acalencá.apk` | APK firmada para instalar directamente |
| `Barrioteca Acalencá.aab` | Android App Bundle para Google Play |
| `signing.keystore` | Certificado de firma (no perder) |
| `signing-key-info.txt` | Contraseñas del keystore |

> AVISO: Los archivos `.apk`, `.aab`, `.keystore` y `signing-key-info.txt` **no se suben a GitHub** (`.gitignore`). Guárdalos en local y haz copia de seguridad.

---

## Despliegue rápido

Ver [`PWA/DEPLOYMENT_GUIDE.md`](https://github.com/jesuscastilla/acalenca-barrioteca-app) para despliegue detallado.

### PWA (producción en NAS)

```bash
cd PWA
npm install
cp api-config.example.php api-config.php   # Configurar Google Books API key + SLiMS URL
npm run build
# Subir dist/ y api-proxy.php a /barrioteca/ en el NAS
```

### SLiMS (backend)

SLiMS se instala en `/slims/` del NAS siguiendo la [guía de instalación en Synology](SLiMS/MANUAL_INSTALL_SYNOLOGY.md).

---

## Funcionalidades

- **Catálogo público**: Todos los libros con portada, sinopsis y metadatos
- **Escáner de ISBN**: Usa la cámara del móvil para escanear códigos de barras
- **Identificación de socias**: Cada socia tiene un ID único
- **Préstamos y devoluciones**: Autogestión desde el móvil
- **Libros sin ISBN**: Etiquetas imprimibles con código `LIB-XX`
- **Dashboard personal**: "Mis préstamos" con fechas de vencimiento

---

## Tecnología

| Componente | Stack |
|-----------|-------|
| Frontend PWA | React 19, TypeScript, Vite, Tailwind CSS 4, html5-qrcode |
| Backend | SLiMS 9.7.2 (PHP 8), MariaDB, API REST |
| Proxy PHP | api-proxy.php (cURL a SLiMS API) |
| Android | Trusted Web Activity (PWABuilder) |
| Infraestructura | NAS Synology, Nginx, Let's Encrypt, PHP-FPM |

---

## Documentación

| Archivo | Contenido |
|---------|-----------|
| [`CONTEXT.md`](CONTEXT.md) | Contexto completo del proyecto (arquitectura, bugs, flujo de trabajo) |
| [`GUIA_APK.md`](GUIA_APK.md) | Guía paso a paso para generar la APK y publicar en Google Play |
| [`ESQUEMA_CONFERENCIA.md`](ESQUEMA_CONFERENCIA.md) | Esquema de conferencia/taller sobre la Barrioteca |
| `barrioteca-android-app/assetlinks.json` | Digital Asset Links para Trusted Web Activity |

---

## Créditos

Desarrollado por **Peloxi** ([@Pelochochi](https://instagram.com/Pelochochi)) para la **Barrioteca Acalencá**, espacio perteneciente a **Lebeche**, asociación cultural y vecinal de Salobreña (Granada).

---

## Licencia

[GNU General Public License v3.0](LICENSE) — Software libre para una biblioteca libre.