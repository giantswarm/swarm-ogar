## Ogar Server Container Deployment for Giant Swarm
This is the deployment guide for the [agar.io](http://agar.io/) server clone, [Ogar](https://github.com/vram4/Ogar). You may run Ogar locally on your OSX or Linux system, or deploy it to [Giant Swarm's service](https://giantswarm.io/) if you have an Alpha account. If you would like to get your Alpha account faster, be sure to [follow and ping](https://twitter.com/giantswarm/) us on Twitter.

### Prerequisites
A few requirements apply to this project. At a minimum you need the following:

* A functional install of [boot2docker](https://github.com/kordless/boot2docker-ing).
* A Giant Swarm [account](https://giantswarm.io).
* The **swarm** command line client [installed](http://docs.giantswarm.io/reference/installation/). 
* A serious addiction to eating dots.

*Note: Having a Giant Swarm account and the CLI installed is optional if you are OK running Ogar locally.*

![business cat](https://github.com/giantswarm/swarm-ogar/blob/master/assets/meme.jpg)

**"Meow."** - Cat 

### Video Walkthrough

Here's another fine video walkthrough. I'm not sure where the hat went.

[![](https://raw.githubusercontent.com/giantswarm/swarm-ogar/master/assets/video.png)](https://vimeo.com/129065168)

### Code Checkout
Let's clone the repo:

    git clone https://github.com/giantswarm/swarm-ogar.git

Change into the directory:

	cd swarm-ogar
	
### Quick Launch Locally
To launch the application locally, change into the directory and run `make docker-run`:

```
$ cd swarm-ogar
$ make docker-run

...

Successfully built 52ab8ca5082a
Visit http://192.168.59.103:80 to play a game.
docker run --name=ogar --rm -ti \
		-e "HOSTNAME=192.168.59.103:80" \
		-e "CNAME=192.168.59.103:80" \
		-p 443:443 \
		registry.giantswarm.io/kord/ogar
[Master] Listening on port 80
[Game] Listening on port 443
[Game] Current game mode is Free For All
```

Once the server is running, you'll need to navigate to [agar.io](http://agar.io/) and then (in Chrome) hit `Command` + `Option` + `J` (Mac) or `Control` + `Shift` + `J` (Windows/Linux) and type the following in the console:

	connect("ws://192.168.59.103:443")

Please note the IP address outputted in the `make docker-run` section above needs to match what you type in the console.

### Run Locally, Share Globally
If you would like to share your local Ogar server with friends who are not on your local network, you'll need to install [Ngrok](https://ngrok.com/):

1. Download the `ngrok` client from the [downloads page](https://ngrok.com/download).
1. Double click the zip file and move the `ngrok` executable into a directory where you can run it. On OSX, I put it in `/usr/local/bin/ngrok`
1. Start the Ogar server locally by doing a `make docker-run` in the `swarm-ogar` directory.
1. In another terminal, type the following:

	ngrok http 192.168.59.103:443

When the `ngrok` overview page comes up, copy the URL with `ngrok.io` in it and give it to your friends. They'll need to open up the JavaScript console in their web browser and then type something like this to connect:

    connect("cdca36d8.ngrok.io")

### Deploy to Giant Swarm
Giant Swarm's service is a bit of a cross between [Heroku](https://heroku.com) and [Digital Ocean](https://digitalocean.com). The service is currently in closed Alpha test, but you can apply for an account and then ping the team for access.

To deploy the application to Giant Swarm, you'll need to first login with the CLI (command line interface):

```
$ swarm login
Username or email: kord
Password:
Login Succeeded
Environment kord/dev has been selected
```

Next, enter the following:

```
$ make swarm-up
```    

You'll get back something like this:

```
superman:swarm-ogar kord$ make swarm-up
docker build -t registry.giantswarm.io/kord/ogar .
Sending build context to Docker daemon 167.4 kB
Sending build context to Docker daemon

...

swarm up \
	  --var=username=kord \
	  --var=org=kord \
	  --var=env=dev \
	  --var=domain=ogar-kord.gigantic.io \
	  --var=app=ogar
Starting application ogar...
Application ogar is up.
You can see all services and components using this command:

    swarm status ogar

Use ws://ogar-kord.gigantic.io from agar.io to play game.
```

Once the server is running, you'll need to navigate to [agar.io](http://agar.io/) and then (in Chrome) hit `Command` + `Option` + `J` (Mac) or `Control` + `Shift` + `J` (Windows/Linux) and type the following in the console:

	connect("ws://ogar-<username>.gigantic.io")

Enjoy!

