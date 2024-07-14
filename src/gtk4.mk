# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gtk4
$(PKG)_WEBSITE  := https://gtk.org/
$(PKG)_DESCR    := GTK4
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.14.4
$(PKG)_CHECKSUM := 443518b97e8348f9f6430ac435b1010f9a6c5207f4dc6a7cd5d24e3820cee633
$(PKG)_SUBDIR   := gtk-$($(PKG)_VERSION)
$(PKG)_FILE     := gtk-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/gtk/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := meson-wrapper glib gdk-pixbuf pango libiconv gettext fontconfig cairo libepoxy gst-plugins-bad graphene lzo

define $(PKG)_BUILD
    # Meson configure, with additional options for GTK
    '$(MXE_MESON_WRAPPER)' $(MXE_MESON_OPTS) \
        -Dbuild-testsuite=false \
        -Dbuild-examples=false \
        -Dbuild-tests=false \
        -Ddemos=false \
        -Dintrospection=disabled \
        '$(BUILD_DIR)' '$(SOURCE_DIR)'
    '$(MXE_NINJA)' -C '$(BUILD_DIR)' -j '$(JOBS)'
    DESTDIR="/" \
        '$(MXE_NINJA)' -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
