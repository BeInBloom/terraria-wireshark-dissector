# terraria-wireshark-dissector

Wireshark Lua dissector for the Terraria multiplayer protocol.

## Project structure

```text
src/terraria/
├── dissector.lua
├── fields.lua
└── packet/
    ├── builders/
    │   └── init.lua
    ├── readers/
    │   ├── byte_reader.lua
    │   ├── chest_reader.lua
    │   ├── color_reader.lua
    │   ├── item_data_reader.lua
    │   ├── network_text_reader.lua
    │   ├── npc_update_reader.lua
    │   ├── particle_orchestra_reader.lua
    │   ├── player_death_reason_reader.lua
    │   ├── projectile_update_reader.lua
    │   ├── send_tile_square_reader.lua
    │   ├── sign_reader.lua
    │   ├── string_reader.lua
    │   ├── tile_entity_extra_reader.lua
    │   ├── tile_entity_reader.lua
    │   ├── tile_reader.lua
    │   ├── update_item_drop_reader.lua
    │   ├── update_player_reader.lua
    │   └── vector2_reader.lua
    ├── context.lua
    ├── packet_catalog.lua
    ├── payload_dissector.lua
    ├── payload_reader.lua
    └── types.lua
```

- `context.lua` describes the packet header and payload range.
- `byte_reader.lua` owns the payload cursor and reads primitive values.
- Other readers decode compound Terraria values using the same `ByteReader`.
- `payload_reader.lua` reads named payload fields and adds them to the Wireshark tree.
- `builders/init.lua` maps packet IDs to payload builder functions.
- `types.lua` contains protocol data types returned by readers.

A builder accepts one `PayloadReader`:

```lua
local function build(payload)
	payload:int16_le(some_field)
end
```

A compound reader is a class sharing the builder's `ByteReader`:

```lua
local chest_reader = chest.new(payload.reader)
local chest_value, chest_range = chest_reader:read()
```
