FROM python:3.11-slim

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

# Criação do usuário e grupo de sistema
RUN addgroup --system appgroup && \
    adduser --system --ingroup appgroup appuser

# 3. Ajuste de permissão para o appuser conseguir acessar a pasta /app
RUN chown -R appuser:appgroup /app

# 4. Alteração para o usuário não-root
USER appuser

EXPOSE 8080

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
