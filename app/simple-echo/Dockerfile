FROM python:3
COPY requirements.txt .
RUN pip install --requirement ./requirements.txt
COPY . .
EXPOSE 8080
CMD [ "python", "./main.py" ]

