---
type: index
created: 05-17-26
updated: 05-17-26
tags: [software, index, inventory]
status: v2 — merged from scan output (`_scan-output.txt`, 2026-05-17 21:30)
sources: [registry uninstall keys (224), UWP (57), Steam manifests, winget list]
---

# Software Index

Everything installed on `ANDYS-DESKTOP`, organized by what it does. Built
from `_scan-installed.ps1` + every vault note in this folder. Entries
formatted `[[wikilink]]` have a full per-software note nearby (directories
they touch, projects they power, related software). Plain entries are
known to be installed but don't have their own note yet — copy
`04 - Templates/Software Note.md` to add one.

Pure dependencies (VC++ redists, .NET Native runtimes, UI XAML packages,
Windows App Runtime, Office 2010 patches, system drivers under
`Microsoft.*`) are rolled up at the bottom rather than enumerated.

---

## AI tools

[[cowork]] — Anthropic's Claude desktop app in Cowork mode. UWP install
(`Anthropic.Claude` v1.7196). Agentic AI with filesystem and shell access
plus MCP connectors — built and maintains this vault, runs the weekly
inbox sweep, fronts the department-head agents in [[Orchestrator]].

[[claude-code]] — `Anthropic.ClaudeCode` v2.1.114 from winget. Terminal-
flavored Claude for repo-wide refactors, long coding sessions, and bulk
vault maintenance.

[[cursor]] — Anysphere's VS Code fork (v3.3.30) at
`C:\Users\<YOUR-USERNAME>\AppData\Local\Programs\cursor\`. AI-in-the-editor;
composer mode is the closest thing to an agent inside the IDE.

[[codex]] — OpenAI's autonomous coding agent, installed as a UWP app
(`OpenAI.Codex` v26.513). Delegated, long-running TDD-style work in the
cloud; complement to the Claude tools.

[[hermes]] — Nous Research persistent agent platform. **Not installed** —
placeholder for AI OS Phase 5.

**Ollama** — Local LLM runtime (v0.23.3) at
`C:\Users\<YOUR-USERNAME>\AppData\Local\Programs\Ollama\`. Self-hosted inference for
privacy-sensitive or offline tasks. Pairs with the `Ollama` model option
called out in [[CLAUDE]]'s model-selection table.

**Stoat** — Revolt Platforms desktop app (v1.3.0). Voice/text comms with
some AI features; lives at `C:\Users\<YOUR-USERNAME>\AppData\Local\Stoat`.

**Local AI Manager for Microsoft 365** (`aimgr` UWP, v0.20.47) — Microsoft's
local on-device AI manager for M365 Copilot. System-installed.

**my-app** (`Gion` v1.0.0 at `C:\Users\<YOUR-USERNAME>\AppData\Local\my_app`) — Unknown
origin / personal-project leftover. Triage candidate: figure out what this
is or uninstall.

---

## Dev tools

[[git]] — `Git.Git` v2.53.0.2 at `C:\Program Files\Git\`.

[[python]] — `Python.Python.3.11` v3.11.9 + Python Launcher; older runtime
than the vault notes assume (3.12). Heads-up: update Python note or
upgrade install when convenient.

**GitHub CLI (`gh`)** — `GitHub.cli` v2.89. Used alongside Git for PR/issue
work and repo creation from the terminal.

**Node.js** — `OpenJS.NodeJS.LTS` v24.14.1. JavaScript/TypeScript runtime;
foundation for any web project or npm-based tool.

**Bun** — JavaScript runtime + toolchain at `C:\Users\<YOUR-USERNAME>\.bun`. Faster
drop-in for Node in some cases; package install, test runner, bundler.

**Docker Desktop** — v4.69 at `C:\Program Files\Docker\Docker`. Container
runtime for local services, dev environments, and anything that needs
Linux isolation on Windows.

**Windows Subsystem for Linux** — `Microsoft.WSL` v2.7.3 with
`Canonical.Ubuntu` 24.04 LTS. Real Linux shell inside Windows; common
target for dev work that's allergic to native Windows tooling.

**Visual Studio Community 2022** — v17.14.29 at
`C:\Program Files\Microsoft Visual Studio\2022\Community`. Full IDE for
C/C++/.NET. The [[02 - Projects/Game Dev/TerraWatt|TerraWatt]] (C+Raylib)
build uses its toolchain.

**Visual Studio Build Tools 2022** — v17.14.28 at the same Visual Studio
location. MSBuild + MSVC compiler without the full IDE; satisfies the
"need a C compiler" requirement for command-line builds.

**CMake** — `Kitware.CMake` v4.3.0. Cross-platform build-system generator;
pairs with MSVC / Ninja for native C/C++ projects.

**Ninja** — `Ninja-build.Ninja` v1.13.2. Small fast build tool that CMake
often emits to.

**LLVM** — `LLVM.LLVM` v22.1.1. Clang/clang++ toolchain. Alternate C/C++
compiler to MSVC.

**ripgrep** — `BurntSushi.ripgrep.MSVC` v15.1.0. Fast recursive grep;
default search engine for Cowork and Claude Code under the hood.

**.NET SDK 8** — `Microsoft.DotNet.SDK.8` v8.0.421. C#/F# build tooling.
Pairs with the Desktop Runtimes 3.1 / 6 / 8 / 9 all installed for app
compatibility.

**Microsoft OpenJDK 21** — `Microsoft.OpenJDK.21` v21.0.3.9. Java
development; the newer of two JDKs.

**Oracle JDK 25** — Oracle Java 25.0.1. Latest Oracle Java toolkit.

**Oracle Java 8 JRE** — v8.0.4810. Legacy runtime for any Java app that
still demands it.

**Windows SDK 10.0.26100** — `Microsoft.WindowsSDK.10.0.26100` v7705 +
addon. Headers and libs for Win32 / WinRT development; required by
Visual Studio for desktop targets.

---

## Game dev / asset creation

[[godot]] — Open-source 2D/3D engine. Lives at `F:\Game Dev\Utilities`,
not in the registry (zip install). Not surfaced by the scan.

**Aseprite** v1.3.17 — Pixel-art editor / animator at
`C:\Program Files\Aseprite\`. Sprite work for any 2D game or asset.

**Adventure Game Studio 4.0 Alpha** — AGS classic point-and-click engine
at `F:\Adventure Game Studio 4.0.0\`. Alpha build, kept for tinkering /
nostalgia work.

**WinAGI GDS** v2.1.15 at `F:\WinAgi\` — IDE for the original Sierra
On-Line AGI interpreter. Sister to AGS for hacking on Sierra-style
adventure games.

**ScummVM** v2026.2.0 at `F:\SCI\ScummVM\` — Cross-platform engine
reimplementation; runs LucasArts / Sierra adventure games modern OSes
can't.

**Raylib** — Plain-C games library used by
[[02 - Projects/Game Dev/TerraWatt|TerraWatt]]. Header-and-lib drop into
the project, not a separate install.

---

## Productivity / PKM / Office

[[obsidian]] — `Obsidian.Obsidian` v1.12.7. Vault viewer/editor.

[[obsidian-canvas]] — Built into Obsidian.

**Microsoft Office Professional Plus 2010** v14.0.4734 — Word/Excel/etc.
Old, paid-for, and still works. Many KB patches against it show up in the
registry; ignored as bulk dependencies.

**Microsoft Visio 2016** (Pro Retail) — Diagramming, en-us/es-es/fr-fr
locales installed. Lives in the Office shared install tree.

**Microsoft Teams** v1.5.00.4689 + Teams Machine-Wide Installer. Business
chat / meetings.

**Outlook for Windows** (UWP, v1.2025.1007). Modern Outlook client; also
classic Mail and Calendar (`microsoft.windowscommunicationsapps`).

**OneDrive** — `Microsoft.OneDrive` v26.070.0414. Per
[[CLAUDE]] doctrine: small synced docs only (Career, Identity & Records,
Cowork Plans, DaVinci settings) — never the vault, never media.

**Microsoft Sticky Notes**, **Snip & Sketch**, **Calculator**, **Windows
Maps**, **Windows Photos** — built-in UWP utilities. Listed for
completeness; rarely worth their own note.

---

## Browsers

**Google Chrome** v148.0.7778 — default browser. Hosts the [[obsidian|Web
Clipper]] extension, the Cowork web fallback, etc.

**Mozilla Firefox** v150.0.3 — backup browser.

**Microsoft Edge** v148.0.3967 + Edge UWP — system browser, used by
in-app embedded webviews even if you don't open it directly.

**Microsoft Copilot** (Edge-shell) v148.0.3967 at `C:\Program Files (x86)\
Microsoft\Copilot\Application` + Copilot UWP. Microsoft's Bing-Chat-
descendant.

**Chrome Remote Desktop** + **Chrome Remote Desktop Host** v148. Remote
access to/from this machine via Google's relay.

---

## Communication

**Discord** v1.0.9237 — gaming/community chat.

**Signal** `OpenWhisperSystems.Signal` v8.10. Encrypted messaging.

**Zoom** `Zoom.Zoom.EXE` v5.17.7. Video meetings.

**Microsoft Teams** — also in Productivity above.

---

## Media — video, audio, streaming

[[davinci-resolve]] — `DaVinci Resolve` v19.1.20003 + Resolve Control
Panels v2.3 + Fairlight Audio Accelerator + Blackmagic RAW Common
Components.

**Audacity** `Audacity.Audacity` v3.7.1 — audio cleanup before Resolve.

**FFmpeg** `Gyan.FFmpeg` v8.1.1 — CLI audio/video swiss-army knife.

**HandBrake** v1.8.2 — GUI video transcoder. Good for one-off MP4
re-encodes when FFmpeg flags feel like overkill.

**OBS Studio / Streamlabs Desktop** — Streamlabs.Streamlabs v1.15.1 is
installed (an OBS fork with streaming overlays). The vanilla OBS Studio
mentioned in the [[davinci-resolve]] note doesn't currently appear in the
scan — Streamlabs is the active capture tool.

**VLC media player** v3.0.17 — universal media player.

**K-Lite Codec Pack** v18.0.5 Standard — codec bundle for legacy / odd
formats.

**Voicemod** v2.48 — real-time voice changer; pipes through OBS/Discord.

**Winxvideo AI** v3.1 — AI upscaling / restoration for video.

**Animaze** — Holotech avatar / vtuber app installed via Steam at
`F:\SteamLibrary\steamapps\common\Animaze`.

**Rayon** v2.7.1 — `rayon.design` desktop app. CAD-adjacent design tool.

---

## DJ / music

**Serato DJ Pro** v4.0.1 — DJ controller software for Pioneer
hardware.

**Pioneer DDJ_SR Driver** v1.100 — ASIO driver for the Pioneer DDJ-SR
controller.

---

## Media servers

**Plex Media Server** `Plex.PlexMediaServer` v1.41.7 at
`C:\Program Files\Plex\Plex Media Server\` — house media server.

**Jellyfin Server** `Jellyfin.Server` v10.9.10 — open-source Plex
alternative installed alongside. One can serve as fallback / migration
target for the other.

---

## Hardware drivers & device managers

**AMD Software** v24.9.1 — GPU drivers + Adrenalin control panel.

**Realtek High Definition Audio Driver** v6.0.9000 — onboard audio.

**Logitech G HUB** v2024.9 — Logitech peripheral configurator (keyboard /
mouse / headset profiles, lighting).

**LaCie Desktop Manager** v2.7 — external drive monitor / firmware for
LaCie storage.

**PowerChute Personal Edition** v3.1 — APC UPS battery-backup
monitor/shutdown agent.

**Microsoft GameInput** v3.3.182 — modern gamepad input runtime, required
by some recent games.

---

## File / disk / system utilities

**WinRAR** v6.24 — archive tool.

**TreeSize Free** v4.7.3 — visualize what's eating disk space.

**Recuva** v1.53 — undelete tool.

**BitTorrent** v7.11.0 at `C:\Users\<YOUR-USERNAME>\AppData\Roaming\BitTorrent` —
torrent client.

**Google Earth Pro** v7.3.7 — desktop globe / aerial imagery.

**TradingView Desktop** `TradingView.TradingViewDesktop` v2.9.6 — charts
and quotes desktop client.

**DroidKit** v1.0.1 — Android device recovery / repair toolkit.

**GameRanger** — legacy multiplayer tunnel for older PC games.

**Vortex** `NexusMods.Vortex` v1.15 — Nexus Mods game-mod manager.

**SkiFree** UWP `13199chin.bimbo.SkiFree` v2.1 — classic Win 3.x ski game,
modern reissue.

---

## Game launchers / clients

**Steam** `Valve.Steam` v2.10. Library on `F:\SteamLibrary\` (plus
secondaries on `C:\Program Files (x86)\Steam\steamapps\` and `D:\
SteamLibrary\steamapps\`).

**Epic Games Launcher** v1.3.93 at `C:\Program Files (x86)\Epic Games\`.

**GOG GALAXY** v2.0.77 at `C:\Program Files (x86)\GOG Galaxy\`.

**Battle.net** v1.0 at `C:\Program Files (x86)\Battle.net` + Blizzard
games on `F:\Battle.net\`.

**EA app** v13.396 — Electronic Arts launcher (current generation).

**Rockstar Games Launcher** v1.0.102 at `F:\Rockstar\Launcher` + Rockstar
Games SDK v2.4.

**Paradox Launcher v2** v2.4. Used by Stellaris and other Paradox titles.

**Xbox / Xbox Console Companion / Gaming Services / Game Bar** — the
Microsoft gaming stack of UWP apps.

**Overwolf** v0.300 — game-overlay platform, hosts:

- **Outplayed** v170 — clip recorder
- **Mobalytics** v1.802 — League stats overlay
- **CurseForge** v1.304 — Minecraft / WoW mod manager
- **Thunderstore Mod Manager** v1.119 — mod manager for Unity games
  (Risk of Rain 2, Lethal Company, etc.)

**Epic Online Services** v4.3 — multiplayer/auth runtime, ships with
Epic-published games.

---

## Games

Compact list since the scan caught ~80. Grouped by where they live. Demos
flagged with `(demo)`.

### Steam — primary library on `F:\SteamLibrary\steamapps\common\`

ABRISS, Animaze, Automation (PLC), Backseat Drivers (demo), Big Boy Boxing
(demo), Bingle Bingle, A Bumpy Ride (demo), Carnivores Reborn, Commander
Keen Complete Pack, Content Warning, Crash Bandicoot N. Sane Trilogy,
CRUMB, Deep Rock Galactic, Diablo II Resurrected, Diablo III, Diablo IV,
Emberward (demo), Empires of the Undergrowth, EXAPUNKS, Ex-Zodiac, FATE,
Foundation (demo), Free Stars: The Ur-Quan Masters, Galaxy of Pen & Paper,
Ghost Watchers, Good Company (demo), Grand Theft Auto V Enhanced,
Hacknet, Hearthstone, HELLDIVERS 2, Heroes of Hammerwatch II (demo),
Hogwarts Legacy, Hotline Miami, HOT WHEELS UNLEASHED, Insider Trading
(demo), Jumplight Odyssey (OST), Jurassic World Evolution 2, Kerbal Space
Program, King Arthur's Gold, LEGO Builder's Journey, Legend Bowl, Locomoto
(demo), Madden NFL 19, NASCAR '15 Victory Edition, Need for Speed Heat,
Nodebuster, Noita, Passant (demo), PEAK, Phasmophobia, Planet Coaster 2,
Planet Zoo, Police Stories, PULSAR: Lost Colony, RAILROADS Online, Retro
City Rampage DX, RV There Yet?, Sandustry (demo), Satisfactory, Schedule I,
Shakedown: Hawaii, shapez, shapez 2 (+ demo), SHENZHEN I/O, Shotgun King:
The Final Checkmate, Sky Haven, Slay the Spire, Spore, Star Control:
Origins, Star Trek: Voyager — Across the Unknown (demo), Star Trucker,
STAR WARS Battlefront II, STAR WARS Jedi: Fallen Order, Stellaris,
Supreme Commander: Forged Alliance, Sunday Rivals, Tape to Tape, Terraria,
Terror of Hemasaurus, The Farmer Was Replaced, The Powder Toy, Tiny
Kingdom (demo), Turmoil, Two Point Campus, Two Point Hospital, Upload
Labs, Valheim, Vampire Survivors, Void Crew, Wargroove, Warhammer 40k:
Dawn of War II (Anniversary), Warside (+ demo), Xenopurge (demo), You
Can Kana.

### Battle.net — `F:\Battle.net\`

Diablo II Resurrected, Diablo III, Diablo IV, Hearthstone, StarCraft,
StarCraft II, Warcraft Rumble.

### Other launchers / standalone

- **Epic** — Harry Potter: Quidditch Champions, Ultima Online Classic
  Client (legacy)
- **EA** — Madden NFL 19 (also installs from EA Games\Madden NFL 19)
- **Xbox / Game Pass** — Sea of Thieves (UWP), Minecraft for Windows (UWP)
- **Standalone installs**
  - **Kerbal Space Program** — Squad, original
  - **Kitten Space Agency** v2025.11.4 at `F:\Kitten Space Agency\` —
    RocketWerkz successor to KSP, current build
  - **MOUSE: P.I. For Hire** at `E:\Games\MOUSE - P.I. For Hire\`
  - **Thomas & Friends: Wonders of Sodor** at
    `E:\Games\Thomas & Friends - Wonders of Sodor\`
  - **TurtleWoW** v2.2.8 at `F:\Turtle-WoW` — 1.12 vanilla World of
    Warcraft private server client
  - **The Ur-Quan Masters MegaMod** v0.8.3 — Star Control 2 reimplementation

---

## Runtimes, redistributables, system

Bulk install set — listed by family rather than each version:

- **Microsoft Visual C++ Redistributables** — 2010 / 2012 / 2013 / 2015-2022
  (x86 + x64), plus the v14 newer redist. Required by countless apps.
- **.NET Desktop Runtimes** — 3.1.32, 6.0.36, 8.0.27, 9.0.16 (x64). Plus
  the **.NET SDK 8** listed under Dev tools.
- **Microsoft XNA Framework Redistributable 4.0** — for older XNA games.
- **Windows App Runtime** — versions 1.3, 1.4, 1.5, 1.6, 1.7, 1.8 all
  side-by-side. Required by various UWP/WinUI apps.
- **Microsoft.UI.Xaml** — 2.0, 2.3, 2.4, 2.7, 2.8. UWP XAML controls.
- **Microsoft .NET Native Framework / Runtime** — 1.7, 2.2. Older UWP
  app dependency stack.
- **Microsoft Visual Studio Installer / VS 2010 Tools for Office Runtime
  / vs_CoreEditorFonts** — VS install scaffolding.
- **Office 2010 KB patches** — dozens of `Update for Microsoft Office 2010`
  entries; cumulative patches against the Office 2010 install above.
- **Windows built-in UWP apps** not detailed elsewhere: 3D Viewer, Paint
  3D, Mixed Reality Portal, Bing, Bing Weather, Solitaire & Casual Games,
  Microsoft Tips, Get Help, Microsoft Store, Phone Link, Cross Device
  Experience Host, Feedback Hub, Windows Camera, Windows Sound Recorder,
  Windows Clock, Microsoft Wallet/Pay, Photos, Movies & TV, Windows Media
  Player (Zune Music), Windows Subsystem for Linux + Ubuntu.
- **Windows DevHome / Advanced Settings**, **DirectX runtime** (winget
  v9.29).
- **Microsoft System CLR Types for SQL Server 2019**.
- **Minecraft Launcher** (UWP) + **Minecraft for Windows** (UWP).

---

## How to refresh

Re-run [[_scan-installed.ps1]]; it overwrites `_scan-output.txt` and the
diff against this index points at what's new. Quick checklist:

1. New entry shows up in the scan that isn't in this index → add it to the
   right category, write a short paragraph.
2. An entry here no longer appears in the scan → mark it as uninstalled
   or remove.
3. Version bumps don't need a v3 of the index; refresh only when categories
   change or paragraphs become wrong.

## How to add a per-software note

Worth doing for anything where the directories-it-touches and projects-it-
powers info would actually be useful (DaVinci, Cursor, Godot, etc.) rather
than for every game and runtime.

1. Copy `04 - Templates/Software Note.md` to
   `12 - Software Map/<software-name>.md`.
2. Fill in `category`, `install_location`, `publisher`, etc.
3. Wikilink the directories it touches and the projects it powers.
4. Replace the plain bolded entry in this index with `[[<software-name>]]`.

## Notable scan gaps to triage

- The Steam-library section of the scan only walked
  `C:\Program Files (x86)\Steam\steamapps`, but the main library is
  `F:\SteamLibrary\steamapps\common\` (visible via every game's
  `InstallLocation`). The registry rows already cover the games — only
  cosmetic.
- **OBS Studio** is referenced in [[davinci-resolve]] but didn't surface
  in the scan; Streamlabs Desktop (an OBS fork) is what's actually
  installed.
- **clasp** (Google Apps Script CLI) referenced in [[git]] for the KSP
  RPG project — global npm install, not in the registry. Confirm via
  `npm ls -g --depth=0` if needed.
- **my-app** at `AppData\Local\my_app` — unknown origin; identify or
  uninstall.
