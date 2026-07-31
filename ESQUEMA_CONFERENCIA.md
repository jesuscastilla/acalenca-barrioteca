# Barrioteca Acalenca - Esquema para Conferencia

Este documento sirve como guion para presentar el proyecto de la Barrioteca Acalenca, una biblioteca vecinal autogestionada en Salobrena (Granada).

---

## 1. Que es la Barrioteca Acalenca

- Biblioteca vecinal autogestionada de forma horizontal.
- Espacio perteneciente a Lebeche, asociacion cultural y vecinal de Salobrena.
- Cualquier vecina puede asociarse, llevarse libros en prestamo y devolverlos cuando termine de leerlos.
- Sin dependencia de servidores externos: todo el sistema funciona con **software libre** (SLiMS + PWA) alojado en un NAS Synology propio.
- No se ceden datos a terceros. Privacidad total.

---

## 2. Infraestructura tecnica: el NAS Synology

- **Nube local encriptada y autogestionada**: los datos estan en Salobrena, no en servidores de terceros.
- Acceso al panel de administracion (DSM) via `https://pelotxo.synology.me:5001`.
- **Synology Drive**: sincronizacion de archivos entre dispositivos (como Dropbox, pero local).
- **Servidor Multimedia**: fotos, peliculas, musica accesibles desde cualquier dispositivo de la red.
- **Calendario comun compartido**: para coordinar eventos, turnos, reuniones.
- Web Station con Nginx + PHP 8 + MariaDB.
- HTTPS con certificado SSL gratuito (Let's Encrypt).

---

## 3. El Backend: SLiMS (Senayan Library Management System)

### Que es SLiMS
- Sistema de gestion bibliotecaria de codigo abierto (version 9 Bulian).
- Adaptado por Peloxi (Instagram: @Pelochochi) para la Barrioteca.

### Que almacena
- Datos de las socias (nombre, ID, fecha de registro, expiracion).
- Catalogo de libros (titulo, autora, editorial, ISBN, portada, sinopsis).
- Ejemplares y su estado (disponible / prestado).
- Historico de prestamos y devoluciones.

### API REST de circulacion
La PWA se comunica con SLiMS a traves de una API interna:

| Endpoint | Funcion |
|----------|---------|
| `/api/v1/member/{id}/verify` | Verificar si una socia existe |
| `/api/v1/item/{isbn}/status` | Consultar disponibilidad de un libro |
| `/api/v1/loan/borrow` | Registrar un prestamo |
| `/api/v1/loan/return` | Registrar una devolucion |
| `/api/v1/biblio/search` | Buscar en el catalogo |
| `/api/v1/member/{id}/loans` | Ver mis prestamos activos |

### Scripts de importacion de libros

| Script | Funcion |
|--------|---------|
| `importar-csv.php` | Importacion masiva desde archivo CSV con ISBNs (por lotes de 3) |
| `anadir-libro.php` | Busqueda por titulo/autor en APIs o formulario manual, para libros sin ISBN. Genera etiqueta con codigo de barras imprimible. |
| `importar-isbns.php` | Pegar una lista de ISBNs y anadirlos uno a uno |

---

## 4. El Frontend: PWA (Progressive Web App)

### Que es la PWA
- Aplicacion web que funciona desde el navegador del movil, sin necesidad de instalar nada desde una tienda.
- Se puede instalar como app nativa en la pantalla de inicio (Android e iOS).
- Tecnologia: React 19 + TypeScript + Vite + Tailwind CSS.

### Como funciona la autogestion
1. **Alta de socias**: La administracion crea la ficha de la vecina en SLiMS y le asigna un ID unico (ej. `SOCIA-001`).
2. **Identificacion**: La socia introduce su ID en la PWA desde su movil.
3. **Prestamo**: Escanea el codigo de barras del libro (ISBN, ASIN o etiqueta `LIB-XX`).
4. **Devolucion**: Escanea el mismo codigo al devolver el libro.
5. **Catalogo**: Cualquier socia puede buscar libros por titulo, autora o ISBN.

### Libros sin ISBN
La PWA soporta tres metodos para libros que no tienen codigo de barras comercial:
- **Escanear etiqueta**: La administracion imprime una etiqueta con codigo `LIB-XX` generada por `anadir-libro.php` y la pega en el libro.
- **Entrada manual**: Campo de texto en la vista de escaneo para escribir el codigo.
- **Boton "Pedir" en catalogo**: Buscar el libro por titulo y pulsar "Pedir" directamente.

---

## 5. Estado actual y proximos pasos

### A. Terminar de anadir todos los libros al catalogo
- Seguir usando los scripts de importacion para completar la coleccion.
- Priorizar libros sin ISBN con `anadir-libro.php`.
- Imprimir y pegar etiquetas con codigo de barras en cada libro fisico.

### B. Conseguir los logotipos en formato vectorial
- Necesitamos los logotipos de la Barrioteca en formato vectorial (SVG, EPS o AI).
- Para usar en la app (icono, splash screen, cabecera) y en materiales impresos (carteles, etiquetas).

### C. Socias apuntarse como beta testers en grupo de WhatsApp
- Crear un grupo de WhatsApp para las vecinas que quieran probar el sistema.
- Recoger feedback sobre la experiencia de uso.
- Detectar posibles errores o mejoras antes del lanzamiento oficial.

### D. Fecha prevista de lanzamiento
- **Septiembre**: objetivo para tener todo funcionando y abrir el servicio a todas las socias.

---

## 6. Conclusion y preguntas

- La Barrioteca Acalenca es un proyecto de **autogestion vecinal** que combina tecnologia libre con organizacion horizontal.
- El sistema ya esta funcionando: backend SLiMS, PWA instalable, escaneo de codigos, catalogo, prestamos y devoluciones.
- Los datos estan en Salobrena, en un NAS propio, sin dependencia de servicios externos.
- Quedan tareas por completar (catalogo, logotipos, beta testers) con fecha objetivo en septiembre.
- Abrir turno de preguntas.