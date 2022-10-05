## Small readme for ODISSEI dev data extraction

This readme covers a few topics:

- How to produce .nt files using a branch of the `semaf-client` on the dev server.
- How to upload (and how not to upload) using this branch
- Where the .nt files are stored


### Accessing the dev server

Dev server access is controlled by ssh key. Accessing this server requires you to upload a public ssh key to SURF; once you have done this, you can connect using `ssh dev.odissei.nl`. Alternatively; if you have not uploaded this key, a password is required (but this is a temporary solution).

Accessing the files is dependant on correct group membership. Alternatively; you can do this with the `chown` command.

### Data processing and uploading using the semaf-client on dev server

The data files already live on the dev server, on /data/datasets/.

A version with minor changes (inspectable via `git diff semaf-cli-import.py` ) lives on `/data/volume_2/semaf-client-fjodor/semaf-client`.

This can be invoked by doing the following:

1. Go to the folder which houses the data files you want.
2. `python3 /data/volume_2/semaf-client-fjodor/semaf-client/semaf-cli-import <filename>`
3. Your file is now done, and you can see output in the cli.

### How to avoid uploading

In order to avoid uploading; keep the command exactly as prescribed. If you add a single character (doesn't matter which one) after the filename - upload is done.

## Fuseki

Fuseki lives on https://fuseki.dev.odissei.nl. The credentials are default (admin/admin)

### Getting data

1. Open a shell on your local machine (terminal)
2. `wget https://fuseki.dev.odissei.nl/skosmos/get`
3. Wait for your download to finish.

### Uploading data

Same as getting data, but use `/skosmos/update`
