FROM python:3.7.7
COPY ./requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
COPY run.py /app/run.py
WORKDIR /app
CMD ["python", "run.py"]
