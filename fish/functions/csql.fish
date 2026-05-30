function csql --description "Lists all Cloud SQL instances with their IP and PSC addresses"
    set -l json_data (gcloud sql instances list --format="json" 2>/dev/null)
    or return 1

    set -l names (echo $json_data | jq -r '.[].name')

    if test (count $names) -eq 0
        echo "No instances found."
        return 1
    end

    set -l fmt "%-40s | %-15s | %-15s | %-15s | %-50s\n"
    printf $fmt INSTANCE\ NAME PRIMARY\ IP PRIVATE\ IP PSC\ IP DNS\ NAME
    printf '%s\n' (string repeat -n 145 -)

    for name in $names
        set -l instance (echo $json_data | jq -c ".[] | select(.name == \"$name\")")

        set -l primary_ip (echo $instance | jq -r '[.ipAddresses[]? | select(.type == "PRIMARY") | .ipAddress][0] // "-"')
        set -l private_ip (echo $instance | jq -r '[.ipAddresses[]? | select(.type == "PRIVATE") | .ipAddress][0] // "-"')
        set -l dns_name   (echo $instance | jq -r '.dnsName // "-"')
        set -l psc_ip     -

        set -l psc_enabled (echo $instance | jq -r '.settings.ipConfiguration.pscConfig.pscEnabled // false')
        if test "$psc_enabled" = true
            set psc_ip (gcloud sql instances describe $name --format="json" 2>/dev/null \
                | jq -r '[.settings.ipConfiguration.pscConfig.pscAutoConnections[].ipAddress // empty][0] // "-"')
        end

        printf $fmt $name $primary_ip $private_ip $psc_ip $dns_name
    end
end
