## Idempotent Django development server with Salt

![Pic 1. Django-admin ready for users](https://github.com/kalletolonen/ConfManSystems/raw/main/pics/h7/16.png)  
*Django-admin console ready for logging in*

Created by: [Kalle Tolonen](https://www.linkedin.com/in/kalletolonen/)

Maturity: 1.0 

### What does it do?
- The state creates a barebones Django 4.0.4. development environment with Virtualenv
- Only allows for localhost as a host
- User can input 3 parameters in init.sls to customize the user, project and app
- You'll have admin console ready

### What it doesn't do

Things I have chosen to NOT INCLUDE:
- A default model (since I have no clue what users would be developing)
- Registering the said model to admin.py for the same reason
- Automatically starting the dev-server with Salt, since that solution would have no Django dev tools at the user's disposal

### Requirements

1. A computer/VM running Debian (tested on Debian 11 Bullseye)
2. Sudo access
3. You should have a user ready for your project

### How to use it 

Enter these commands

	sudo apt-get update && sudo apt-get install -y salt-minion git

	sudo mkdir /srv/salt/ && cd /srv/salt
	
	sudo git clone https://github.com/kalletolonen/djangoadmin.git

	#edit the 3 variables to your spec
	sudoedit /srv/salt/djangoadmin/init.sls

	sudo salt-call --local state.apply djangoadmin
	
	source /yourusershomedir/env/bin/activate
	
	cd /yourusershomedir/yourproject/
	
	./manage.py runserver

After these you should have a Django development server running in localhost. You can test this with your browser by navigating to:

	localhost:8000

Admin console is available at:

	localhost:8000/admin

You can create superusers (while environment is activated & you're in the correct folder) with:

	./manage.py createsuperuser

### More info

https://github.com/kalletolonen/ConfManSystems/blob/main/h7.md  
-Here you can find out how the state was created in detail

https://terokarvinen.com/2022/django-instant-crm-tutorial/  
-A great resource to get a basic app  going


### Things to improve

- Make the syntax cleaner
- Figure out a way to start the dev server with salt *and* get feedback (ie. like starting a web daemon.)

