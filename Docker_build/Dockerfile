##
#  Generic dockerfile for dbt image building.
#  See README for operational details
##

# Top level build args
ARG build_for=linux/amd64
# print above var

##
# base image (abstract)
##
# Please do not upgrade beyond python3.10.7 currently as dbt-spark does not support
# 3.11py and images do not get made properly
FROM --platform=$build_for eu.gcr.io/halfpipe-io/build-python310-pipenv as base

# N.B. The refs updated automagically every release via bumpversion
# N.B. dbt-postgres is currently found in the core codebase so a value of dbt-core@<some_version> is correct

# Change these lines to use the full repository URL
ARG dbt_core_ref=dbt-core@v1.9.4
ARG dbt_postgres_ref=dbt-core@v1.9.0
ARG dbt_redshift_ref=dbt-redshift@v1.9.0
ARG dbt_bigquery_ref=dbt-bigquery@v1.9.1
ARG dbt_snowflake_ref=dbt-snowflake@v1.9.1
ARG dbt_spark_ref=dbt-spark@v1.9.1
ARG dbt_databricks_ref=dbt-databricks@v1.7.3
# special case args
ARG dbt_spark_version=all
ARG dbt_third_party

# System setup
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    git \
    ssh-client \
    software-properties-common \
    make \
    build-essential \
    ca-certificates \
    libpq-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Update python
RUN python -m pip install --upgrade pip setuptools wheel --no-cache-dir

# Set docker basics
WORKDIR /usr/app/dbt/
ENTRYPOINT ["dbt"]

##
# dbt-core
##
FROM base as dbt-core
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-core@v1.9.4#egg=dbt-core&subdirectory=core"

##
# dbt-postgres
##
FROM base as dbt-postgres
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-postgres@v1.9.0"
RUN python -m pip install --no-cache-dir dbt-adapters==1.14.8


##
# dbt-redshift
##
FROM base as dbt-redshift
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-redshift@v1.9.0#egg=dbt-redshift"


##
# dbt-bigquery
##
FROM base as dbt-bigquery
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-bigquery@v1.9.1#egg=dbt-bigquery"


##
# dbt-snowflake
##
FROM base as dbt-snowflake
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-snowflake@v1.9.1#egg=dbt-snowflake"

##
# dbt-spark
##
FROM base as dbt-spark
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    python3-dev \
    libsasl2-dev \
    gcc \
    unixodbc-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-spark@v1.9.1#egg=dbt-spark[all]"


##
# dbt-databricks
##
FROM base as dbt-databricks
RUN python -m pip install --no-cache-dir "git+https://github.com/databricks/dbt-databricks@v1.7.3#egg=dbt-databricks"

##
# dbt-third-party
##
# FROM dbt-core as dbt-third-party
# RUN python -m pip install --no-cache-dir "$dbt_third_party"

##
# dbt-all
##
FROM base as dbt-all
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    python3-dev \
    libsasl2-dev \
    gcc \
    unixodbc-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
  RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-redshift@v1.9.0#egg=dbt-redshift"
  RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-bigquery@v1.9.1#egg=dbt-bigquery"
  RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-snowflake@v1.9.1#egg=dbt-snowflake"
  RUN python -m pip install --no-cache-dir "git+https://github.com/databricks/dbt-databricks@v1.7.3#egg=dbt-databricks"
  RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-spark@v1.9.1#egg=dbt-spark[all]"
  RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/dbt-postgres"
