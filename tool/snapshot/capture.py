#!/usr/bin/env python3
"""Capture a snapshot of live luxsav.com content for design builds.

Writes assets/fixtures/luxsav_snapshot.json and resized images under
assets/images/luxsav/. Re-run to refresh; the app never calls the network
for this content until the live data layer lands (merge plan, Step 4).

Only items with a real photo are kept. Many products on the site point at
img/activities/default.jpg, and many stay images are grey "600x600" placeholder
graphics rather than photos; both are skipped.
"""
MAX_ACTIVITIES = 14
MAX_DAY_TRIPS = 8
import io, json, os, re, shutil, sys, urllib.request, urllib.parse
from PIL import Image, ImageStat

BASE = "https://luxsav.com"
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
IMG_DIR = os.path.join(ROOT, "assets", "images", "luxsav")
OUT = os.path.join(ROOT, "assets", "fixtures", "luxsav_snapshot.json")
UA = {"User-Agent": "LuxSavCompanion-snapshot/1.0"}

def get_json(path):
    with urllib.request.urlopen(urllib.request.Request(BASE + path, headers=UA), timeout=40) as r:
        return json.load(r)

def image_url(raw, folder):
    if not raw or raw.rstrip("/").endswith("default.jpg"):
        return None
    return raw if raw.startswith("http") else f"{BASE}/img/{folder}/{urllib.parse.quote(raw)}"

def fetch_image(url, name, width=720):
    """Download, resize to `width`, save as JPEG. Returns the Flutter asset path."""
    os.makedirs(IMG_DIR, exist_ok=True)
    try:
        with urllib.request.urlopen(urllib.request.Request(url, headers=UA), timeout=40) as r:
            im = Image.open(io.BytesIO(r.read())).convert("RGB")
    except Exception as e:
        print(f"  skip {name}: {e}", file=sys.stderr)
        return None
    # Placeholder graphics are near-uniform; real photos have colour variance.
    if max(ImageStat.Stat(im.resize((64, 64))).stddev) < 18:
        print(f"  skip {name}: placeholder image", file=sys.stderr)
        return None
    if im.width > width:
        im = im.resize((width, round(im.height * width / im.width)), Image.LANCZOS)
    fname = re.sub(r"[^a-z0-9]+", "_", name.lower()).strip("_") + ".jpg"
    im.save(os.path.join(IMG_DIR, fname), quality=70, optimize=True, progressive=True)
    return f"assets/images/luxsav/{fname}"

def main():
    shutil.rmtree(IMG_DIR, ignore_errors=True)  # start clean so dropped items don't linger
    snap = {"source": BASE, "destinations": [], "stays": [], "experiences": []}

    for d in get_json("/api/search/destinations")["destinations"]:
        url = image_url(d.get("image"), "destinations")
        asset = url and fetch_image(url, "dest_" + d["name"], width=1000)
        if asset:
            snap["destinations"].append({"id": d["id"], "name": d["name"], "country": d["country"],
                                         "experiences": d.get("activities", 0), "stays": d.get("hotels", 0),
                                         "image": asset})

    # Only Victoria Falls and Nyanga stays currently have real photos on the
    # site; every other destination's stays share a placeholder (1.png).
    stays, seen_stays = [], set()
    for q in ("victoria", "nyanga"):
        for h in get_json(f"/api/search/stays?q={q}")["hotels"]:
            if h["id"] not in seen_stays:
                seen_stays.add(h["id"])
                stays.append(h)
    for h in stays:
        url = image_url(h.get("image"), "accommodation")
        asset = url and fetch_image(url, "stay_" + h["name"])
        if asset:
            snap["stays"].append({"id": h["id"], "name": h["name"], "destination": h["destination"],
                                  "country": h["country"], "price": int(float(h["price"] or 0)),
                                  "price_unit": "per night", "image": asset})

    seen = set()
    limits = {"activity": MAX_ACTIVITIES, "day_trip": MAX_DAY_TRIPS, "package": MAX_DAY_TRIPS}
    for kind, path in [("activity", "/api/search/activities?q=victoria"),
                       ("day_trip", "/api/search/daytrips?q="),
                       ("package", "/api/search/multiday?q=")]:
        taken = 0
        for a in get_json(path)["activities"]:
            if a["id"] in seen or taken >= limits[kind]:
                continue
            url = image_url(a.get("image"), "activities")
            asset = url and fetch_image(url, f"exp_{a['id']}_{a['name']}")
            if asset:
                seen.add(a["id"])
                taken += 1
                snap["experiences"].append({"id": a["id"], "name": a["name"], "category": kind,
                                            "destination": a["destination"], "country": a["country"],
                                            "type": a.get("activity_type", ""), "duration_hours": a.get("duration"),
                                            "price": int(float(str(a["price"]).replace(",", "") or 0)),
                                            "price_unit": "per person", "image": asset})

    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w") as f:
        json.dump(snap, f, indent=2, ensure_ascii=False)
    print(f"destinations {len(snap['destinations'])} · stays {len(snap['stays'])} · experiences {len(snap['experiences'])}")

if __name__ == "__main__":
    main()
