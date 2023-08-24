
FROM python:3.6

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y rsync

RUN chmod +x /app/entrypoint.sh

RUN apt-get update && apt-get install -y postgresql-client

ENV DJANGO_SETTINGS_MODULE=gutendex.settings

EXPOSE 8000

ENTRYPOINT ["/app/entrypoint.sh"]
