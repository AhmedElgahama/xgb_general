FROM rocker/verse:latest


# Install dependencies
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
    liblapack-dev \
    libpq-dev \
    build-essential libssl-dev libxml2-dev libcurl4-gnutls-dev  



COPY ./requirements.txt .

RUN R -e \
    "install.packages( \
        c('plumber'), \
        repos = 'http://cran.us.r-project.org' \
    )"

RUN R -e \
    "install.packages( \
        readLines('requirements.txt'), \
        repos = 'http://cran.us.r-project.org' \
    )"

COPY app ./opt/app
COPY ml_vol ./opt/ml_vol
WORKDIR /opt/app


ENV PATH="/opt/app:${PATH}"

RUN chmod +x train &&\
    chmod +x test &&\
    chmod +x serve 

