#No-Mo-Head

Here's a bit of background: I frequently use my Pi in headless mode, but I live in a college where the Wifi doesn't let you use static IPs. I've implemented a number of workarounds for this problem, but this is the one that stuck. If you can connect to the internet but have a problem connecting to the Pi, this could help.

## Installation

First clone the repository (if you have git on your Raspi. If not, just download):
```
git clone https://github.com/hrishioa/nomohead.git
```

**Don't** install yet! Install ngrok first in a directory of your choice:
```
wget https://dl.ngrok.com/ngrok_2.0.19_linux_arm.zip
unzip ngrok.zip
```
(This was the linux release of ngrok when I wrote this. Do check for updates on [the website](https://ngrok.com/download))

We are going to tunnel into the SSH port of the Raspi using ngrok. For this functionality, you need to [register with ngrok](https://ngrok.com/login) (if you haven't already), and authenticate yourself with the authtoken.
```
./ngrok authtoken <TOKEN HERE>
```

Next, run the install script:
```
./setup.sh
```

Setup asks for the following parameters:

1. Location of ngrok - enter the directory where you installed ngrok along with ngrok executable (not just the directory)
2. Dweet ID - This is the ID you will be using to broadcast the IP. Enter something you think is unique (i.e. not raspi)
3. Dweet ID for tunnel - The first parameter is for the IP. You can use separate IDs for tunnel and IP if you want, if not just press ENTER.
4. Delay - The ngrok service takes an unpredictable amount of time to initialize (depends on processor and network load), but 1m seems to work fine for me. Increase this value if the ip address shows up but the ngrok tunnel never does. (It is worth pointing out that this is a little redundant. You can simply login to your ngrok account to see open tunnels and connect to them)

Once all values are entered, a cron job is created that runs at boot.

At this point, you can reboot your Pi.

## Dweets

In order to find your raspberry pi, you can go to 
```
http://dweet.io/follow/<RASPID>
```
or, in order to see all updates in 24 hours, go to 
```
http://dweet.io/get/dweets/for/<RASPID>
```
and replace _RASPID_ with the IP or Tunnel ID you gave during Setup. 
I prefer the former because it looks better, but it is certainly possible to run automated scripts that poll the JSON from the latter and do things once the Raspi comes online.

#### Happy Hacking!
