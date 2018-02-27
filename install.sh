#/bin/sh

if [ -n "$PLUGINS" ] ; then
	for p in $PLUGINS; do
		cp $PLUGIN_DIR/$p $INSTALL_DIR
	done
else
	cp $PLUGIN_DIR/* $INSTALL_DIR
fi
