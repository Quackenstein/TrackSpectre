# Build docker image
```
docker build . -t trackspectre
```

# Run

```
docker run --gpus=all --net=host trackspectre
```

# Open browser

http://localhost:7860 

Hint: Use ssh portforwarding if you are working remotely:

```
ssh user@server -L 7860:localhost:7860
```
