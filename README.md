OpenStax Exchange
=================

OpenStax Exchange stores and provides learner interaction "big data".

## Development Setup

In development, Exchange can be run as a normal Rails app on your machine, or you can run it in a Vagrant virtual machine that mimics our production setup.

### Running as a normal Rails app on your machine

To start running Exchange in a development environment, clone the repository, then

```
bundle install --without production
```

Just like with any Rails app, you then need to migrate the database.  In our case, after the first migration we also need to load the database seeds (placeholder terms of use, etc, that the code relies on):

```
rake db:migrate
rake db:seed
```

or in one step

```
rake db:setup
```

When you run

```
rails server
```

Exchange will start up on port 3003, i.e. http://localhost:3003.

### Running in a Vagrant virtual machine

OpenStax Exchange uses chef to configure its production environment, and this
environment can also be replicated using Vagrant.

1. Install Vagrant
    * Get an installer from http://downloads.vagrantup.com/, don't use the old ````gem install vagrant```` approach.  If you had previously installed the gem version uninstall it first.
1. ````$ vagrant plugin install vagrant-berkshelf````
3. ````$ vagrant up````

As you'll see in our ````Berksfile```` file, our Vagrant instance uses cookbooks from a number of places.  Cookbooks that are specific to OpenStax and OpenStax Exchange live [on github](https://github.com/openstax/openstax_cookbooks).  If you find yourself needing to modify these cookbooks, clone the cookbook repository and then set the ````OPENSTAX_COOKBOOKS_PATH```` environment variable to the absolute path of the checked out cookbooks before running vagrant commands.  This will cause Vagrant and Berkshelf to use your local copy of the OpenStax cookbooks instead of the ones on Github. 

Vagrant here has been extended with plugins to include commands that mirror server [life cycle events](http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-events.html) triggered through Amazon's OpsWorks service.  The following commands are available:

* ````vagrant up```` and ````vagrant provision```` run the OpsWorks ````setup```` and ````configure```` behavior.
* ````vagrant deploy```` runs OpsWorks' ````deploy```` behavior.  *Note* the first time you do this you'll need to run ```rake db:seed``` to load the database seeds.
* ````vagrant undeploy```` runs OpsWorks' ````undeploy```` behavior.
* ````vagrant shutdown```` runs OpsWorks' ````shutdown```` behavior.

To get going, run ````vagrant up```` followed by ````vagrant deploy````.  This will put your Vagrant VM in a running state with OpenStax Exchange being served at https://localhost:8081.  Note that http://localhost:8080 serves the non-SSL interface, but if you go there you'll see an error due to the fact that we're explicitly setting the URL port.  Exchange forces SSL connections, and in so doing it tries to redirect http requests to https://localhost:8080, not 8081.