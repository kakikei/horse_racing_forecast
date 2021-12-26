FROM ruby:3.0.3

ENV LANG C.UTF-8

RUN set -x && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update -qq && \
    apt-get install -y nodejs \
      postgresql-client \
      yarn
RUN mkdir /horse_racing_forecast
WORKDIR /horse_racing_forecast
COPY Gemfile /horse_racing_forecast/Gemfile
COPY Gemfile.lock /horse_racing_forecast/Gemfile.lock
RUN bundle install
COPY . /horse_racing_forecast

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

RUN yarn install

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
