# Extracting the Forego binary with Docker

I don't necessarily want Go and git etc in my images, and remembering to put in the magic syntax to build and then extract the binary is also a pain. Use this to build an image that sits around waiting for you to extract the binary from, for the convenience.

## To build

docker build -t "YOURNAME/forego" .

I prefer this though:

docker build --squash -t 'YOURNAME/forego' .
docker images --no-trunc -aqf "dangling=true" | xargs docker rmi

It leaves less stuff lying around afterwards. Be warned that the second statement with remove all intermediate builds, not just this build's, but I don't like keeping them around anyway, YMMV.

## To use

Put this in the Dockerfile for the image you want to get forego into:

		# Get the forego binary
		COPY --from=YOURNAME/forego /forego/forego /usr/local/bin/
		RUN chmod +x /usr/local/bin/forego

Then you just need to start it (with a Procfile, of course), e.g.

		CMD ["forego", "start", "-p", "9292"]

## Note

The Dockerfile draws down from a non-canonical fork of forego because the main repo doesn't seem actively maintained right now. As soon as [this pull request with pending updates](https://github.com/ddollar/forego/pull/124) (or something similar) is merged in I'll update this to point to the canonical repo (give me a nudge if I miss this).

## Licence

See LICENCE.txt

## Contributions are welcome!

Feel free to let me know if this needs changes or you want to contribute back.
