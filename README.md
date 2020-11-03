# Drowsier 👻

😫 ➡ 😴

A tiny program that helps you get to bed by locking your computer for a while at a set time of night.

<!-- MarkdownTOC autolink=true -->

- [Motivation](#motivation)
- [Development](#development)
  - [Setup](#setup)
  - [Build & install](#build--install)
  - [Test](#test)
- [Todo](#todo)
- [Alternatives](#alternatives)

<!-- /MarkdownTOC -->

## Motivation

I am chronically terrible at stopping what I'm doing at night and going to bed!

## Development

### Setup

Install Crystal, e.g. on Arch Linux:

```bash
sudo pacman -S crystal
```

### Build & install

```bash
./scripts/build && sudo ./scripts/install
```

### Test

To run a manual test:

```bash
./scripts/test
```

## Todo

- Pause media / mute when locking
- Publish package to Arch User Repository
- Restart automatically when config is changed
- Support multiple lockdown periods
- Support Windows
- Support MacOS
- Support Wayland
- Support other Linux init systems

## Alternatives

- https://www.ctrl.blog/entry/lock-pc-at-bedtime.html
