# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file into the container at /code
COPY requirements.txt requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install -r requirements.txt

# --- SpaCy Model Installation ---
# Download the specific spaCy models your app needs
RUN python -m spacy download en_core_web_sm
RUN python -m spacy download es_core_news_sm

# Copy the rest of your application's code into the container
COPY . .

# Expose the port your app runs on
EXPOSE 7860

# Command to run the application using gunicorn
# This is the production-ready way to run a Flask app
CMD ["gunicorn", "--bind", "0.0.0.0:7860", "app:app"]
