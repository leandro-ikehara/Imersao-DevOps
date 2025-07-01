# Etapa 1: Usar uma imagem base oficial do Python
# A imagem 'alpine' é escolhida por ser leve, o que resulta em um contêiner menor.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir variáveis de ambiente
# Evita que o Python gere arquivos .pyc e garante que os logs sejam enviados diretamente para o terminal.
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# Etapa 3: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 4: Instalar as dependências
# Copiar o arquivo de dependências primeiro aproveita o cache de camadas do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o código da aplicação para o diretório de trabalho
COPY . .

# Etapa 6: Expor a porta em que o Uvicorn será executado
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
