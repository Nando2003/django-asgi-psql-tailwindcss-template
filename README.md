## How to run the project (development mode)

1. Clone the repository:
    ```bash
    $ git clone https://github.com/nando2003/django-wsgi-psql-tailwindcss-template.git
    ```

2. Install the dependencies:
    ```bash
    $ uv sync
    $ npm install
    ```

3. Set up the environment variables:
    ```bash
    $ cp .env.example .env
    # Edit the .env file to set your environment variables
    ```

4. Generate a Django secret key and set it in the `.env` file:
   ```bash
   $ uv run python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
   ```

5. Run the development container:
    ```bash
    $ docker compose up --build
    ```

6. Apply database migrations:
    ```bash
    $ docker compose exec app uv run --no-sync manage.py migrate
    ```

7. Run the tailwind watch:
   ```bash
    $ npm run watch
    ```

## How to run the project (production mode)

1. Change DJANGO_ENV to production in the .env file.

2. Build and run the production container:
    ```bash
    $ docker compose -f docker-compose.prod.yml up --build -d
    ```
