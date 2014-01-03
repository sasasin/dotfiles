#!/bin/bash -v

ads2500w_rename.sh *_*.jpg
ls *.jpg | xargs -P8 -L3 mogrify -trim

ls *.jpg | xargs -P8 -L3 hosei_ura.sh
ls *.jpg | xargs -P8 -L3 hosei_ura.sh
ls *[13579].jpg | xargs -P8 -L3 hosei_ura.sh

ls *.jpg | xargs -P8 -L3 hosei_white.sh
#ls *.jpg | xargs -P8 -L3 hosei_sharpen.sh
make_jisui_pdf.sh $(get_timestamp.sh)
