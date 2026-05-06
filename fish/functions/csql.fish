function csql --description "Lists all Cloud SQL instances with their IP and PSC addresses"
    # echo "Fetching Cloud SQL instances list..."
    set json_data (gcloud sql instances list --format="json" 2>/dev/null)

    if test -z "$json_data"
        echo "No instances found or failed to fetch."
        return 1
    end

    set names (echo $json_data | jq -r '.[].name')

    printf "%-40s | %-15s | %-15s | %-15s | %-50s\n" "INSTANCE NAME" "PRIMARY IP" "PRIVATE IP" "PSC IP" "DNS NAME"
    printf "%s\n" (string repeat -n 145 -)

    for name in $names
        set primary_ip (echo $json_data | jq -r ".[] | select(.name == \"$name\") | .ipAddresses[]? | select(.type == \"PRIMARY\") | .ipAddress" | head -n 1)
        set private_ip (echo $json_data | jq -r ".[] | select(.name == \"$name\") | .ipAddresses[]? | select(.type == \"PRIVATE\") | .ipAddress" | head -n 1)
        set dns_name (echo $json_data | jq -r ".[] | select(.name == \"$name\") | .dnsName // empty")

        set psc_ip ""
        set psc_enabled (echo $json_data | jq -r ".[] | select(.name == \"$name\") | .settings.ipConfiguration.pscConfig.pscEnabled // \"false\"")

        if test "$psc_enabled" = "true"
            set psc_ip (gcloud sql instances describe $name --format="json" 2>/dev/null | jq -r '.settings.ipConfiguration.pscConfig.pscAutoConnections[].ipAddress // empty' | head -n 1)
        end

        if test -z "$primary_ip"; set primary_ip "-"; end
        if test -z "$private_ip"; set private_ip "-"; end
        if test -z "$psc_ip"; set psc_ip "-"; end
        if test -z "$dns_name"; set dns_name "-"; end

        printf "%-40s | %-15s | %-15s | %-15s | %-50s\n" $name $primary_ip $private_ip $psc_ip $dns_name
    end
end
