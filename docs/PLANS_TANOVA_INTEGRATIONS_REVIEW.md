# Vendor and admin: plans, subscriptions, Tanova and integrations

Review of how the platform team and a business work together (2026-09-25): what works, what was wrong, what was fixed, and what still needs a decision.

## 1. How a business gets started, and what was there

1. A customer applies with **Become a vendor**; an administrator approves it (**Users › Upgrade Request**). Approval gives the vendor role and sends the welcome e-mail. It does not give a plan.
2. The administrator assigns a plan by hand (**Vendor › Subscriptions › Assign**): plan, monthly or yearly, start date, amount. This writes a subscription record and sets the business's plan and expiry date.
3. The plan is a list of rules per listing type: enabled or not, a maximum, and whether new listings publish automatically.
4. A business sees its plan and history under **My Subscription**. It cannot buy or change a plan itself: the page says to contact the administrator. Payment is recorded by hand ("manual").

Live today: 4 businesses with an Enterprise plan (three complimentary until 1 April 2027, one until 2031) and one business with no plan.

## 2. Plans and subscriptions: what works

- **Admin screens work**: plan list, subscription list, assigning a plan (tested end to end: the plan, the expiry and a subscription record are written, and the business carries on).
- **The API enforces the plan**: creating a listing without an active subscription returns 402, a type the plan excludes or a maximum reached returns 403.

## 3. What was wrong, and what is fixed

| Problem | Fixed |
|---|---|
| **The portal ignored the plan.** The API refused a business without a plan, but the portal's own "add listing" screens let anyone through, with no plan, an expired plan or a plan that excludes the type. | The portal's create screens now follow the same rule as the API, from one shared piece of code. Only creating is stopped: editing, bookings, invoices, payments and customers are never switched off by a plan. |
| **No warning.** A plan could end, or never have been assigned, and nobody was told. | A notice above the portal pages: no plan, ended on a date, or ends in N days. |
| **Ended subscriptions stayed "Active"** in the admin list, because the job that would mark them expired is switched off. | A new daily job marks ended subscriptions expired and reports plan fields that disagree with subscriptions. It found one: a live business on a plan to 2031 with no subscription record (`--fix` writes the record). |

## 4. Still to decide

1. **Three plan systems.** The older "User Plans" (Basic 199, Standard 499, Extended 799 a month; used by nothing, no purchases) sit beside the "Vendor Plans" that are actually used (Starter 99, Professional 399, Enterprise 799). The admin menu shows both, and vendors can reach "My Plans". Recommend retiring the older one for vendors.
2. **Self-service.** Vendors cannot pay for or change a plan. Recommend the platform bills them through TourPay (the platform is itself a business there) and assigns the plan when the invoice is paid.
3. **~~Approval gives no plan.~~ Done (2026-09-26):** a company that signs up starts a free trial (default 14 days on the cheapest published plan; length and plan are set in Admin › Settings › Vendor). Companies approved by hand from an old request still need a plan assigned.
4. **Commission is not in the plan.** The plan's commission fields are all zero and unused; the real rate is a platform default of 10%, with an optional override per business. Decide where the commission belongs.
5. **Subscription screens use the payout permissions** (`vendor_payout_view` and `vendor_payout_manage`). Give them their own.

## 5. Tanova (`/user/tanova`)

- **A business could not open the marketplace trips made for it.** The page decided ownership from a `vendor_id` on the user that does not exist, so it was always 0. A business saw only trips it created itself (in the copy of live data I tested against, LuxSav has 52 marketplace trips it could not see or open). Other businesses' trips were correctly hidden.
- **Staff saw only their own trips**, never a platform-wide view.
- **A booking or invoice made from a trip could land on the wrong business** (the person who pressed the button, not the trip's business).
- **Fixed:** access is decided by business, in one place; staff can look across all businesses with `?all=1`; bookings and invoices from a trip belong to the trip's business. Tests cover a business's own and marketplace trips, other businesses' trips (always not found), staff, and invoices.

## 6. Integrations (`/admin/integrations`, `/user/integrations`)

- **Only 3 of the 27 services do anything**: Wetu, Fiscalize and now WhatsApp Cloud. The other 24 save their credentials, encrypted, and nothing reads them.
- **WhatsApp could never send.** It looked for credentials in fields on the user record that do not exist, so "send invoice by WhatsApp", WhatsApp reminders, scheduled messages and inbox replies all reported "not connected" even after the WhatsApp Cloud card was filled in. **Fixed:** WhatsApp now sends through the credentials saved in the hub, per business; its Test connection asks WhatsApp for real; tests confirm it uses only that business's own number.
- **The cards now say the truth**: a "Saved only" tag and a note on the ones the portal does not use yet, and the Payments cards point to where invoice payments really are set up (Finance › TourPay › Settings).
- **Still open**: the old Facebook Messenger and Telegram pages also write to fields that do not exist (no migration creates them); decide whether to build them properly or remove them.
