# Create work directories:
mkdir -p /opt/traccar/logs

# this assumes the environment variables for processing this file do exist
( echo "cat <<EOF" ; cat traccar-template.xml ; echo EOF ) | sh | cat >> /opt/traccar/traccar.xml

# start container:

docker run \
--name traccar \
--network coolify \
--hostname traccar \
--detach --restart unless-stopped \
--publish 80:8082 \
--publish 5000-5150:5000-5150 \
--publish 5000-5150:5000-5150/udp \
--volume /opt/traccar/logs:/opt/traccar/logs:rw \
--volume /opt/traccar/traccar.xml:/opt/traccar/conf/traccar.xml:ro \
traccar/traccar:latest
