FROM python:3.12-alpine
RUN addgroup -S app && adduser -S app -G app
WORKDIR /app
COPY app.py .
RUN pip install flask
USER app
CMD ["python", "app.py"]