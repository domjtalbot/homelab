#!/usr/bin/env python3
import sys
from pathlib import Path

def parse_env(path):
    env = {}
    for line in Path(path).read_text().splitlines():
        line = line.strip()
        if not line or line.startswith('#'): continue
        if '=' in line:
            k, v = line.split('=', 1)
            env[k.strip()] = v.strip()
    return env

def main(example_path, env_path):
    example = parse_env(example_path)
    actual = parse_env(env_path)
    missing = [k for k in example if k not in actual or not actual[k]]
    extra = [k for k in actual if k not in example]
    if missing:
        print('Missing variables in .env:', ', '.join(missing))
    if extra:
        print('Extra variables in .env:', ', '.join(extra))
    if not missing and not extra:
        print('All variables in .env match .env.example')
    sys.exit(1 if missing else 0)

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: check_env.py .env.example .env')
        sys.exit(2)
    main(sys.argv[1], sys.argv[2])
