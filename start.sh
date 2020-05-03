docker build -t fab/email .
docker run --rm -d -p 8083:4567 --name email fab/email
