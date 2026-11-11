# Development Environment

This is a Helm chart that installs my personal development environment on an Kubernetes cluster. It
deploys a single pod running an interactive [fish shell](https://fishshell.com) session backed by
persistent storage.

---

## What It Deploys

The chart creates the following resources in the release namespace:

- **Deployment** — runs one replica of the dev-environment container with a `Recreate` strategy, a
  TTY, and a login `fish` shell as the entrypoint.
- **PersistentVolumeClaims** — one `ReadWriteMany` claim per entry under `storage.volumes`, used to
  persist the workspace, tool caches, and credentials across pod restarts.
- **Service** — a `ClusterIP` service exposing the pod on port `8080`.
- **ConfigMap** — additional environment variables (e.g. `GOPROXY`) injected into the container from
  `env`.
- **Ingress** — an ingress with edge TLS termination (insecure traffic is redirected) that exposes
  the service under `host`.

## How It Works

The container starts a login fish shell (`/bin/fish -l`) after setting a cooperative `umask 0002`,
so the pod effectively acts as a remote development machine. All data that matters survives restarts
because it lives on persistent volumes mounted at fixed paths:

| Volume       | Mount path                      | Size |
| ------------ | ------------------------------- | ---- |
| `workspace`  | `/workspace`                    | 50Gi |
| `mise-cache` | `/home/f4z3r/.local/share/mise` | 20Gi |
| `ssh`        | `/home/f4z3r/.ssh`              | 1Gi  |
| `gnupg`      | `/home/f4z3r/.gnupg`            | 1Gi  |
| `pi`         | `/home/f4z3r/.pi`               | 5Gi  |
| `luarocks`   | `/home/f4z3r/.luarocks`         | 1Gi  |

Networking and trust are configured to support a corporate environment:

- Proxy configurations can be set via the environment.
- A bundle of trusted certificate authorities can be mounted from an existing ConfigMap in
  `certificateAuthorities.configmap`.
- The container image can be pulled through a registry proxy (`image.registry`).

The pod is hardened where practical: it runs as a non-root user, does not mount the service account
token, and the Kubernetes cache at `/home/f4z3r/.kube` is an in-memory `emptyDir` (500Mi limit)
instead of persistent storage.

### Sharing Files with Other Systems

The service and route exist so that a small ad-hoc server such as
[miniserve](https://github.com/svenstaro/miniserve) can be started inside the pod to share files
between the external systems and the environment over HTTPS. During standard operations, nothing is
listening on the exposed port.

## Prerequisites

- A storage class supporting `ReadWriteMany` access mode (`storage.class`).
- Helm 3.

## Installation

```bash
helm install dev-env .
```
