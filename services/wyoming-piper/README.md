# wyoming-piper

<p align="center">
  <img src="https://raw.githubusercontent.com/rhasspy/wyoming-piper/main/docs/logo.png" alt="wyoming-piper Logo" width="120" />
</p>

[![Docker Pulls](https://img.shields.io/docker/pulls/rhasspy/wyoming-piper?style=flat-square)](https://hub.docker.com/r/rhasspy/wyoming-piper)
[![GitHub Stars](https://img.shields.io/github/stars/rhasspy/wyoming-piper?style=flat-square)](https://github.com/rhasspy/wyoming-piper)
[![License](https://img.shields.io/github/license/rhasspy/wyoming-piper?style=flat-square)](https://github.com/rhasspy/wyoming-piper/blob/main/LICENSE)

---

**wyoming-piper** is a fast, local text-to-speech (TTS) server using [Piper](https://github.com/rhasspy/piper) and the [Wyoming protocol](https://wyoming-protocol.readthedocs.io/).

## Features
- High-quality, local TTS
- Supports multiple voices and languages
- Wyoming protocol for easy integration
- Fast and lightweight

## Usage
- Service runs on port 10200 by default
- Configure voice and options in `.env.wyoming-piper`

## Environment Variables
See `.env.wyoming-piper.example` for configuration options. For a full list, see the [repo README](https://github.com/rhasspy/wyoming-piper?tab=readme-ov-file).

## Volumes
- `wyoming_piper_data:/data` — persistent storage for voices and data

## Healthcheck
Checks if the server is responding on port 10200.

## Documentation
- [wyoming-piper GitHub](https://github.com/rhasspy/wyoming-piper)
- [Official Docs](https://github.com/rhasspy/wyoming-piper?tab=readme-ov-file)

---

> For production, set `PIPER_VOICE` in your env file and mount your voices directory as needed.
