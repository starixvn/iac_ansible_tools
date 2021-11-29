DATABASES = {
    'default': {
        'ATOMIC_REQUESTS': True,
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': "ansibledb",
        'USER': "awx",
        'PASSWORD': "1234aa",
        'HOST': "10.18.200.131",
        'PORT': "5439",
    }
}

BROADCAST_WEBSOCKET_SECRET = "NGJ5VHhZLWdhYlB5R29ZazIyQTY="
