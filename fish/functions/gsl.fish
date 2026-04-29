function gsl --description "List Google Secret Manager secret versions" --argument-names secret_name
    if test -z "$secret_name"
        echo "Usage: gsl <secret-name>"
        return 1
    end

    gcloud secrets versions list "$secret_name"
end
