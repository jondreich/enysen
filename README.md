# Enysen
## Dependencies
The following dependencies are all required:
- [elixir](https://elixir-lang.org/)
  - which requires [erlang](https://www.erlang.org/)
- [postgresql](https://www.postgresql.org/)
- [nginx](https://github.com/nginx/nginx.git)
- [nginx rtmp](https://github.com/arut/nginx-rtmp-module.git)

see `install_nginx_rtmp.sh` for the steps required to install on nginx-rtmp ubuntu (should be easy to translate to other os)

## Getting Started
Theres a few folders we need before we can get started, if you're not changing those locations run `environment/create_folders.sh`

you should now have these folders
```
/var/www/dash
/var/www/hls
```
now start nginx
```
sudo /usr/local/nginx/sbin/nginx
```
last thing to do is configure and start the app
```
cd apps/enysen
mix deps.get
mix ecto.create && mix ecto.migrate
```
change the `live_video_source` in `enysen_web\controllers\page_controller.ex` to your machine's IP
```
mix phx.server
```
navigate to the webpage and create an account

go to `http://<host>/u/dashboard` to find your stream key

use [obs](https://obsproject.com/) or similar to stream to `rtmp://<host>/app` and watch playback at `http://<host>/<username>`

to simulate a currently live stream, you can use the following requests:
- start: `http://<host>/start-stream?name=<stream key>`
- stop: `http://<host>/end-stream?name=<stream key>`