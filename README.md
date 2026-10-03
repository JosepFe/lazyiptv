# lazyiptv

Navegador de IPTV para la terminal, al estilo de [lazygit](https://github.com/jesseduffield/lazygit): grupos a la izquierda, canales a la derecha y `Enter` para verlo en [mpv](https://mpv.io).

Pensado para listas grandes: con cuentas **Xtream Codes** usa la API del proveedor en lugar de descargar la lista M3U entera, así que arranca en segundos aunque la lista tenga cientos de miles de entradas.

```
┌ Principal · Grupos ─────────┐┌ ESPAÑA (67) ─────────────────────────────┐
│   ★ Favoritos               ││   LA 1 HD                                │
│ ★ ESPAÑA (67)               ││   LA 2 HD                                │
│ ★ FUTBOL ESPAÑA (74)        ││ ★ 24H                                    │
│ ★ DEPORTES ESPAÑA (54)      ││   ANTENA 3 HD                            │
│   Todos los canales (9460)  ││   …                                      │
│   …                         ││                                          │
└─────────────────── 2/156 ───┘└───────────────────────────────── 3/67 ───┘
 ▶ LA 1 HD   9460 canales en 154 grupos
 Enter abrir · / filtrar · f favorito · a lista · x parar · r recargar · ? ayuda · q salir
```

## Características

- **Varias listas**: cuentas Xtream Codes y listas M3U (enlace o archivo). Se añaden desde el propio programa (tecla `a`).
- **Una sola ventana de mpv**: al cambiar de canal se reutiliza la misma ventana (vía IPC), así no se gastan conexiones de la cuenta.
- **Reconexión automática** si el proveedor corta el stream.
- **Favoritos** de canales y **grupos fijados** arriba, por lista.
- **Filtro** sin tildes ni mayúsculas (`/espa` encuentra «ESPAÑA»). En «Todos los canales» busca en toda la lista.
- **Caché local** de la lista (24 h), para abrir al instante.
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
| `j` `k` / `↑` `↓` | moverse |
| `h` `l` / `←` `→` / `Tab` | cambiar de panel |
| `Enter` | abrir grupo / reproducir canal |
| `g` `G` | ir al principio / al final |
| `/` | filtrar el panel (`Esc` borra el filtro) |
| `f` | en un canal: favorito · en un grupo: fijarlo arriba |
| `a` | cambiar de lista o añadir una nueva |
| `x` | parar el reproductor |
| `r` | recargar la lista del servidor |
| `?` | ayuda |
| `q` | salir (mpv sigue abierto) |

## Dónde guarda las cosas

| | Linux | Windows |
|---|---|---|
| Listas (incluye credenciales, permisos `600`) | `~/.config/lazyiptv/config.json` | `%APPDATA%\lazyiptv\config.json` |
| Favoritos y grupos fijados | `~/.config/lazyiptv/<lista>/` | `%APPDATA%\lazyiptv\<lista>\` |
| Caché de canales | `~/.cache/lazyiptv/<lista>.json` | `%LOCALAPPDATA%\lazyiptv\` |

Las credenciales nunca se guardan en el repositorio.

Si tienes [IPTVnator](https://github.com/4gray/iptvnator) con una lista Xtream, la primera vez que abras `lazyiptv` se importa automáticamente.

## Licencia

[MIT](LICENSE)
