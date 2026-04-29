function gs --description "Access Google Secret Manager secret" --argument-names secret_name secret_version
    if test -z "$secret_name"
        echo "Usage: gs <secret-name> [version]"
        return 1
    end

    set -l ver "$secret_version"
    if test -z "$ver"
        set ver "latest"
    end

    gcloud secrets versions access "$ver" --secret="$secret_name" | jq .
end
