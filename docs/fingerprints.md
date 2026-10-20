# Enrolling Fingerprints

The setup supports fingerprint sensors for unlocking the laptop. You can use the following to enroll
a fingerprint:

```bash
sudo fprintd-enroll -f right-index-finger f4z3r
# then press your finger to the fingerprint repeatedly until you are no longer asked to
# then verify
fprintd-verify -f right-index-finger
```

Note that this will enable the fingerprint to be used both to unlock the laptop from hyprlock, and
as an alternative to password requests from `sudo`.
