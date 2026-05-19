SCRIPT_SRC = update-debian
SCRIPT_NAME = update-debian
INSTALL_DIR = /usr/bin
PROJECT_NAME = $(SCRIPT_NAME)
VERSION := $(shell date +%Y%m%d)
RELEASE_ARCHIVE = $(PROJECT_NAME)-$(VERSION).tar.gz

.PHONY: install uninstall

make:
	@echo "Available commands:\ninstall\nuninstall\nrelease\nclean"

install:
	@# Check if user is root
	@if [ "$(shell id -u)" != "0" ]; then \
		echo "Error: This must be run as root. Try 'sudo make install'." >&2; \
		exit 1; \
	fi
	
	@echo "Installing $(SCRIPT_SRC) to $(INSTALL_DIR)/$(SCRIPT_NAME)..."
	@# Install the script and set permissions to executable (755)
	@install -m 755 $(SCRIPT_SRC) $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Install complete."

uninstall:
	@# Check if user is root
	@if [ "$(shell id -u)" != "0" ]; then \
		echo "Error: This must be run as root. Try 'sudo make uninstall'." >&2; \
		exit 1; \
	fi
	
	@echo "Removing $(INSTALL_DIR)/$(SCRIPT_NAME)..."
	@# Remove the installed script
	@rm -f $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Uninstall complete."

release:
	@echo "Creating release archive: $(RELEASE_ARCHIVE)"
	@# Bundle the script and the Makefile into a .tar.gz file
	@tar czvf $(RELEASE_ARCHIVE) $(SCRIPT_SRC) Makefile
	@echo "Release bundle created successfully."

clean:
	@echo "Cleaning up generated release files..."
	@rm -f $(RELEASE_ARCHIVE)
	@echo "Cleanup complete."