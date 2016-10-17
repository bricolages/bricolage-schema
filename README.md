# bricolage-schema

Bricolage Streaming Loader database schema.
This schema is shared by Bricolage streaming loader, preprocessor, and web console.

## Setup

Create a database on PostgreSQL (Bricolage control DB).

```
> create database bricolage;
```

Edit database.yml.
Optionally, you can use database.yml.docker for Docker environment.

Test Ridgepole (dry run):

```
$ ./ridgepole_dryrun.sh
```

Run merge:

```
$ ./ridgepole_merge.sh
```

## License

MIT license

## Author

Minero Aoki
https://github.com/aamine/bricolage-schema
