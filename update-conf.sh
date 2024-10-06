# this assumes the environment variables for processing this file do exist
( echo "cat <<EOF" ; cat traccar-template.xml ; echo EOF ) | sh | cat >> traccar.xml