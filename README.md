# terraria-wireshark-dissector

Lua dissector for the Terraria multiplayer protocol in Wireshark.

## What it does

- decodes Terraria packets into a Wireshark tree;
- splits packet parsing into small readers and builders;
- supports runtime validation on captured traffic.

## Install

```sh
make install
```

By default this installs into:

`~/.local/lib/wireshark/plugins`

## Check

```sh
make check-lua
```

## Runtime check

Run the dissector against a capture:

```sh
make runtime-check PCAP=test_data/terraria.pcap
```

## Project layout

```text
src/terraria/
├── dissector.lua
├── fields.lua
└── packet/
    ├── builders/
    ├── readers/
    ├── packet_catalog.lua
    ├── payload_reader/
    └── types.lua
```

## Packet reference

Official packet structure docs:

https://tshock.readme.io/docs/multiplayer-packet-structure
