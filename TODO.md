# ToDos

### Simplify the Structure

Currently the structure of the repository is quite ad-hoc. I would like to split it more concretely
into areas such as coding, music, window-manager, ...

## Split system and home-manager configuration

I want to split the configurations to that:

- I can rebuild them separately,
- Onboarding a new repository is simpler,
- I have a clearer cut between system requirements and user requirements.

## Nvim Technical Debt

My nvim setup is always on the move. I have quite a few things that are lying around and not
optimised. For instance:

- Various nvim plugins are my own forks awaiting merging in the upstream.
- Various nvim plugins are pinned to a version, and might want to be updated.

## Tooling Choices

### Niri

Niri as a WM looks super nice. However it seems that it is not quite as far as Hyprland. Moreover it
would lead to a large discrepancy between x11 systems and wayland unless I find a scrollable WM on
x11 and reconfigure that one as well.
