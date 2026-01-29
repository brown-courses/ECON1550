.PHONY: site clean

site:
	quarto render --no-execute

clean:
	rm -rf public build
