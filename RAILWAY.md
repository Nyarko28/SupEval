# Deploy on Railway (PHP only — no Java)

This app ships a **Dockerfile** that runs **Apache + PHP** with the same URL layout as your local setup: **`/`** for the app root and **`/saas/...`** for the UI (see `public/index.php` routing).

## What you get

- **Web app** from this repo’s `Dockerfile`.
- **MySQL** from Railway’s MySQL plugin (variables `MYSQL_*` are read automatically by `Database.php`).
- **PHP evaluation scoring** — leave **`evaluation_service_url` empty** in Platform Settings (default in `schema_railway.sql`). Do **not** run the Spring Boot service.

## Steps

1. **Push code** to GitHub/GitLab.

2. **New project** on [Railway](https://railway.app) → **Deploy from GitHub** → select this repo.

3. **Add MySQL**  
   - New → **Database** → **MySQL**.  
   - **Connect** the MySQL service to your web service (same project) so Railway injects `MYSQL_HOST`, `MYSQL_PORT`, `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_DATABASE` into the web service.

4. **Build**  
   Railway detects the root **`Dockerfile`** and builds it.

5. **Initialize the database** (one-time)  
   - Install [Railway CLI](https://docs.railway.app/develop/cli) and `mysql` client, **or** use Railway’s MySQL **Data** / **Query** tab.

   Import **`sql/schema_railway.sql`** into the **same database** Railway created (`MYSQL_DATABASE`, often `railway`):

   ```bash
   railway connect mysql
   # then in another terminal:
   mysql -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASSWORD $MYSQLDATABASE < sql/schema_railway.sql
   ```

   (Use the exact variable names from Railway’s **Variables** tab for your MySQL plugin.)

   Or paste the contents of `sql/schema_railway.sql` into the MySQL console.

6. **Optional migrations**  
   If you later add columns (e.g. `migrate_payment.php`), run those on the same DB.

7. **Open the app**  
   Railway gives you a URL like `https://your-app.up.railway.app/saas/login`  
   Default admin: **`admin@saas.com`** / **`admin123`** (change after first login).

## Environment variables

| Variable | Required | Notes |
|----------|----------|--------|
| `MYSQL_*` | Yes (from plugin) | Railway injects when MySQL is linked. |
| `DB_*` | No | Optional override; otherwise `MYSQL_*` is used. |
| `PORT` | Auto | Set by Railway; **do not set manually** in normal use. |

**PHP-only scoring:** keep **`evaluation_service_url`** empty in **Platform Settings** (or in DB `settings`). No `EVALUATION_SERVICE_URL` needed.

## Troubleshooting

- **502 / blank page** — Check deploy logs; confirm MySQL import succeeded and `MYSQL_*` are present on the web service.
- **Wrong DB host** — Ensure MySQL service is **linked** to the web service so variables are injected.
- **404 on `/`** — Use **`/saas/login`** (or `/saas/`) as the app entry; the app is built under the `/saas` prefix.

## Cost

Railway’s free tier / credits change over time; check [railway.app/pricing](https://railway.app/pricing). For a small demo, usage is often low, but **not guaranteed free forever**.
