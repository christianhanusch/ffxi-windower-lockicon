# LockIcon – Windower Addon (FFXI)

A minimal Windower addon that displays a **lock indicator** when **target lock-on** is active in *Final Fantasy XI*.

The addon is deliberately simple and UI-safe:
- **Image-only indicator** (icon + text baked into PNG)
- **Transparent background**
- Appears **only while locked**
- No background boxes, no font rendering, no UI clutter

---

## Features

- Shows a lock indicator **only when target lock-on is active**
- Uses a **single PNG image** (icon and text baked in)
- No Lua text rendering → no black background issues
- Clean, unobtrusive UI element
- Suitable for GitHub / GitLab distribution

---

## Installation

1. Copy the folder `lockicon` into your Windower addons directory:

   ```
   Windower/addons/lockicon
   ```

2. Load the addon in game:

   ```
   //lua l lockicon
   ```

---

## Behaviour

- The indicator is **visible only while a target is locked**
- It automatically hides when:
  - the target is unlocked
  - no target is selected

No interaction or configuration is required.

---

## Positioning

By default, the icon is anchored near the target reticle (screen centre) with a vertical offset.

You can adjust the position in game:

```text
//lockicon offset <dx> <dy>
```

Example:
```text
//lockicon offset 0 -160
```

You can also switch to a fixed position:

```text
//lockicon pos <x> <y>
```

---

## File Structure

```
lockicon/
├── lockicon.lua
├── lock.png
├── README.md
└── images/
    ├── one.jpg
    ├── two.jpg
```

---

## Demo

### Locked Target (Indicator Visible)
![Lock indicator visible](images/one.jpg)

### Unlocked / No Target (Indicator Hidden)
![Lock indicator hidden](images/two.jpg)

---

## Design Notes

- Text is intentionally **baked into the image** to avoid:
  - font inconsistencies
  - background rectangles
  - alignment issues
- The icon includes subtle padding to prevent clipping at larger sizes.

---

## License

Licensed under the Apache License, Version 2.0.  
See the LICENSE file for details.

---

## Author

Christian Hanusch
