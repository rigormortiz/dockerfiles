### Info
This is an Alpine Linux image with with hugo. It can be used to build and optionally serve your static wensite.

Check out the [Awesome Hugo Documentation](https://gohugo.io/documentation/) for details on Hugo. 

### Example Usage
Here are some bery basic and crude examples to show how the container works.

```
# run the help command
docker run -it rigormortiz/hugo help

# create a new site
docker run -it -u 1000:1000 -v ${PWD}:/data rigormortiz/hugo new site some_site

# add page
docker run -it -u 1000:1000 -v ${PWD}:/data rigormortiz/hugo new post/something.md

# serve site
docker run -it -u 1000:1000 -p 1313:1313 -v ${PWD}:/data rigormortiz/hugo server -D --bind 0.0.0.0
```