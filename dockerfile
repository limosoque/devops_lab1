FROM ubuntu:latest as build
FROM python:latest

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

COPY requirements.txt .

RUN python -m pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt && pip uninstall -y -r requirements.txt && rm -rf /root/.cache/pip

# Копируем исходный код вашего приложения внутрь контейнера
COPY app.py .
COPY binary_search.py .

RUN pyinstaller --name=binary_search_app --onefile app.py -p binary_search.py


FROM ubuntu:latest
COPY --from=build ./binary_search_app ./binary_search_app

# Определяем команду, которая будет выполняться при запуске контейнера
CMD [ "./binary_search_app" ]
