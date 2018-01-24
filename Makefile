checkout-julius:
	# NOTE: in the future we may be able to add --shallow-submodules ?
	git clone --recurse-submodules --depth 1 --branch main https://github.com/nCoda/julius.git julius-git

prepare-julius-build:
	cd julius-git && npm install
	cd julius-git && npm install electron-packager
	cd julius-git && npm run build
	cd julius-git/build && tar -zcf julius-packaged.tar.gz nCoda-linux-x64
	mv julius-git/build/julius-packaged.tar.gz ncoda/sources

build-ncoda:
	cd ncoda && make build
	mkdir -p repo
	flatpak build-export repo ncoda/build

.PHONY: build-ncoda checkout-julius prepare-julius-build
