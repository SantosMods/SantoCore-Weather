# santoscore-weather

santoscore-weather is an open-source weather control script for FiveM, using the [ox_lib](https://overextended.dev/ox_lib/) menu system for an intuitive UI. Designed to integrate cleanly within the modular SantosCore ecosystem, it works standalone or alongside other ox_core-based utilities.

## Features

- Interactive weather control via ox_lib context menus
- Supports all standard GTA V weather types
- Syncs weather changes across all players
- Designed for both standalone and ox_core environments

## Installation

1. Download or clone this repository into your `resources` folder:
   ```bash
   git clone https://github.com/SantosMods/SantoCore-Weather.git
   ```

2. Ensure dependencies are started before this resource in your `server.cfg`:
   ```cfg
   ensure ox_lib
   ensure Badger_Discord_API
   ensure santoscore-weather
   ```

3. Add permissions or bindings as needed in your admin system.

## Configuration

You can modify available weather types and command access in `config.lua`.

## Usage

Use the `/weather` command (or a bound key/command, if configured) to open the ox_lib menu. Select your desired weather and confirm to apply it server-wide.

## Structure

```
santoscore-weather/
├── client/
├── server/
├── shared/
├── config.lua
├── fxmanifest.lua
└── README.md
```

## License

This project is licensed under the MIT License. See [LICENSE](./LICENSE) for details.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change. Contributions should follow SantosCore module conventions.

## Authors

- [SantosMods](https://github.com/SantosMods)
- [CodeX](https://chatgpt.com/codex)

## Acknowledgments

- [ox_lib](https://github.com/overextended/ox_lib) for the menu system
