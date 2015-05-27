## Swarm Ogar
This is the deployment guide for the [agar.io](http://agar.io/) server clone, [Ogar](https://github.com/vram4/Ogar). You may run Ogar locally on your OSX or Linux system, or deploy it to [Giant Swarm's service](https://giantswarm.io/) if you have an Alpha account. If you would like to get your Alpha account faster, be sure to [follow and ping](https://twitter.com/giantswarm/) us on Twitter.

### Prerequisites
A few requirements apply to this project. At a minimum you need the following:

* A functional install of [boot2docker](https://github.com/kordless/boot2docker-ing).
* A Giant Swarm [account](https://giantswarm.io).
* The **swarm** command line client [installed](http://docs.giantswarm.io/reference/installation/). 

*Note: Having a Giant Swarm account and the CLI installed is optional if you are OK running Ogar locally.*

### Video Walkthrough

Here's another fine video guide I did while trying hard to not play agar.io too much.

[![]()](https://vimeo.com/)

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

