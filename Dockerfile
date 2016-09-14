FROM ruby

EXPOSE 3000

ADD . /usr/src/tic_tac_toe_api
WORKDIR /usr/src/tic_tac_toe_api

RUN bundle install
CMD rails s -b 0.0.0.0
