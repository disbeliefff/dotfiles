function gsmc --description "Create multiple Google Secret Manager secrets from arguments"
    if test (count $argv) -eq 0
        echo "Usage: gsmc <secret_name1> [secret_name2 ...]"
        echo "Example: gsmc dev_ParkingManagementWeb-config prod_ParkingManagementWeb-config"
        return 1
    end

    for secret in $argv
        echo "Creating secret: $secret"
        gcloud secrets create "$secret"

        if test $status -eq 0
            echo "Created: $secret"
        else
            echo "Failed: $secret"
        end
        echo "----------------------------------------"
    end
end
