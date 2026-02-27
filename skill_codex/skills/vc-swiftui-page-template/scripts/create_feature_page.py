#!/usr/bin/env python3
"""Generate UIViewController + SwiftUI feature page files for AAAFeatures."""

from __future__ import annotations

import argparse
import datetime as dt
import re
import sys
from pathlib import Path


def to_pascal_case(raw: str) -> str:
    parts = re.split(r"[^A-Za-z0-9]+", raw.strip())
    parts = [p for p in parts if p]
    if not parts:
        return ""
    return "".join(part[:1].upper() + part[1:] for part in parts)


def load_template(assets_dir: Path, filename: str) -> str:
    path = assets_dir / filename
    if not path.exists():
        raise FileNotFoundError(f"Template not found: {path}")
    return path.read_text(encoding="utf-8")


def write_file(path: Path, content: str, overwrite: bool) -> None:
    if path.exists() and not overwrite:
        raise FileExistsError(f"File already exists: {path}")
    path.write_text(content, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Create UIViewController + SwiftUI page skeleton files."
    )
    parser.add_argument("--feature-name", required=True, help="Feature name, e.g. ProfileCenter")
    parser.add_argument(
        "--directory-name",
        default="",
        help="Target directory under AAA/AAAFeatures/Sources/. Defaults to feature name.",
    )
    parser.add_argument(
        "--sources-root",
        default="AAA/AAAFeatures/Sources",
        help="Sources root directory.",
    )
    parser.add_argument(
        "--nav-title",
        default="",
        help="Navigation title. Defaults to feature name.",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Overwrite existing files.",
    )
    args = parser.parse_args()

    feature_name = to_pascal_case(args.feature_name)
    if not feature_name or not re.match(r"^[A-Z][A-Za-z0-9]*$", feature_name):
        print("[ERROR] --feature-name must resolve to a valid PascalCase identifier.")
        return 1

    directory_name = args.directory_name.strip() or feature_name
    nav_title = args.nav_title.strip() or feature_name

    script_dir = Path(__file__).resolve().parent
    skill_dir = script_dir.parent
    assets_dir = skill_dir / "assets"
    target_dir = Path(args.sources_root).resolve() / directory_name
    target_dir.mkdir(parents=True, exist_ok=True)

    date_str = dt.date.today().strftime("%Y/%m/%d")
    replacements = {
        "{{FEATURE_NAME}}": feature_name,
        "{{NAV_TITLE}}": nav_title,
        "{{DATE}}": date_str,
    }

    template_map = {
        f"{feature_name}ViewController.swift": "FeatureViewController.swift.tpl",
        f"{feature_name}HostingController.swift": "FeatureHostingController.swift.tpl",
        f"{feature_name}View.swift": "FeatureView.swift.tpl",
        f"{feature_name}ViewModel.swift": "FeatureViewModel.swift.tpl",
    }

    for output_name, template_name in template_map.items():
        raw = load_template(assets_dir, template_name)
        for key, value in replacements.items():
            raw = raw.replace(key, value)
        output_path = target_dir / output_name
        write_file(output_path, raw, overwrite=args.overwrite)
        print(f"[OK] Wrote {output_path}")

    print(f"[DONE] Created VC + SwiftUI page template in {target_dir}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
