FROM python:3
COPY ./requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
COPY ./src /app
WORKDIR /app
CMD ["python", "-m", "track.wpm.app"]
