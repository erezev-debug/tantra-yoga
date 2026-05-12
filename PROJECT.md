# Yoga Tantra Practice Planner

A standalone web app for planning and running yoga tantra practice sessions, built around a specific 31-asana scroll-order list from the **Gamma yoga** school (a yoga tantra school).

The app is a single-file HTML application — no build step, no dependencies, no server required. It works offline, persists user data to `localStorage`, and is designed to be installed as a Progressive Web App on iPhone or Android via "Add to Home Screen."

---

## Repository

The user intends to host this at `https://github.com/erezev-debug/tantra-yoga` and serve it via GitHub Pages at `https://erezev-debug.github.io/tantra-yoga/`.

The deployable file is `index.html` at the repo root.

---

## What the app does

The user is studying yoga tantra at the Gamma yoga school. They wanted an app to plan and time practice sessions with the specific asana library their school teaches, including chakra correspondences from their own annotations on the school's handout.

### Core features

1. **Build tab** — manually compose a practice from segments (warm-ups, asanas, pranayama, meditation, savasana). Each segment is a row with a pose figure, editable name, hold duration, and rest duration. Reorder with up/down, delete, edit chakras inline.

2. **Generate tab** — produces a balanced practice given total duration, default asana hold, default rest, which segment types to include, and optional chakra emphasis chips. Generator order is fixed: warm-ups → asanas (in scroll order) → pranayama → meditation → savasana.

3. **My lists tab** — user-editable lists of pranayamas and meditations. Empty by default; user types in their own. These power the Pranayama/Meditation pickers.

4. **Audio tab** — background audio (silence / synthesized Om drone / synthesized tanpura / custom file upload), volume, transition bell toggle.

5. **Practice tab** — full-screen timer with current pose figure, circular progress ring, play/pause/prev/next/stop controls, list of upcoming segments. Uses Web Audio API for the singing bowl transition bell and drone/tanpura background. Attempts `navigator.wakeLock` to keep the screen on during practice.

### Picker (modal)

Tapping any "+ Asana", "+ Warm-up", "+ Pranayama", or "+ Meditation" button opens a bottom-sheet picker showing the relevant library as a card grid with pose silhouettes.

- **Multiselect**: tap a card to add it to the selection. Tap again for duplicates (count badge shows ×N).
- **Long-press** (or right-click on desktop) to decrement.
- **Select all** and **Clear** in the toolbar.
- **Order preserved**: items are added to the sequence in tap order.
- **Polar expansion**: polar asanas auto-expand to L + R when added. The button label updates accordingly ("Add 5 to sequence" might mean 3 picks where 2 are polar → 5 segments after expansion).

### Persistence

Everything writes to `localStorage` under the key `yoga-tantra-v1`. Persisted state:
- Current sequence in the Build tab
- Saved sequences (named)
- Pranayama list
- Meditation list
- Audio preferences (kind, volume, bell on/off)

State is loaded on app startup.

---

## The Gamma yoga asana library

The user provided a handwritten/printed handout titled "סדר תנוחות" (Hebrew for "asana order"). The order matters — it's the scroll order from left-to-right, top-to-bottom, and the generator follows it exactly.

The user also handwrote chakra correspondences on the sheet using two-letter codes:
- MU = Muladhara
- SV = Svadhisthana
- MA = Manipura
- AN = Anahata
- VI = Vishuddha
- AJ = Ajna
- SA = Sahasrara

### The 31 asanas (scroll order with chakra tags)

| # | Asana | Chakras | Polar |
|---|---|---|---|
| 1 | Padahastasana | MU | |
| 2 | Ardha Chandrasana | SV | |
| 3 | Tadasana | MU | |
| 4 | Sahaja Agnisara Dauti | MA | |
| 5 | Trikonasana | MA | **polar** |
| 6 | Uddiyana Bandha | MA | |
| 7 | Katichakrasana | AN | **polar** |
| 8 | Garudasana | AJ | **polar** |
| 9 | Prasarita Padottanasana | SA | |
| 10 | Bhadrasana | MU | |
| 11 | Shalabhasana | SV | |
| 12 | Nabhyasana | MA | **polar** |
| 13 | Bhujangasana | AN | |
| 14 | Paschimottanasana | MU | |
| 15 | Preparation for Padmasana | MU | **polar** |
| 16 | Janusirsasana | MU | **polar** |
| 17 | Pavana Muktasana | MA | |
| 18 | Marjariasana | MA | |
| 19 | Gomukhasana | AN | |
| 20 | Ardha Matsyendrasana | VI | |
| 21 | Sukhasana | SV | |
| 22 | Svastikasana | MA | |
| 23 | Kurmasana | AN | |
| 24 | Yogasana | AN | |
| 25 | Vajrasana | AN + AJ | |
| 26 | Shashasana | SA | |
| 27 | Setubandhasana | MA + VI | |
| 28 | Sarvangasana | VI | |
| 29 | Halasana | AJ | |
| 30 | Ardha Sirsasana | SA | |
| 31 | Sirsasana | SA | |

### Polar asanas (auto-expand to L + R)

The user identified these as polar (single-sided poses that should be practiced once on each side):

- **#5** Trikonasana
- **#7** Katichakrasana
- **#8** Garudasana
- **#12** Nabhyasana
- **#15** Preparation for Padmasana
- **#16** Janusirsasana

When picked or generated, each polar asana becomes two consecutive segments: `Name — L` then `Name — R`. Each gets its own rest. The right-side figure is rendered as a horizontal mirror of the left-side figure (SVG `transform="scale(-1, 1) translate(-100, 0)"`).

### The 9 warm-ups (scroll order)

From a separate handout titled "תרגילי חימום" (warm-up exercises) with no Sanskrit names. The user picked descriptive English names:

1. Neck circles
2. Shoulder rolls
3. Horizontal arm sweep
4. Overhead arm reach
5. Overhead clasp stretch
6. Side bend
7. Hip / torso twist
8. Wide-stance squat
9. Shoulder / chest opener

Warm-ups have rest after each segment, just like asanas (default 30s rest).

---

## Design decisions made during prototyping

These are recorded so Cowork (or whoever continues) doesn't re-litigate them:

- **Asana name display**: Full Sanskrit name, not English. No abbreviations.
- **Chakras**: shown as toggle pills per asana (on/off, no numeric weight exposed in UI). Spine visualization weights by total time spent on each chakra.
- **Chakra mapping per asana**: defaults from the user's handwritten notes, but each asana's chakras are editable per-segment.
- **Order in generator**: warm-ups → asanas → pranayama → meditation → savasana. Pranayama comes *after* asanas, not before.
- **Chakra emphasis** in the generator: never filters the full scroll order *out*. The full sequence runs once if there's time; spare time goes to extra reps of focused-chakra asanas. With less time than a full pass, focused asanas are prioritized but the rest still fit when possible.
- **Rest between L and R sides** of a polar asana: one rest between L and R, one rest after R. Default rest applies to both. (User chose this over "L + R as one continuous unit" or "fully independent.")
- **Picker is multiselect**: not single-select. The user pointed out that selecting 30 asanas one at a time is brutal. Long-press removes; tap adds; duplicates allowed.
- **Pose figures**: hand-drawn SVG silhouettes (head + limbs as filled lines). Not copied from the school's printed sheet (copyright). Distinct enough per pose to be recognizable. Mirroring for L/R is automatic.
- **Audio**: synthesized via Web Audio API (no audio files bundled). Custom file upload supported.
- **Font sizing on iOS**: inputs are 16px to prevent the iOS auto-zoom-on-focus bug.

---

## Open items / known limitations

The user may want to address these in Cowork:

1. **Pose figures could be more accurate.** They're recognizable but stick-figure-like. Better art would require either user-provided images or a different drawing approach.
2. **No PWA service worker yet.** "Add to Home Screen" works but the app isn't formally a PWA. Adding a manifest.json and a service worker would let it work fully offline on first launch and look more native.
3. **No actual ambient audio tracks** — only synthesized drone/tanpura. User would need to supply audio files (or accept the synthesis).
4. **Saved-sequence sharing**: no way to export/import a sequence between devices.
5. **Sound on iOS**: Web Audio on iOS requires a user gesture before playing. The first tap on Play does this, but if audio doesn't start, that's why.
6. **Generator chakra emphasis** could be smarter — currently it just adds extra reps in scroll order. Could be weighted differently.
7. **The chakra mapping** is from this user's school. Other tantra traditions map asanas differently.

---

## Technical architecture

- **Single HTML file** (`index.html`). All CSS in `<style>`, all JS in `<script>` at the bottom. ~1600 lines, ~70KB.
- **No frameworks** — vanilla JS. State is a few module-level variables.
- **Persistence**: `localStorage` under one key.
- **Audio**: Web Audio API for synthesis, `<audio>` element for custom file playback.
- **Wake lock**: `navigator.wakeLock` requested when Play is pressed in Practice tab.
- **Dark mode**: automatic via `prefers-color-scheme` media query. All colors are CSS variables.
- **Pose drawing**: each pose is a function returning SVG primitives composed from helpers `h()` (head), `l()` (limb), `t()` (torso), `c()` (curve). Mirroring via SVG `transform`.

---

## How to deploy

The user's intended deployment is GitHub Pages on `erezev-debug/tantra-yoga`:

1. Drop `index.html` at the repo root
2. Settings → Pages → Source = `Deploy from a branch`, Branch = `main`, Folder = `/ (root)`, Save
3. After ~1 min, the app is live at `https://erezev-debug.github.io/tantra-yoga/`
4. On iPhone: open the URL in Safari → Share → Add to Home Screen
