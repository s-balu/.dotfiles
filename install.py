#!/usr/bin/env python3
"""Link shared configs, backing up existing destinations before replacing them."""

import argparse
from datetime import datetime
from pathlib import Path
import shutil
import sys


LINKS = (
    ("dot_zshrc", ".zshrc"),
    ("tmux/tmux.conf", ".tmux.conf"),
    ("tmux/tmux.conf.local", ".tmux.conf.local"),
    ("tmux/tmux.conf", ".tmux/.tmux.conf"),
    ("tmux/tmux.conf.local", ".tmux/.tmux.conf.local"),
    ("alacritty/alacritty.toml", ".config/alacritty.toml"),
    ("nvim", ".config/nvim"),
    ("starship/starship.toml", ".config/starship.toml"),
    ("git/gitconfig", ".gitconfig"),
    ("git/config", ".config/git"),
)
OPTIONAL_LINKS = (("local/xm1", ".config/xm1"),)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--dry-run", action="store_true", help="preview without writing")
    mode.add_argument("--check", action="store_true", help="check links without writing")
    parser.add_argument("--target-home", type=Path, default=Path.home(),
                        help="destination home (defaults to your home)")
    args = parser.parse_args()
    root = Path(__file__).resolve().parent
    home = args.target_home.expanduser().resolve()
    backup = home / ".local/state/dotfiles-backups" / datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    specs = list(LINKS) + [(s, d) for s, d in OPTIONAL_LINKS if (root / s).exists()]
    missing = [s for s, _ in specs if not (root / s).exists()]
    if missing:
        parser.error("missing repository sources: " + ", ".join(missing))

    problems = 0
    for source, destination in specs:
        src, dst = root / source, home / destination
        if dst.is_symlink() and dst.resolve() == src:
            print(f"OK {destination}")
            continue
        problems += 1
        if args.check:
            print(f"MISSING/DIFFERENT {destination} -> {src}")
            continue
        exists = dst.exists() or dst.is_symlink()
        if args.dry_run:
            print(f"{'BACK UP + LINK' if exists else 'LINK'} {destination} -> {src}")
            continue
        if exists:
            saved = backup / destination
            saved.parent.mkdir(parents=True, exist_ok=True)
            shutil.move(str(dst), str(saved))
            print(f"BACKUP {saved}")
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.symlink_to(src, target_is_directory=src.is_dir())
        print(f"LINK {destination} -> {src}")

    if args.check:
        return 1 if problems else 0
    if not problems:
        print("All links are already installed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
