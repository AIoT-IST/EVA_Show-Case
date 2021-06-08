#!/bin/bash

LB='\033[1;33m'
NC='\033[0m' # No Color

# echo message with color
message_out(){
    echo -e "${LB}=> $1${NC}"
}

message_out "Start running geofence demo..."

gst-launch-1.0 filesrc location=geo-fencing-demo.mp4 ! qtdemux ! h264parse ! avdec_h264 ! videoconvert ! adrt model=mobilenetSSDv2_geofencing.engine batch=1 device=0 scale=0.008 mean="127 127 127" rgbconv=true ! adtrans_ssd max-count=5 label=adlink-mobilenetSSDv2-geo-fencing-label.txt threshold=0.1 ! geofencefoot alert-area-def=alert-def-area-geo.txt area-display=true person-display=true alert-type=geofence ! email_alert alert-type=geofence receiver-address=xxx@xxx.com ! videoconvert ! ximagesink
