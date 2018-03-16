
if [ ! -f ./training-runs.yml ]; then
    cp ./training-runs.yml.template ./training-runs.yml

    sed -i .bak "s/    access_key_id:.*/    access_key_id: $AWS_ACCESS_KEY_ID/g" training-runs.yml
    sed -i .bak "s/    secret_access_key:.*/    secret_access_key: $AWS_SECRET_ACCESS_KEY/g" training-runs.yml

    curl -O http://max-assets.s3-api.us-geo.objectstorage.softlayer.net/mnist_sequence1_sample_5distortions5x5.npz

    aws --endpoint-url=http://s3-api.us-geo.objectstorage.softlayer.net s3 mb s3://spatial-transformer-training
    aws --endpoint-url=http://s3-api.us-geo.objectstorage.softlayer.net s3 cp mnist_sequence1_sample_5distortions5x5.npz s3://spatial-transformer-training/data/
    aws --endpoint-url=http://s3-api.us-geo.objectstorage.softlayer.net s3 mb s3://spatial-transformer-training-results
fi

bx ml train spatial_transformer.zip training-runs.yml

