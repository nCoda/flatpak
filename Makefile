build-ncoda:
	sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	sudo flatpak install -y flathub io.atom.electron.BaseApp
	# NOTE: in the future we may be able to add --shallow-submodules ?
	git clone --recurse-submodules --depth 1 --branch main https://github.com/nCoda/julius.git julius-git
	cd julius-git && npm install
	cd julius-git && npm install electron-packager
	cd julius-git && npm run build
	cd julius-git/build && tar -zcf julius-packaged.tar.gz nCoda-linux-x64
	mv julius-git/build/julius-packaged.tar.gz ncoda/sources
	mkdir -p repo
	flatpak build-export repo ncoda/build

.PHONY: build-ncoda
