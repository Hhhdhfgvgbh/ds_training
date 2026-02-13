# Базовый образ: Python 3.9 на slim (лёгкий)
FROM python:3.9-slim

# Установка системных зависимостей (для Jupyter и графиков)
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка рабочей директории
WORKDIR /app

# Копируем requirements.txt и устанавливаем пакеты
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем ваши файлы (ноутбуки, данные) в контейнер
COPY . /app

# Открываем порт 8888 для Jupyter
EXPOSE 8888

# Запуск JupyterLab: доступен по http://localhost:8888, без токена для простоты (в production добавьте токен)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]