# Invitación Milagros Lozano Rojas — versión editable

Esta carpeta contiene una recreación editable, sin framework ni build: HTML + CSS + JavaScript.

## Qué editar
Abre `EDITAR_AQUI.js`. Ahí puedes cambiar:
- nombre y fecha
- textos
- lugar y Google Maps
- WhatsApp para RSVP
- música
- URLs o archivos de imágenes

## Ver la invitación
Haz doble clic en `index.html`. En modo `remote`, las imágenes se cargan desde las URLs públicas del sitio original.

## Guardar también las imágenes en tu PC
En Windows:
1. Clic derecho en `localize-assets.ps1` > Ejecutar con PowerShell.
2. Si Windows bloquea scripts, abre PowerShell dentro de la carpeta y usa:
   `powershell -ExecutionPolicy Bypass -File .\localize-assets.ps1`
3. El script descarga los assets a `assets/images/` y cambia automáticamente `assetMode` a `local`.

## Música
La página pública muestra un control de sonido, pero la URL del audio no aparece en el contenido indexado que se pudo recuperar. Coloca tu MP3 dentro de `assets/audio/` y en `EDITAR_AQUI.js` usa por ejemplo:
`musicaUrl: "assets/audio/cancion.mp3"`

## Publicar
Puedes subir esta carpeta a cualquier hosting estático, cPanel, GitHub Pages, Netlify o tu propio VPS. No necesita Node ni base de datos.

## Nota técnica
El sitio publicado sirve sus imágenes mediante rutas `/__l5e/assets-v1/...`. Esta versión reconstruye la experiencia visible de forma editable; no contiene el proyecto/fuente privado del editor con el que fue creado.
