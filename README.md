# Drowsier 👻

😫 ➡ 😴

A tiny program that helps you get to bed by locking your computer for a while at a set time of night.

<!-- MarkdownTOC autolink=true -->

- [Motivation](#motivation)
- [Supported platforms](#supported-platforms)
- [Development](#development)
  - [Setup](#setup)
  - [Build & install](#build--install)
  - [Test](#test)
- [Configure](#configure)
  - [Audio notification](#audio-notification)
- [Contributing](#contributing)
- [Todo](#todo)
- [Alternatives](#alternatives)

<!-- /MarkdownTOC -->

## Motivation

I am chronically terrible at stopping what I'm doing at night and going to bed!

Other solutions are overly dependent on operating system configuration, and necessitate risky changes to authentication settings that could accidentally leave you permanently locked out of your account, e.g. pam. I thought a more light-touch approach was pertinent.

I don't have the greatest self-control, so a simple scheduled once-off screen locking wasn't going to be enough. I need it to kick me out, and keep me out. And no snooze/exceptions either - that could be too easy to abuse.

I also wanted full control over what happens when it locks: e.g. pausing whatever media is playing - so I don't lose my spot, and avoid any surprise audio when waking my computer up from sleep the next day.

I know there are paid apps for this kind of purpose, but I would imagine that most of them do not provide the requisite Linux compatibility, or the flexibility I'm after.

Writing this is also a good opportunity for me to try out a bit more programming in Crystal, and to contribute to the Free and Open Source Software landscape.

## Supported platforms

This app was written primarily for Arch Linux, and is set up for systemd; however, all the commands executed to perform the various required actions are configurable. I may eventually provide support for other systems, but you're welcome to set it up yourself. See [this blog post](https://www.ctrl.blog/entry/lock-pc-at-bedtime.html) for some commands to use.

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

## Configure

The YAML config file lives at: `/etc/drowsier/config.yaml`

### Audio notification

You can generate a custom spoken notification with [Sound of Text](https://soundoftext.com/) - using the text to speech engine from Google Translate.

## Contributing

Pull requests and suggestions welcome!

## Todo

- Use a logger
- User config file which overrides default config file
- Publish pre-built binary
- Publish package to Arch User Repository
- Restart automatically when config is changed
- Support multiple lockdown periods
- Support Windows
- Support MacOS
- Support Wayland
- Support other Linux init systems

## Alternatives

- https://www.ctrl.blog/entry/lock-pc-at-bedtime.html
