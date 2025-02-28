FROM python:3.11-alpine

RUN adduser -D appuser

RUN apk add --no-cache \
    postgresql-dev \
    gcc \
    python3-dev \
    musl-dev \
    libffi-dev \
    jpeg-dev \
    zlib-dev && \
    mkdir -p /app

WORKDIR /app

COPY django_project/ .

RUN pip install --no-cache-dir -r requirements.txt && \
    apk del postgresql-dev gcc python3-dev musl-dev libffi-dev && \
    apk add --no-cache postgresql-libs && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /app/static && \
    chown -R appuser:appuser /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

USER appuser

CMD ["/app/entrypoint.sh"]