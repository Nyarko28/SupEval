# Supplier Evaluation SaaS

A production-ready, multi-tenant Supplier Evaluation & Decision Support System built with PHP, MySQL, and Tailwind CSS.

## Features
- **Multi-Tenant SaaS**: Companies resolve to isolated data environments.
- **Role-Based Access**: System Admin, Company Admin, Evaluator, Viewer.
- **Supplier Management**: CRUD operations for suppliers.
- **Weighted Evaluation**: Define custom criteria and weights for scoring.
- **Automated Ranking**: Suppliers are ranked by average evaluation scores.
- **Subscription Management**: 3-month free trial with upgrade lock (Mock Payment).
- **Responsive UI**: Built with Tailwind CSS.

## Requirements
- PHP 7.4 or higher
- MySQL 5.7 or higher
- Apache/Nginx Web Server

## Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd saas
   ```

2. **Database Setup:**
   - Create a MySQL database named `supplier_saas`.
   - Import the schema:
     ```bash
     mysql -u root -p supplier_saas < sql/schema.sql
     ```
   - (Optional) Import seed data:
     ```bash
     mysql -u root -p supplier_saas < sql/seed.sql
     ```
   - *Note: Database credentials can be set via environment variables (`DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`). Defaults match local XAMPP (`localhost`, `supplier_saas`, `root`, empty password).*

3. **Platform settings (optional):**
   - Fresh installs using `sql/schema.sql` include a `settings` table with defaults.
   - If you upgrade an older database, run once: `php public/migrate_settings.php`
   - System Admin can set the **evaluation scoring service** base URL and fallback in **Platform Settings** (or use `EVALUATION_SERVICE_URL` / `EVALUATION_SERVICE_FALLBACK` in the environment).

4. **Configure Web Server:**
   - Point your web server's document root to the `public/` directory.
   - Ensure `mod_rewrite` is enabled if using Apache.
   - Example VirtualHost:
     ```apache
     <VirtualHost *:80>
         ServerName saas.local
         DocumentRoot "path/to/saas/public"
         <Directory "path/to/saas/public">
             AllowOverride All
             Require all granted
         </Directory>
     </VirtualHost>
     ```

5. **Access the Application:**
   - Open your browser and navigate to `http://localhost/saas/public` (or your configured virtual host).
   - **System Admin Creds:** `admin@saas.com` / `admin123`
   - **Seeder Company Admin:** `admin@acme.com` / `password`

## Docker

From the repository root:

```bash
docker compose up --build -d
```

- Web UI: `http://localhost:8080/saas/login`
- Evaluation API (Spring Boot): `http://localhost:8081/api/v1/health`
- MySQL: `localhost:3306` (user `root`, password `root`)

See `docker/README.txt` for environment variables and troubleshooting.

**Railway (PHP + MySQL, no Java):** see [`RAILWAY.md`](RAILWAY.md) and `sql/schema_railway.sql`.

## Directory Structure
- `public/`: Entry point (`index.php`) and assets.
- `src/`: Application source code.
    - `Config/`: Database connection.
    - `Controllers/`: Request logic.
    - `Models/`: Database interactions.
    - `Views/`: HTML templates.
- `sql/`: Database scripts.

## Deployment to Production
1. **Security**: Set `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` (and optional `EVALUATION_SERVICE_URL`, `SAAS_BASE_PATH`) in the server environment instead of hardcoding credentials.
2. **SSL**: Ensure HTTPS is enabled.
3. **Dependencies**: If using Composer packages, run `composer install --no-dev --optimize-autoloader`.
4. **Permissions**: Ensure web server has read access to all files.

## License
MIT
