function gs --description "Access Google Secret Manager secret" --argument-names secret_name secret_version
    if test -z "$secret_name"
        echo "Usage: gs <secret-name> [version]"
        return 1
    end

    set -l version "$secret_version"
    if test -z "$version"
        set version "latest"
    end

    gcloud secrets versions access "$version" --secret="$secret_name" | jq .
end
