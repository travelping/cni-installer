#/bin/sh

if [ -n "$PLUGINS" ] ; then
	for p in $PLUGINS; do
		echo "Installing $p"
		cp $PLUGIN_DIR/$p $INSTALL_DIR
	done
else
	cp $PLUGIN_DIR/* $INSTALL_DIR
fi

for f in $(ls $CONF_TEMPLATE_DIR) ; do
	envsubst < $CONF_TEMPLATE_DIR/$f > $CONF_DIR/$f
	echo -e "\n\n###### $CONF_DIR/$f ######"
	cat  $CONF_DIR/$f
	echo -e "###############"
done

while [ "$1" == "sleep" ] ; do
	sleep 1h
done
