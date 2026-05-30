function gsl --description "List Google Secret Manager secret versions" --argument-names secret_name
    if not set -q secret_name[1]
        echo "Usage: gsl <secret-name>"
        return 1
    end

    gcloud secrets versions list $secret_name
end
