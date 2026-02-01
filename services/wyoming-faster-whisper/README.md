# wyoming-faster-whisper

This service runs the [wyoming-faster-whisper](https://github.com/rhasspy/wyoming-faster-whisper) server for fast speech-to-text using Whisper models.

## Usage

- Exposes Wyoming protocol on port 10300 (TCP)
- Built from source (Docker Hub image is outdated) to include latest VAD support
- All parameters are configurable via `.env.wyoming-faster-whisper`

## Configuration

Copy `.env.wyoming-faster-whisper.example` to `../../.env.wyoming-faster-whisper` and adjust as needed.

### Model Settings

| Variable | Default | Description |
|----------|---------|-------------|
| `FASTER_WHISPER_MODEL` | `small` | Model size: `tiny`, `base`, `small`, `medium`, `large`, or HuggingFace path |
| `FASTER_WHISPER_LANGUAGE` | `auto` | Language code (`en`, `de`, `fr`, etc.) or `auto` for detection |
| `FASTER_WHISPER_BEAM_SIZE` | `0` | Beam size for decoding (0 = auto) |

### VAD (Voice Activity Detection)

VAD filters out non-speech audio to reduce hallucinations and improve response times:

| Variable | Default | Description |
|----------|---------|-------------|
| `FASTER_WHISPER_VAD_THRESHOLD` | `0.5` | Speech probability threshold (0.0-1.0) |
| `FASTER_WHISPER_VAD_MIN_SPEECH_MS` | `200` | Minimum speech duration (ms) |
| `FASTER_WHISPER_VAD_MIN_SILENCE_MS` | `600` | Minimum silence to split (ms) - lower = faster response |

## Healthcheck

A TCP socket healthcheck verifies the Wyoming protocol is available on port 10300.

## Volumes

- `wyoming_faster_whisper_data` - Persists downloaded models between restarts

## References

- [wyoming-faster-whisper GitHub](https://github.com/rhasspy/wyoming-faster-whisper)
