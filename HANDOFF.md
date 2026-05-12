# Cowork handoff — paste this as your first message

Copy everything between the `---` lines into Cowork's first message in a new project, with the project folder set to wherever you saved these files (e.g. `~/Projects/tantra-yoga`).

---

I'm continuing a project I started in Claude Chat: a single-file HTML web app for planning yoga tantra practice sessions, built around the 31-asana sequence taught by my Gamma yoga school.

**Files in this folder:**
- `index.html` — the working app (one file, vanilla JS, no build)
- `PROJECT.md` — full background: what the app does, the asana library with chakra tags, the 6 polar asanas, the 9 warm-ups, every design decision made, known limitations
- `HANDOFF.md` — this file

**First, please:**
1. Read `PROJECT.md` end to end so you have full context
2. Open `index.html` in my default browser so I can see the current state
3. Ask me what I want to work on next

**Most likely next steps I want help with:**
- Pushing this to my GitHub repo `erezev-debug/tantra-yoga` and enabling GitHub Pages so I can use it on my iPhone via "Add to Home Screen"
- Adding a proper PWA `manifest.json` and a service worker so the app installs cleanly and works offline on first launch
- Iterating on the pose figures — they're recognizable but stick-figure-like; I may want them more refined
- Sound: I might supply actual audio files for ambient tracks instead of the current synthesized drone/tanpura

**Things to keep firm:**
- The 31-asana **scroll order** is from my school's handout and must not be reordered
- The **chakra tags per asana** match my handwritten notes on the handout — defaults shouldn't drift
- **Polar asanas** (#5 Trikonasana, #7 Katichakrasana, #8 Garudasana, #12 Nabhyasana, #15 Prep for Padmasana, #16 Janusirsasana) always expand to L then R with rest between
- **Generator order**: warm-ups → asanas → pranayama → meditation → savasana (pranayama after asanas, not before)
- **Chakra emphasis** in the generator never filters poses out — it adds extras to the focused chakras in spare time
- **Picker is multiselect**, not single-select

Please confirm you've read `PROJECT.md` before making any changes, and show me a plan before editing `index.html`.

---

## Tips for working with Cowork on this project

- **Test in the browser frequently.** Cowork can open `index.html` for you after edits. The app has no build step, so reload is instant.
- **Use git.** Initialize the repo on first run (`git init`, `git remote add origin https://github.com/erezev-debug/tantra-yoga.git`), then ask Cowork to commit and push after each meaningful change. That way every iteration is preserved and your iPhone gets it via GitHub Pages.
- **Don't let it rewrite the whole file.** Ask for targeted changes — "modify the picker to add a search box" or "add a manifest.json for PWA install." Edits to one section are safer than full rewrites at this size.
- **Sound on iOS** has quirks: Web Audio requires a user gesture before playing. If audio doesn't fire on your phone, the first tap on Play should unlock it.
- **localStorage** scope is per-origin. Once you switch from a local file to GitHub Pages, the data starts fresh on that origin. Don't be surprised when saved sequences don't carry over.
