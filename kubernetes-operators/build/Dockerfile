FROM python:3.7
COPY templates ./templates
COPY mysql-operator.py ./mysql-operator.py
COPY requrements.txt ./requrements.txt
RUN pip install -r requrements.txt
CMD kopf run /mysql-operator.py

