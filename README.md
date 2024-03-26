# Accre Tutorial
A short tutorial on using [ACCRE](https://www.vanderbilt.edu/accre/) aimed at Biostatistician needs. 

## Parallel Versus Batch

Parallel computing is required to numerically evaluate large [systolic arrays](https://en.wikipedia.org/wiki/Systolic_array).
These kinds of problems are common in solving large partial differential
equations, ultra high dimensional spectral analysis, and nuclear simulations.
ACCRE provides resources for solving such problems, and it involves having a
high number of CPUs and nodes with high speed communication buses allocated
all at once. A problem of this type quickly burns through fair share and can
leave ones shared group account depleted with just a couple requests.

Biostatistics problems typically consist of simulations involving multiple
runs that are independent and do not communicate or share information with
other runs. These types of problems are known as batch array jobs. The
relevant [slurm](https://slurm.schedmd.com/overview.html) parameter is `array`. 
This runs multiple jobs independently and fits them in as needed, likely 
using less resources than a parallel job request. A batch array should
look something like this:

```
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-250
```

It requests a single cpu 250 times independently, and doesn't ask for
any special parallel or systolic needs. Jobs will get queued faster
and turn around will generally be quicker. 

## Goals

What is required is some _simple_ scripts that allow one to quickly identify
a failed job and to reproduce that behavior locally. For example, batch
array number 123 might fail, and in a local development environment one
would wish to reproduce that exact failure to determine what set of 
conditions led to that failure. These scripts should also require
no modification running locally or on ACCRE.

This github repository is configured as a template. This means that when one forks it comes over as a single commit. Feel free to fork this project
to start simulation work on ACCRE. 

## Walkthrough Example

### Required Training

Make sure one has taken the [required training courses](https://www.vanderbilt.edu/accre/getting-started/training/)
for using ACCRE. If one has not done this and opens a support
request or consume too many resources, access may be denied. This
will also help get your account setup.

### Determine Job Resources

This is a tricky bit. Two pieces of unknown information are required. Time to 
execute and memory used. 

### Login

```
vunetid:~$ ssh vunetid@login.accre.vanderbilt.edu
vunetid@login.accre.vanderbilt.edu's password: *****
Last login: Thu Sep  1 13:50:59 2022 from 10.151.20.117
Vanderbilt University - Advanced Computing Center for Research and Education

    _    ____ ____ ____  _____    ____ _           _
   / \  / ___/ ___|  _ \| ____|  / ___| |_   _ ___| |_ ___ _ __
  / _ \| |  | |   | |_) |  _|   | |   | | | | / __| __/ _ \ |__|
 / ___ \ |__| |___|  _ <| |___  | |___| | |_| \__ \ ||  __/ |
/_/   \_\____\____|_| \_\_____|  \____|_|\__,_|___/\__\___|_|

===============================================================

Go forth and compute!

This is a shared gateway node designed for interactive use and small test jobs.
Please restrict your total system memory usage to less than 31 GB,
and do not run individual processes exceeding 20 minutes of CPU-time.

To list useful cluster commands type:      accre_help
To view your current storage type:         accre_storage
To list basic Linux commands type:         commands101
```
Once logged in it's good (but not required) to set up a ssh key with
github to allowed easy editing from ACCRE. See [github docs](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent). 

```
[vunetid@gw346 ~]$ ssh-keygen -t ed25519 -C "your_email@example.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/vunetid/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/vunetid/.ssh/id_ed25519.
Your public key has been saved in /home/vunetid/.ssh/id_ed25519.pub.
The key fingerprint is:
SHA256:QfgECwi18rmohyLD/8lJ/FwM2pc0OWTKaOvP7Ajof/g your_email@example.com
The key's randomart image is:
+--[ED25519 256]--+
|.o... .o.        |
|. o   .o.o       |
|  .. ..o.        |
| o .  o =..      |
| ...o + + +      |
|  o  o +S=       |
|oo...= . =       |
|B...=.O .        |
|++oo+EoB         |
+----[SHA256]-----+
[vunetid@gw346 ~]$ cat ~/id_rsa.pub
cat: /home/vunetid/id_rsa.pub: No such file or directory
[vunetid@gw346 ~]$ cat ~/.ssh/
id_ed25519      id_ed25519.pub  known_hosts     
[vunetid@gw346 ~]$ cat ~/.ssh/id_ed25519.pub
ssh-ed25519 AAAAC3ASDFASDFASDFASDFASDFASDFASDFsXRQwPG2kQLdeV your_email@example.com
```

Copy the resulting _*public*_ key to your github account. The associated 
`id_ed25519` is the private key that is equivalent to a password and
should be treated with great care.


```
[vunetid@gw346 ~]$ git clone git@github.com:vubiostat/accre_tutorial.git
Cloning into 'accre_tutorial'...
Warning: Permanently added the ECDSA host key for IP address '140.82.112.3' to the list of known hosts.
remote: Enumerating objects: 29, done.
remote: Counting objects: 100% (29/29), done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 29 (delta 12), reused 23 (delta 9), pack-reused 0
Receiving objects: 100% (29/29), 7.39 KiB | 0 bytes/s, done.
Resolving deltas: 100% (12/12), done.
[vunetid@gw346 ~]$ cd accre_tutorial
```

This has cloned the project and pulled the source in from github to
the local ACCRE gateway. If one
uses github, coordinating source code between a local device and accre is
relatively easy. One could edit code on ACCRE, commit to get and push centrally.
Then pull locally. As well as edit locally and pull modified code onto ACCRE.
The purpose of git is to keep all copies and edits of source code and
synchronize them between devices. Note, the clone would need to use 
the ssh link for the project and keys from ACCRE loaded to github.

```
[vunetid@gw346 accre_tutorial]$ git pull
Already up-to-date.
```

Now one can submit this example job for execution using [slurm commands](https://hpc.nmsu.edu/discovery/slurm/commands/) and
check on it's status. It's design to use few resources so feel
free to give it a try.

```
[vunetid@gw346 accre_tutorial]$ sbatch simulation.slurm 
Submitted batch job 61567954
[vunetid@gw346 accre_tutorial]$ squeue -u vunetid
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
       61567954_10 productio simulati vunetid CG       0:05      1 cn1345
        61567954_1 productio simulati vunetid  R       0:05      1 cn1275
        61567954_2 productio simulati vunetid  R       0:05      1 cn1284
        61567954_3 productio simulati vunetid  R       0:05      1 cn1348
        61567954_4 productio simulati vunetid  R       0:05      1 cn1352
        61567954_5 productio simulati vunetid  R       0:05      1 cn1369
        61567954_8 productio simulati vunetid  R       0:05      1 cn1333
        61567954_9 productio simulati vunetid  R       0:05      1 cn1333
       61567954_11 productio simulati vunetid  R       0:05      1 cn1345
       61567954_12 productio simulati vunetid  R       0:05      1 cn1367
       61567954_13 productio simulati vunetid  R       0:05      1 cn1367
       61567954_14 productio simulati vunetid  R       0:05      1 cn1399
       61567954_15 productio simulati vunetid  R       0:05      1 cn1399
       61567954_16 productio simulati vunetid  R       0:05      1 cn1307
       61567954_17 productio simulati vunetid  R       0:05      1 cn1308
       61567954_18 productio simulati vunetid  R       0:05      1 cn1308
```

After waiting a few minutes, most of the jobs will be done. 

```
[vunetid@gw346 accre_tutorial]$ squeue -u vunetid
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
```

Now we can check to see how successful this was. 
