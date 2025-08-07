release: python manage.py collectstatic --noinput
web: gunicorn django_project.wsgi:application --bind 0.0.0.0:$PORT