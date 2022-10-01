FROM ruby:2.5.3-stretch
RUN gem install selenium-webdriver -v 3.141.0
RUN gem install nokogiri -v 1.12.5
RUN gem install public_suffix -v 4.0.7
RUN gem install capybara -v 3.35.3
RUN gem install capybara-mechanize -v 1.11.0
RUN gem install activesupport -v 6.1.7
RUN gem install kimurai
RUN apt-get update && apt install -q -y git unzip wget tar openssl xvfb chromium \
                                        firefox-esr libsqlite3-dev sqlite3 default-mysql-client default-libmysqlclient-dev lsof

RUN cd /tmp && \
    wget https://chromedriver.storage.googleapis.com/2.39/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/local/bin && \
    rm -f chromedriver_linux64.zip

RUN cd /tmp && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.21.0/geckodriver-v0.21.0-linux64.tar.gz && \
    tar -xvzf geckodriver-v0.21.0-linux64.tar.gz -C /usr/local/bin && \
    rm -f geckodriver-v0.21.0-linux64.tar.gz

RUN apt install -q -y chrpath libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev && \
    cd /tmp && \
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar -xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    mv phantomjs-2.1.1-linux-x86_64 /usr/local/lib && \
    ln -s /usr/local/lib/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm -f phantomjs-2.1.1-linux-x86_64.tar.bz2

RUN mkdir -p /app

ADD Gemfile /app

RUN cd /app && bundle install
