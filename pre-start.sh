# Create work directories:
mkdir -p /opt/traccar/logs

# Extract source config file
docker run \
--rm \
--entrypoint cat \
traccar/traccar:latest \
/opt/traccar/conf/traccar.xml > /opt/traccar/traccar-source.xml

# this assumes the environment variables for processing this file do exist
# ( echo "cat <<EOF" ; cat traccar-template.xml ; echo EOF ) | sh | cat >> /opt/traccar/traccar.xml

# substritube values in template
cat traccar-source.xml | 
sed -e "s_\(<entry key='database.driver'>\).*\(</entry>\)_\1$DATABASE_DRIVER\2_g" |
sed -e "s_\(<entry key='database.url'>\).*\(</entry>\)_\1jdbc:$DATABASE_TYPE://$DATABASE_HOST/$DATABASE_NAME\2_g" |
sed -e "s_\(<entry key='database.user'>\).*\(</entry>\)_\1$DATABASE_USER\2_g" |
sed -e "s_\(<entry key='database.password'>\).*\(</entry>\)_\1$DATBASE_PASSWORD\2_g" |
tee traccar.xml
