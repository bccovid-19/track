FROM ruby:2.7.1
ENV LANG C.UTF-8
WORKDIR /build
COPY Gemfile Gemfile.lock ./
RUN bundle install
CMD ["bundle", "exec", "jekyll", "build"]
