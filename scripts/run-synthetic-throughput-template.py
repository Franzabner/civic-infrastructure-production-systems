#!/usr/bin/env python3
"""Synthetic placeholder runner for public-safe civic throughput examples."""

from __future__ import annotations

import csv
from pathlib import Path


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    csv_path = root / "throughput-material-flow" / "synthetic-throughput-assumptions.csv"
    with csv_path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    print("synthetic_rows:", len(rows))
    print("boundary: synthetic assumptions only; no live operations")


if __name__ == "__main__":
    main()
