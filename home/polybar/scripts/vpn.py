#!/usr/bin/env python

"""If VPN is active, return country it is connected to, otherwise fail."""

import subprocess as s
import sys

COUNTRY_CODES = [
    "ch",
    "uk",
    "de",
]

active = (
    s.run(
        [  # noqa: S603
            "/run/current-system/sw/bin/systemctl",
            "is-active",
            "openvpn-*",
        ],
        capture_output=True,
    ).returncode
    == 0
)

if active:
    for cc in COUNTRY_CODES:
        country_active = (
            s.run(
                [  # noqa: S603
                    "/run/current-system/sw/bin/systemctl",
                    "is-active",
                    f"openvpn-{cc.lower()}",
                ],
                capture_output=True,
            ).returncode
            == 0
        )
        if country_active:
            print(cc.upper())  # noqa: T201
            sys.exit(0)
sys.exit(1)
