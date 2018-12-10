setup: install_bundler
	bundle install --path vendor/bundle
	bundle exec pod install

install_bundler:
	bundler --version > /dev/null 2>&1 || gem install bundler
