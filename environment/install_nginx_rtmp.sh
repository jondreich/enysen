apt-get update
apt-get install git gcc make libpcre3-dev libssl-dev ffmpeg -y
mkdir ~/build && cd build
git clone https://github.com/arut/nginx-rtmp-module.git
git clone https://github.com/nginx/nginx.git
cd nginx
./auto/configure --add-module=../nginx-rtmp-module
make
make install
cp nginx.dev.conf /usr/local/nginx/conf/nginx.conf