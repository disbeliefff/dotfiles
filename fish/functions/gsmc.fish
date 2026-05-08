function gsmc --description "Create multiple Google Secret Manager secrets from arguments"
    if test (count $argv) -eq 0
        echo "Usage: gsmc <secret_name1> [secret_name2 ...]"
        echo "Example: gsmc dev_ParkingManagementWeb-config prod_ParkingManagementWeb-config"
        return 1
    end

    read -l -P "Add labels to secrets? (y/n): " add_labels
    set -l label_key ""
    set -l label_value ""

    if test "$add_labels" = "y"
        read -l -P "Label key: " label_key
        read -l -P "Label value: " label_value
    end

    for secret in $argv
        echo "Creating secret: $secret"

        if test "$add_labels" = "y"
            gcloud secrets create "$secret" --labels (string join '=' $label_key $label_value)
        else
            gcloud secrets create "$secret"
        end

        if test $status -eq 0
            echo "Created: $secret"
        else
            echo "Failed: $secret"
        end
        echo "----------------------------------------"
    end
end
