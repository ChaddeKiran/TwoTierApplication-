# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# install required packages for system
RUN apt-get update \
    && apt-get upgrade -y \
    #&& apt-get install -y mysql-client \
    #installing 3 packages which are development tools, and clients, and which are used to compile, and working with mysql database.  
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \  
    # default dir it contains all installed packages files removing only cached files of application does not means to removing packages also
    && rm -rf /var/lib/apt/lists/*  

# Copy the requirements file into the container
COPY requirements.txt .

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Specify the command to run your application
CMD ["python", "app.py"]

