# LuxSav Companion — Merge & Alignment Plan

How the purchased Motel UI kit becomes the LuxSav app: first the look and feel,
then the merge with `luxsav_app`, then aligning every screen to how luxsav.com
actually works.

---

## 0. Done so far

| Item | Result |
|---|---|
| Kit moved out of Downloads | `/home/lionel/Documents/Work/luxsav_companion` (next to `luxsav_app`) |
| Untouched original | `~/Downloads/codecanyon-RcUPDP2Q-hotel-booking-flutter-ui-kit.zip` |
| Kit docs & icon sources | `kit_reference/` (local only, not in git) |
| Version control | `9894a62` pristine kit baseline · `aa4fb03` filename-case fix |
| Health | `flutter analyze`: **0 errors** (119 style hints) |

The kit **did not compile on Linux as shipped**: three files had capital letters
(`tab_button_UI.dart`, `filter_bar_UI.dart`, `sign_up_Screen.dart`) that the imports
spell in lowercase. Fixed in `aa4fb03`.

### Progress on branch `feat/look-and-feel`

| Commit | What | Status |
|---|---|---|
| `4cd5fb7` | Identity: package, app ID `com.peachpy.luxsav`, app name | Done |
| `68847ca` | luxsav.com colours; colour picker removed | Done |
| `a26e41a` `7c8a079` | Bundled fonts; Cormorant Garamond headings; font picker removed | Done |
| `2135616` | Whole-codebase `dart format` (no functional change) | Done |
| `85de59d` | Flat components, luxsav.com buttons, heading/card/price text roles | Done |
| `3d6fe88` | App icon, logo, native launch colour, Victoria Falls splash | Done |
| `8323845` | Real LuxSav content from a luxsav.com snapshot; price units | Done |
| `a8a92c7` | English copy in LuxSav's voice | Done |
| `a15845f` | Onboarding photography | Done |
| `e3d8439` | Five-tab shell, Today, Tanova planner (Step 2 donor pieces) | Done |
| — | Named routes | **Deferred to Step 3**: deep-link targets need real product IDs and trip tokens |

Before/after screenshots are in `docs/look-and-feel/`.

`luxsav_app` is untouched. It is now a **donor**: pieces are copied out of it, and it
is archived once Step 2 is finished.

---

## Principles

1. **luxsav.com is the source of truth** — for the brand, the data and the rules.
   The app never invents something the platform already knows: prices, categories,
   capacity, ratings.
2. **One framework.** The kit runs on GetX. Code taken from `luxsav_app` (Riverpod,
   go_router) is rewritten into GetX, never mixed in.
3. **Sample data is fine in design builds; nothing fake reaches travellers.** The kit's
   sample ratings and distances stay while we review the look and feel. Before launch,
   each is either fed by real data or removed.
4. **Small commits.** The app builds after every step.
5. **Offline-first from day one.** Fonts are bundled, not downloaded at launch.

---

## Step 1 — Look and feel

### 1.1 Identity

| | Kit today | LuxSav |
|---|---|---|
| Dart package | `new_motel` (every `package:new_motel/` import) | `luxsav_companion` |
| Android app ID | `com.example.new_motel` | `com.peachpy.luxsav` |
| iOS bundle ID | `com.example.newMotel` | `com.peachpy.luxsav` |
| App name | Motel | LuxSav |
| Icon & splash | Motel artwork | From luxsav.com: `luxsav-gold.png`, `luxsav-white.png`, `luxsav-favicon.png` |

The app ID cannot be changed after the first store release. **Decided:** `com.peachpy.luxsav`.

### 1.2 Colours — match luxsav.com, not the old scaffold

The old `luxsav_app` used an ink-and-brass palette with Fraunces. **That was never the
LuxSav brand.** The live site (`public/css/tsoka/tsoka.css`) uses:

| Token (site) | Value | Role in the app |
|---|---|---|
| `--lux-primary` | `#1F4D3A` forest green | Primary buttons, selected tab, key headers |
| `--lux-primary-hover` | `#2E6B53` | Pressed states |
| `--tsoka-gold` | `#D6B87A` champagne gold | Accent **on dark surfaces only**; Tanova marker |
| `--tsoka-gold-on-light` | `#7A5C28` | Gold text and icons on light backgrounds |
| `--tsoka-ivory` | `#F6F5F1` | App background |
| `--tsoka-cream` | `#EAE7E0` | Section and alternate card backgrounds |
| `--tsoka-charcoal` | `#1C1C1C` | Text; dark-mode base |
| `--lux-border` | `#D9D9D9` | Hairline borders |
| Radii | 4 / 8 / 16 px | Inputs / cards / sheets |

The site's own stylesheet warns that `#D6B87A` fails contrast on light backgrounds and
uses `#7A5C28` there instead. The app follows the same rule.

The kit keeps its colours in `lib/constants/themes.dart`, but uses `primaryColor` in
**79 places** — for buttons *and* for prices, stars and icons. Each use is reviewed and
mapped to the right role, rather than swapping one colour for another wholesale.

*Correction:* the kit's default accent is teal (`#4FBE9F`), chosen from a user colour
picker with four options; red `#AC0000` is only its error colour. The picker is removed.

**Dark mode:** luxsav.com has none. Either design one (charcoal base, green surfaces,
gold accent) or ship light-only first — **decision**.

### 1.3 Typography

| Kit today | LuxSav (same as the site) |
|---|---|
| Six Google fonts: Dancing Script, Kaushan Script, Montserrat, Satisfy, Varela, Work Sans — downloaded at launch | **Cormorant Garamond** for headings, card names and prices; **Inter** for all UI text |

*Correction:* an earlier version of this plan said Playfair Display. luxsav.com loads
Playfair but never uses it — every heading, card name and price on the site is set in
Cormorant Garamond (51 uses against 0).

Fonts are bundled in `assets/fonts/` instead of using `google_fonts` at runtime, so
they render with no signal and there is no font flash on first launch.

### 1.4 Components

Restyled to match the site rather than the kit:

- **Buttons:** site style — uppercase, 0.15em letter-spacing, medium weight, 6px
  radius, green fill with white text (primary), outline and dark variants.
- **Cards:** flat with a hairline `#D9D9D9` border instead of the kit's drop shadows.
- **Chips, inputs, calendar, range slider:** recoloured to green, gold and ivory.
- **Map styles:** `mapstyle_light.json` / `mapstyle_dark.json` retinted to the palette.

### 1.5 Navigation shell

- Kit: 3 tabs (Explore, My Trips, Profile).
- LuxSav: **Today · Trip · [Tanova] · Explore · You**, with Tanova as the raised
  centre button (shell design taken from `luxsav_app`).
- Today and Tanova start as designed screens showing real LuxSav content.
- The kit opens screens with **24 direct pushes** plus a `routes:` map. These move to
  GetX named routes (`getPages`) with parameters — for example
  `/experience/:id`, `/trip/:token/:package` — so links from luxsav.com and push
  notifications can open a specific screen later.

### 1.6 Content and copy

- **Real LuxSav content:** capture JSON snapshots of the live APIs (the 7 destinations,
  experiences by category, stays, one real trip) into `assets/fixtures/`. A temporary
  adapter feeds them into the kit's existing screens, so the look and feel is reviewed
  against LuxSav products, not hotels.
- **Sample ratings and distances stay** in design builds so the screens look complete.
  Hotel stock photos are swapped for LuxSav images, since those are part of the look.
- **Copy:** 193 translatable strings rewritten from hotel wording ("rooms", "hotels")
  to LuxSav wording (experiences, day trips, packages, stays).
- **Languages:** the kit ships English, Arabic, French and Japanese. **Decision:**
  English only at launch, or English + Arabic (Dubai has the largest LuxSav inventory,
  66 experiences)? Japanese is dropped either way.

### 1.7 What Step 1 delivers

A design-review build. To be clear up front: it shows **real LuxSav content from a
snapshot**, not live data — live data is Step 4.

It passes when:
- Side by side with luxsav.com, it is recognisably the same brand.
- Every screen shows LuxSav destinations and products; no hotel wording remains.
- Text renders correctly with airplane mode on.

---

## Step 2 — Merge the donor (`luxsav_app`)

| Piece | From `luxsav_app` | Into `luxsav_companion` | Change needed |
|---|---|---|---|
| Tanova planner | `screens/plan_trip_screen.dart`, `models/planning.dart` | `modules/tanova/` | Riverpod → GetX controller; fields aligned to the web planner (Step 3.2) |
| Trip model | `models/trip.dart` | `models/trip/` | Reshaped to the `/api/trips/{token}/{package}` response |
| 5-tab shell + raised Tanova button | `shell/main_shell.dart` | `modules/bottom_tab/` | Rebuilt on the kit's tab widgets |
| Shared widgets | `widgets/lux_widgets.dart` (card, chip, guest stepper, budget range) | `widgets/` | Restyled to luxsav.com tokens |
| Today states (no trip / upcoming / active) | `screens/today_screen.dart` | `modules/today/` | GetX; real trip data |

**Deliberately not taken:** the ink-and-brass `app_theme.dart` (wrong brand),
go_router and Riverpod (second framework), and `Trip.sample` (hard-coded data).

`luxsav_app` is archived read-only once this step is complete, not deleted.

---

## Step 3 — Align to how LuxSav works

### 3.1 Replace the hotel model with the LuxSav catalogue

| Kit concept | LuxSav concept | Source on the platform |
|---|---|---|
| `HotelListData` | **Product**: stay · activity · day trip · package | `lux_activities` (`category`), `lux_accomodations` (74 stays) |
| title / subtitle / image | name, destination, image | product name, `lux_places`, images under luxsav.com `img/` |
| `perNight` | **price + unit** | Experiences: price **per person** (the column is misleadingly named `cost_per_night`). Stays: per night |
| `RoomData` | room type | `lux_acco_rooms` — only **13 room types across 74 stays**, so most stays have none; the room picker must handle that |
| rating / reviews | **guest reviews** | `lux_guest_reviews` already exists — linked to booking and trip, with rating, text and approval — but is empty. The app asks for a review when a trip ends; real reviews replace the sample ratings |
| distance | distance from the traveller or their lodge | Sample values until locations exist |
| `LatLng` location | location | Not stored. Stays have addresses and can be geocoded; experiences need locations added |
| rooms & people pop-up | **party**: adults, children with ages, rooms | Child rates are age-banded per supplier, so ages matter, not just a count |
| date | dates | Multi-day: date range. Day trip: one date plus a start–end time |
| city search | destination | `lux_places` — 7 destinations |

### 3.2 Rules the app must follow

1. **Categories come from the platform.** Activity 0–4 h, day trip 5–23 h, package
   24 h+ (`lux_activities.category`). The app never works this out itself.
2. **Trip type is the first question**, exactly as on luxsav.com:
   - Day trip → destination → party → budget → date → time window →
     `/api/search/daytrips`
   - Multi-day → destination → party → budget → date range → Tanova
3. **Party size:** 1–7 travellers in the planner (the web limit). Each product's own
   minimum and maximum are enforced by the platform.
4. **Budget is a total for the whole party**, not per person.
5. **Prices come from the platform.** The app never adds up a total itself. Until the
   pricing engine exists, every price shows its unit ("per person", "per night").
6. **Tanova returns several package options per plan.** The traveller picks one; a
   trip is `token + package`. The package number is 0-based in URLs and 1-based in the
   database — handled only inside the trip repository.
7. **A day is ordered** by day, then time slot (1 morning → 3 evening).
8. **Formats:** the platform sends dates as `MM/DD/YYYY` and times as 24 h `HH:MM`;
   the app only reformats them for display.
9. **Currency:** prices are USD, with some supplier rates in ZAR. The kit's currency
   screen becomes a display preference, clearly marked approximate; bookings are
   always charged in the platform's currency.
10. **Bookings:** references look like `TSK-2026-074887`; statuses are pending,
    confirmed and canceled. Looking one up must also require the email, because
    references are easy to guess.
11. **Accounts:** luxsav.com has none. The kit's sign-in and sign-up screens stay in
    the code but are hidden behind a flag until the accounts decision — no pretend
    login that simply opens the app.
12. **Payments happen on the platform.** The app never handles card details itself.

### 3.3 Screen by screen

| Kit screen | Becomes | Data | Notes |
|---|---|---|---|
| `splash`, `introduction_screen` | LuxSav onboarding | Static | Three intro pages rewritten around Today, Tanova and Explore |
| `home_explore` (slider, categories, popular) | Explore home | 7 destinations, categories, popular products | Slider uses destination banners |
| `hotel_home_screen`, `filters_screen`, `map_hotel_view` | Explore results | `/api/search/activities`, `daytrips`, `multiday`, `stays` | Filters: category, price, duration, part of day, party size. Map hidden until coordinates exist |
| `hotel_detailes` | Product detail | Experience or stay | Experiences show duration and time of day; stays show rooms and inclusions |
| `room_booking_screen`, `room_book_view` | Room choice | `lux_acco_rooms` | Only for stays that have room types |
| `calendar_pop_up_view`, `room_pop_up_view` | Dates & party picker | — | Shared with the Tanova planner |
| `search_screen` | Destination search | `lux_places` | |
| `reviews_list_screen`, `rating_view` | Reviews | `lux_guest_reviews` | Kept. Sample reviews in design builds; post-trip review prompt fills it with real ones |
| `my_trips_screen` (upcoming / finished / favourites) | Trips | `/api/trips`, bookings | Favourites become the wishlist, stored on the phone first |
| `login`, `sign_up`, `forgot_password`, `change_password` | Hidden behind a flag | — | Pending the accounts decision |
| `profile`, `edit_profile`, `settings`, `currency`, `country`, `help`, `invite`, `how_do` | You | Mostly static | Help uses LuxSav's real contacts (hello@luxsav.com, +27 64 691 7115) |
| — | **New:** Today, Tanova planner & chat, day timeline, item detail, Wallet | | Later milestones in the build plan |

---

## Step 4 — Data layer (leads into Milestone 1)

- HTTP client with one repository per area: catalogue, trips, bookings, places.
- A single switch between **snapshot data** and **live luxsav.com**, so design builds
  and live builds run the same code.
- One GetX controller per feature; screens never call the network directly.

---

## Order of work (Steps 1–2)

Indicative, one Flutter developer.

| # | Commit | Effort |
|---|---|---|
| 1 | Rename package, app IDs and app name | 0.5 day |
| 2 | Brand colours; review all 79 `primaryColor` uses | 1.5 days |
| 3 | Bundle Cormorant Garamond and Inter; remove the six kit fonts | 0.5 day |
| 4 | Restyle buttons, cards, chips, inputs, calendar, map styles | 2 days |
| 5 | LuxSav icon and splash | 0.5 day |
| 6 | Capture luxsav.com snapshots; adapter into kit screens; LuxSav images in place of hotel photos | 1 day |
| 7 | Rewrite copy; apply the language decision | 1 day |
| 8 | Named routes | 1 day |
| 9 | 5-tab shell; Today and Tanova screens ported from `luxsav_app` | 1.5 days |
| 10 | Tanova planner ported to GetX and aligned to the web flow | 2 days |
| | **Design-review build** | **≈ 11–12 working days** |

Step 3 (domain model) and Step 4 (live data) follow, and together with accounts they
make up Milestone 1 of the build plan.

---

## Decisions needed before commit 1

1. ~~**App ID**~~ — decided: `com.peachpy.luxsav`.
2. **Languages at launch** — English only, or English + Arabic?
3. **Dark mode** — design one now, or ship light-only first?
4. **Accounts** — decides whether sign-in screens appear at all.
5. **Contact details** for Help and concierge — confirm hello@luxsav.com and
   +27 64 691 7115.
6. ~~**Build plan PDF**~~ — done: version 3 uses the luxsav.com brand throughout,
   adds a codebase section, and changes the tagline to “Other apps stop at the sale.
   LuxSav runs the trip.” Source and all versions are in `docs/build-plan/`.
