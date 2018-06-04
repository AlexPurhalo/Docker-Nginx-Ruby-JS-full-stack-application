FROM ruby:2.5

ARG rack_env

ENV RACK_ENV $rack_env

RUN mkdir -p /server_app

WORKDIR /server_app

COPY . .

 RUN if [ ${RACK_ENV} = production ]; then bundle install --without test development; else bundle install; fi

ENTRYPOINT ["rake"]

CMD ["-T"]

EXPOSE 3000
