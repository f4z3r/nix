# ToDos

## Simplify this Repository

I have many tools that I rarely use. It might make sense to remove these, or incorporate them more
tightly in my setup. Examples are:

- `broot`: I love the tool but don't use it that much. Especially its integration into nvim.
- `mpd`: rarely listen to music I have locally anymore.

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
