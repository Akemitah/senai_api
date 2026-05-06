FROM python: 3.11-slim

WORKDIR /app
RUN pip install --update pip
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY app/ ./app/

# criar um usuario
RUN addgroup --system appgroup  
RUN adduser --system --ingroup appgroup appuser

# inicializar o container  
USER appuser
EXPOSE 8080
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]  
