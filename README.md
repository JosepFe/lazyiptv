# lazyiptv

Navegador de IPTV para la terminal, al estilo de [lazygit](https://github.com/jesseduffield/lazygit): TV en directo, películas y series con grupos, lista y ficha, y `Enter` para verlo en [mpv](https://mpv.io).

Pensado para listas grandes: con cuentas **Xtream Codes** usa la API del proveedor en lugar de descargar la lista M3U entera, así que arranca en segundos aunque la lista tenga cientos de miles de entradas.

```
  1 TV   2 Películas   3 Series    s Buscar en todo                              Principal
┌ Películas · Grupos ─────┐┌ Todas las películas (30916) ────┐┌ Ficha ───────────────────┐
│   ★ Favoritos           ││   El Padrino (1972)  · 8.7      ││ El Padrino (1972)        │
│   ▶ Seguir viendo       ││ ★ El Padrino II (1974)  · 8.6   ││ 1972 · Drama · ★ 8.7     │
│   ◷ Recientes           ││   …                             ││ Dirección: F. F. Coppola │
│ ★ CINE CASTELLANO       ││                                 ││ Reparto: Marlon Brando…  │
│   Todas las películas   ││                                 ││                          │
│   ESTRENOS 2026         ││                                 ││ Argumento: …             │
└──────────────── 4/53 ───┘└─────────────────────── 1/30916 ─┘└──────────────────────────┘
 ▶ El Padrino (1972)   30916 películas en 49 grupos
 1-3 pestañas · Enter abrir · / filtrar · f favorito · o orden · s buscar · a lista · ? ayuda
```

## Características

- **Tres pestañas**: TV en directo, Películas y Series. Películas y series con **ficha** (año, género, nota, duración, dirección, reparto y argumento).
- **Series por temporadas**: `Enter` sobre una serie muestra sus episodios; al acabar uno, **empieza el siguiente** solo.
- **▶ Seguir viendo**: recuerda por dónde ibas en películas y episodios y continúa desde ahí.
- **◷ Recientes**: lo último que has visto, en cada pestaña.
- **Búsqueda global** (`s`): canales, películas y series a la vez; primero los títulos que empiezan por lo buscado.
- **Favoritos** con `f`: en canales, películas y series los añade a ★ Favoritos; en un grupo lo fija arriba. Por lista y por pestaña.
- **Ordenar** (`o`) por nombre, año, nota o fecha de alta.
- **Varias listas**: cuentas Xtream Codes y listas M3U (enlace o archivo). Se añaden desde el propio programa (tecla `a`). En las M3U, películas y series se reconocen por la URL.
- **Una sola ventana de mpv**: al cambiar de canal se reutiliza la misma ventana (vía IPC), así no se gastan conexiones de la cuenta.
- **Reconexión automática** si el proveedor corta el stream.
- **Filtro** sin tildes ni mayúsculas (`/espa` encuentra «ESPAÑA»).
- **Caché local** (24 h) por pestaña; películas y series solo se descargan al abrir su pestaña.
- Sin dependencias en Linux: solo Python 3 y mpv.

## Requisitos

- Python 3.9 o superior
- [mpv](https://mpv.io) en el `PATH`
- En Windows, además: `pip install windows-curses`

## Instalación

### Linux

```bash
git clone git@github.com:JosepFe/lazyiptv.git
cd lazyiptv
./install.sh          # enlaza lazyiptv y el atajo ltv en ~/.local/bin
```

### Windows (PowerShell)

```powershell
winget install mpv
pip install windows-curses
git clone https://github.com/JosepFe/lazyiptv.git
python lazyiptv\lazyiptv
```

> El soporte de Windows está implementado pero sin probar todavía.

## Uso

```
ltv                 abre la lista (si hay varias, pregunta cuál)
ltv NOMBRE          abre directamente esa lista
ltv add             añade una lista desde la terminal
ltv list            muestra las listas configuradas (sin contraseñas)
```

Para añadir una lista basta con pegar el enlace que da el proveedor. Si es del tipo `get.php?username=…&password=…`, se convierte automáticamente en cuenta Xtream.

### Teclas

| Tecla | Acción |
|---|---|
| `1` `2` `3` | pestañas: TV · Películas · Series |
| `j` `k` / `↑` `↓` | moverse |
| `h` `l` / `←` `→` / `Tab` | cambiar de panel |
| `Enter` | abrir grupo · reproducir · ver episodios de una serie |
| `g` `G` | ir al principio / al final |
| `/` | filtrar el panel (`Esc` borra el filtro) |
| `s` | buscar en todo |
| `f` | canal/película/serie: favorito · grupo: fijarlo arriba |
| `o` | cambiar el orden |
| `i` | mostrar/ocultar la ficha (ventanas estrechas) |
| `a` | cambiar de lista o añadir una nueva |
| `x` | parar el reproductor (guarda por dónde ibas) |
| `r` | recargar la pestaña desde el servidor |
| `?` | ayuda |
| `q` | salir (mpv sigue abierto) |

## Dónde guarda las cosas

| | Linux | Windows |
|---|---|---|
| Listas (incluye credenciales, permisos `600`) | `~/.config/lazyiptv/config.json` | `%APPDATA%\lazyiptv\config.json` |
| Favoritos, grupos fijados e historial | `~/.config/lazyiptv/<lista>/` | `%APPDATA%\lazyiptv\<lista>\` |
| Caché de canales, películas y series | `~/.cache/lazyiptv/<lista>-<pestaña>.json` | `%LOCALAPPDATA%\lazyiptv\` |
| Posiciones de «Seguir viendo» (mpv) | `~/.cache/lazyiptv/watch_later/` | `%LOCALAPPDATA%\lazyiptv\watch_later\` |

Las credenciales nunca se guardan en el repositorio.

Si tienes [IPTVnator](https://github.com/4gray/iptvnator) con una lista Xtream, la primera vez que abras `lazyiptv` se importa automáticamente.

## Licencia

[MIT](LICENSE)
