'''
ASGI config for core project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/5.2/howto/deployment/asgi/
'''

import os

from blacknoise import BlackNoise
from django.conf import settings
from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')

BASE_DIR = settings.BASE_DIR

application = BlackNoise(get_asgi_application())

if settings.DEBUG:
    application.add(BASE_DIR / 'static', '/static')
else:
    application.add(BASE_DIR / 'staticfiles', '/static')
