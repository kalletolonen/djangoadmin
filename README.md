## Idempotent Django development server with Salt

### What does it do?
- The state creates a barebones Django development environment with Virtualenv
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
2. Salt-minion & git installed (for local use)
3. Sudo access

### How to use it 

Enter these commands

	sudo apt-get update

	sudo apt-get install -y salt-minion git
	
 	sudo mkdir /srv/salt/

 	cd /srv/salt
 	
	sudo git clone https://github.com/kalletolonen/djangoadmin.git

	#edit the 3 variables to your spec
	sudoedit /srv/salt/djangoadmin/init.sls

	sudo salt-call --local state.apply djangoadmin

	cd /yourusershomedir/

	source env/bin/activate

	cd /yourusershomedir/yourproject/

	./manage.py runserver

After these you should have a Django server running in localhost. You can test this with your browser by navigating to:

	localhost:8000

Admin console is available at:

	localhost:8000/admin

A good place to start would be here: https://terokarvinen.com/2022/django-instant-crm-tutorial/?fromSearch=django

On top of this state you need to:
- Create a superuser (see article above)
