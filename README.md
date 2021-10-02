# oinkdeploy.sh
You've generated an amazing static website, using Hugo or Next.js, etc. and you want it to go live on the web, like right now.

With oinkdeploy.sh, you can instantly deploy a site to Porkbun Static Hosting (or any web host that allows FTP upload) with our quick-and-dirty ftp deploy tool.

## Prerequisites:
lftp must be installed for this script to work. Fortunately, it's pre-installed on MacOS and most modern Linuxes.

## Install
Copy oinkdeploy.sh to its permanent home. Remember that oinkdeploy.sh will contain username/password info, so you want to put it somewhere where it will never accidentally be bundled into your static site and uploaded. 

Once placed, open in your favorite text editor to configure oinkdeploy.sh. Here's a sample config section:

    ftpusername='mydomain.biz'
    ftppassword='72HabU22^l92n6kZ'
    ftpserver='pixie-ftp.porkbun.com'
    localfolder='public/'
    remotefolder='/'

If you're using Porkbun Static Hosting, ftpusername will simply be the domain name the site's hosted on; ftppassword can be copy/pasted from the static hosting config page under **FTP Credentials**. We left in Porkbun's static hosting server as the default.

Localfolder is set to `public/` (that's what Hugo uses for its static assets), but it can be any folder. The remotefolder is set to `/` but other web hosts, you may have to do `www` or `public_html` to get it to work.
## Run oinkdeploy.sh

    $ chmod +x oinkdeploy.sh
    $ ./oinkdeploy.sh

## Write a final deploy script
Once the script is working, you can integrate it into your deploy pipeline. For instance, for doing a Hugo publish, you can write a script called deploy.js (or whatever) to clear out the old version of the site, generate a new one, and publish it:

    #!/bin/bash
    echo Deleting the old public folder
    rm -rf public
    echo Building Hugo
    hugo
    /bin/bash ./oinkdeploy.sh

## Alternatives
We're not saying oinkdeploy.sh is the best way to deploy a website to Porkbun Static Hosting, just maybe the easiest. If you're anything like us, you like quick-and-dirty solutions. However, oinkdeploy.sh is inefficient, and there's no version control. Here's some other ways to deploy to Porkbun Static Hosting that might work better for your use case:

* Porkbun Static Hosting supports **Github Connect**, meaning you can make a private Github repo and then push changes, which are in turn pushed live to your website. This method is more efficient, but it does require creating and maintaining a Github repo for the site, linking it to Porkbun Static Hosting (that part is easy) and then remembering how to use git.
* [FTP Deploy by Sam Kirkland](https://github.com/SamKirkland/ftp-deploy) does what oinkdeploy.sh does, but way more efficiently. It just updates the FTP server with changes, rather than deleting and republishing the whole site. But you do need npm installed, plus a basic knowledge of Javascript to make it all work.
