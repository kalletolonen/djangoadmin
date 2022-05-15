{% set name = "kallet" %} #The name of the user you're going to be operating the dev server as.
{% set project = "baseproject" %} #The name off your project
{% set app = "myapp" %} #The name off your app in your project

virtualenv:
  pkg.installed

/home/{{ name }}/env:
  virtualenv.managed:
    - system_site_packages: True
    - requirements: salt://djangoadmin/requirements.txt

source /home/{{ name }}/env/bin/activate && django-admin startproject {{ project }}:
  cmd.run:
    - unless: test -d /home/{{ name }}/baseproject
    - cwd: /home/{{ name }}/

source /home/{{ name }}/env/bin/activate && ./manage.py migrate && ./manage.py makemigrations:
  cmd.run:
    - unless: source /home/{{ name }}/env/bin/activate && ./manage.py migrate | grep "No migrations to apply"
    - cwd: /home/{{ name }}/{{ project }}/

/home/{{ name }}/{{ project }}/{{ project }}/settings.py:
  file.blockreplace:
    - marker_start: "    'django.contrib.staticfiles',"
    - marker_end: "]"
    - content: "    '{{ app }}'"
    - marker_start: "DEBUG = True"
    - marker_end: "# Application definition"
    - content: "ALLOWED_HOSTS = ['localhost']"
    - append_if_not_found: True

/home/{{ name }}/{{ project }}:
  file.directory:
    - user: {{ name }}
    - group: {{ name }}
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - user
      - group
      - mode
