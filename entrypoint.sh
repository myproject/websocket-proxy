cd /v2ray
wget -O v2ray.zip http://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
unzip v2ray.zip 
mv /v2ray/v2ray-v$VER-linux-64/v2ray .
mv /v2ray/v2ray-v$VER-linux-64/v2ctl .
mv /v2ray/v2ray-v$VER-linux-64/geoip.dat .
mv /v2ray/v2ray-v$VER-linux-64/geosite.dat .

rm -rf /v2ray
rm -f /v2ray.zip

chmod +x v2ray v2ctl net_speeder
sed -i "s/your_uuid/$UUID/g" config.json
sed -i "s/8888/$PORT/g" config.json

ETH=$(eval "ifconfig | grep 'eth0'| wc -l")
if [ "$ETH"  ==  '1' ] ; then
	nohup /v2ray/net_speeder eth0 "ip" >/dev/null 2>&1 &
fi
if [ "$ETH"  ==  '0' ] ; then
    nohup /v2ray/net_speeder venet0 "ip" >/dev/null 2>&1 &
fi

./v2ray