# Plan: business types, plans, sign-up and the vendor navigation

Written 2026-09-26. Nothing here is built yet; it is the plan, with the decisions it needs from you at the end.

## 1. What you told me, in one sentence

Different companies use the portal for different things (a transfers company, an activities company, a tour guide, a lodge, or all of it), so what a company **sees**, what it can **create**, and what it **pays** should follow what it **offers**: split the catalogue by business type, present each type as a Tanova OS, sell plans built on those types, let a company choose its types and a plan when it signs up, and give the companies that do everything an all-in-one plan.

## 2. Where we are today (facts)

- A vendor's sidebar has **about 49 entries in 10 groups**. Catalog alone is 12 entries in 7 sub-groups (Stays, Activities, Transport, Dining, All catalogs, Access, Pricing and Add-ons).
- **Every company sees every catalogue.** A lodge sees Tours, Boats, Flights and Visas; a transfers company sees Hotels and Events.
- **The plan machinery already knows about types.** A plan carries a rule per listing type (`hotel, space, tour, event, car, boat, flight`): enabled or not, a maximum, auto-publish. The portal now refuses creating a listing the plan does not include. But the **sidebar ignores it**: the "locked feature" block for menu entries exists in the code and is switched off (`gated` is empty).
- **The type names already exist**: the Integrations hub and the entries themselves already call them Stay OS, Exp OS, Trans OS, Airline OS, Event OS, Visa OS, Sale OS.
- **Two plan systems are visible to a vendor**: Settings › My Subscription (the real one) and My Plans (an older one with different names and prices, unused). Plans are also assigned by hand, and there is no choice at sign-up.
- **The trial is one size**: sign-up starts a 14-day trial on the cheapest plan whatever the company does.

## 3. My comments on the vendor navigation

What works: the dark and gold style is consistent, groups collapse, the active page is clear, and there is a slim mode.

What does not:

1. **Too many things at one level.** 49 entries; the Catalog group alone is longer than most whole menus. A new owner sees ten group headers and no idea where to start.
2. **It shows things that are not theirs.** Nothing adapts to what the company does (see above).
3. **Product codes as labels.** "Stay OS", "Exp OS", "Trans OS", "Event OS", "Airline OS", "Visa OS" and "Stay OS - Spaces" read like internal module names. A guide wants to see "Tours", a lodge "Rooms and stays".
4. **Two navigation systems overlap.** The top bar (Integrations, Concierge, Tanova, TourPay) repeats things that are also in the sidebar, and Integrations is only in the top bar.
5. **Duplicates and near-duplicates.** My Subscription and My Plans; Bookings and Booking History; Trending and Bestsellers, Analytics and Booking Report; TourPay and Statement.
6. **Pages inside pages listed as pages.** Marketing alone is seven entries (Loyalty, Scheduled Messages, Occasions, Holiday Greetings, Email Campaigns, Coupon, News) that belong together as one area with tabs.
7. **Money features most companies never use** (My Wallet, Payouts) sit next to the ones they use daily. They only matter when the platform collects money for you.
8. **Inconsistent wording**: "Coupon" (singular), "Manage News", "Team (staff)", "API & Website Docs", "Catalogs" beside "Catalog".
9. **"NEW" pills on eight entries** mean nothing when they are everywhere.
10. **Settings holds the plan**, buried at the bottom of the menu, when the plan is the thing that decides everything else.

## 4. The model

### 4.1 Business types (Tanova OS)

| Tanova OS | For | Listings it unlocks |
|---|---|---|
| **Stay OS** | lodges, hotels, guest houses, villas | hotels and rooms, spaces |
| **Exp OS** | tour operators, guides, activity providers | tours and experiences, departures, itineraries |
| **Trans OS** | transfer companies, car hire, boat operators | cars, boats |
| **Event OS** | event organisers, ticketing | events |
| **Airline OS** | airlines and ticketing agents | flights, airlines, airports, seat types |
| **Visa OS** | visa and travel-document services | visa types and forms |

Every company also gets the **business core**, whatever it offers: bookings, customers, TourPay (invoices, quotes, payments, bills, statement), staff, reports, help. And a set of **growth features** that plans switch on: marketing tools, the API and webhooks, integrations, and **Tanova AI** (marketplace listing, concierge, AI planning, itinerary builder, inbox).

Dining (meals and restaurants) is not a business type: it belongs to trip planning, so it moves under Tanova AI with the itinerary builder.

A company chooses **which OS it operates** (one, several or all). That choice, together with its plan, is what it sees and can create.

### 4.2 Plans

Plans differ on three things: **how many OS**, **how much** (listings, staff), and **which growth features**. A draft (numbers to be set by you):

| | Solo | Business | All-in-one |
|---|---|---|---|
| For | one kind of business: a guide, a lodge, a transfer company | a company that combines a few (lodge + activities + transfers) | a tour operator or DMC that sells everything |
| Tanova OS | 1 of your choice | up to 3 | all |
| Listings per type | small cap | larger cap | unlimited |
| Staff seats | 2 | 10 | unlimited |
| Business core (bookings, TourPay, customers) | yes | yes | yes |
| Marketing tools | basic | full | full |
| Tanova AI (marketplace, concierge) | marketplace listing | + concierge | everything, AI planning |
| API and integrations | no | read | full, webhooks |
| Support | help | e-mail | priority |

Today's three plans (Starter 99, Professional 399, Enterprise 799) map onto this: Enterprise becomes All-in-one. The four live companies are all on Enterprise and stay all-in-one.

### 4.3 What a company "has"

**Effective modules = the OS it chose, limited by what its plan allows.** A Solo company that picked Trans OS sees Transport and nothing else in the catalogue; if it wants Stay OS too, it upgrades. All-in-one sees everything. The same rule drives four things at once: the navigation (hide, or show locked with an upgrade prompt), the create screens (already refused by plan), the API (already refused by plan), and which Tanova marketplace categories the company can appear in.

## 5. The navigation, redesigned

Built from the model, so a company only sees its own world. For a **lodge on a Solo plan** (about 22 entries instead of 49):

```
Home
  Dashboard
  Today
  Team
Bookings
  Bookings
  Check-in
  Enquiries
  Customers
Stays                      <- only the OS it operates
  Rooms and stays          (hotels, rooms, spaces as tabs)
  Pricing and extras
Money
  TourPay                  (invoices, quotes, payments, bills, statement as tabs)
Grow
  Marketing                (loyalty, campaigns, messages, coupons, news as tabs)
  Reports
Tanova
  Marketplace
Company
  Plan and billing         (subscription, usage, upgrade)
  Integrations
  API                      (if the plan has it)
  Help
```

The rules:

1. **Top level is at most eight groups**, and each group shows at most five entries.
2. **One entry per business type**, named in plain words (Stays, Activities, Transport, Events, Flights, Visas), each opening one screen with tabs for its parts. "Stay OS" appears as a small badge, not as the label.
3. **Hubs, not lists.** Marketing, Money and Reports become one entry each with tabs. Each tab is what is a sidebar entry today, so no feature is lost.
4. **Plan-aware.** An OS the plan excludes is hidden; one the plan could have if upgraded shows once, muted, as "Add Trans OS". Growth features work the same way.
5. **Role-aware.** Staff see only what the owner gave them (already built); wallet and payouts show only when the platform collects money for the company.
6. **One navigation.** The top bar keeps only account things (plan, help, notifications, sign out); Tanova, TourPay, Integrations and Concierge live in the sidebar.
7. **Duplicates go**: My Plans, All Catalogs, Booking History (a filter on Bookings), Trending and Booking Report become tabs of Reports.
8. **A company with all OS** still gets the same eight groups: Stays, Activities, Transport, Events, Flights, Visas become entries in one "Products" group with a switcher, not seven sub-groups.

## 6. Sign-up with a plan

The company and owner step you like stays as step 1. Then:

1. **Your company and you** (existing).
2. **What do you offer?** One card per OS with an icon and one line ("Accommodation: lodges, hotels, villas"). Pick one or more.
3. **Choose your plan.** Cards for Solo, Business and All-in-one, with a monthly/annual switch. The one that fits the choices is pre-selected and marked "Recommended for you". Picking more OS than the plan allows shows why and suggests the next plan. **The 14-day trial starts on the chosen plan**, with no card.
4. **Verify your email**, then a **getting-started list tailored to what they picked** (a lodge is asked to add a room and a rate; a transfers company a vehicle and a route).

When the trial ends: a notice 7, 3 and 1 day before; then the company keeps its data, bookings and invoices, but cannot add listings (already how plans work) until it pays.

## 7. Plan and billing (one place)

**For a company** (replaces My Subscription and My Plans): the current plan and its OS; usage meters (listings per type, staff seats); the plan's features; the trial or renewal date; **Change plan** (upgrade at once, downgrade at the next renewal, with a clear list of what would be hidden); invoices for the plan.

**For you, the super admin** (Admin › Vendor Plans and Subscriptions):
- **Plan builder**: name, price monthly and annual, trial days, OS allowed, caps per type, seats, feature switches, public or hidden, highlight.
- **Company directory**: every company with its OS, plan, usage, trial end and renewal, and quick actions (change plan, extend a trial, add an OS).
- **Money**: monthly recurring revenue, trials ending, expired.

**Paying the platform** uses what already exists: you are a business in TourPay, so a plan renewal is an **invoice from you to the company**, paid through your gateways with the pay link; paying it extends the subscription automatically. Reminders reuse the invoice reminders.

## 8. Data model changes

- `core_vendor_plans`: add `os_limit` (1, 3, 0 = all), `max_staff`, `trial_days`, `price_annual`, `features` (JSON), `is_public`, `sort_order`, `highlight`.
- `core_vendor_plan_meta`: kept (per listing type: enable, maximum, auto-publish); generated from the OS mapping when a plan is edited, so plans stay easy to define.
- **New** `vendor_company_os` (vendor, OS key): which OS a company operates.
- **New** `config/os_modules.php`: OS to listing types to menu entries to marketplace category, the single place that says what "Stay OS" is.
- `vendor_subscriptions`: add the OS set and `billing_cycle` used; keep the history.
- `PlanLimits`: effective modules, seats left, feature checks, used by the navigation, the create screens, the API and the team screen.
- Retire the older user-plan tables from the vendor's view (kept for history).
- Sidebar: driven by `config/os_modules.php`, plan and role, replacing today's fixed lists; the existing `gated` block is reused for "upgrade to add".

## 9. Showcasing by Tanova OS

- A company's profile and its marketplace listing carry its OS badges ("Stay OS + Exp OS").
- The Tanova marketplace is grouped by OS (Stay, Exp, Trans, Event); today it lists tours only, so **stays and transfers become listable** as part of this.
- The API `me` response says which OS and plan a company has, so a company's own website can show the same badges.
- The integrations hub keeps its existing OS categories, so the same names run through the product.

## 10. Phases

| Phase | What | Rough effort |
|---|---|---|
| 0 | Your decisions (section 12): types, plan lineup and prices, billing method | you |
| 1 | Foundation: OS table and config, plan columns, effective modules, tests; existing companies migrated as all-in-one | 3 days |
| 2 | Navigation: data-driven sidebar, plain-language names, hubs (Marketing, Money, Reports), removal of duplicates, locked-with-upgrade entries, one navigation | 4 days |
| 3 | Sign-up: OS step, plan step, trial on the chosen plan, tailored getting-started list | 3 days |
| 4 | Plan and billing pages for companies, plan builder and company directory for you | 4 days |
| 5 | Billing through TourPay: renewal invoices, automatic extension, reminders, trial-ending emails | 3 days |
| 6 | Tanova OS showcase: marketplace by OS (stays, transfers), badges, API | 4 days |

Phases 1 and 2 give the visible relief first (a lodge stops seeing tours). Each phase ends with tests and can be shipped alone.

## 11. Risks

- **Existing companies** must not lose anything: they are migrated as all-in-one on their current plan and see the new navigation with everything present.
- **Downgrades** must never delete data: excess listings stay, read-only, and cannot be added to.
- **Staff modules** (already built) map onto the new hubs; the mapping is updated with the navigation and covered by the same "every page is placed" test.
- **Renaming** entries changes what people are used to: keep a search-style "Go to..." for the first weeks.
- **Prices and billing** are business decisions, so the plan builder makes them editable rather than fixed in code.

## 12. Decisions I need from you

1. **The OS list**: are the six above right? Should Visa OS and Airline OS be offered at sign-up or only added by you?
2. **Where Dining and Tanova AI sit**: as features of a plan (my proposal), or as an OS of their own?
3. **The plan lineup**: three plans (Solo, Business, All-in-one) with these limits, or a different split? And the prices, monthly and annual.
4. **How many OS a Solo plan allows** (1?) and what a company does when it wants a second one: upgrade, or buy an add-on OS for a fixed price?
5. **Trial**: 14 days on the chosen plan, no card. Same for all plans?
6. **Paying the platform**: through TourPay invoices (my proposal) at first, or a card on file later?
7. **Staff seats** as a plan limit: yes?
8. **Names**: keep "Stay OS / Exp OS / Trans OS" as visible brand names next to plain labels, or plain labels only?
9. **The four live companies**: confirm they stay all-in-one with their current end dates.
