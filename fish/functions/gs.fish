function gs --description "Access Google Secret Manager secret" --argument-names secret_name secret_version
    if not set -q secret_name[1]
        echo "Usage: gs <secret-name> [version]"
        return 1
    end

    set -l ver latest
    if set -q secret_version[1]
        set ver $secret_version
    end

    gcloud secrets versions access $ver --secret="$secret_name" | jq .
end
