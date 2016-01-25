#!/bin/bash -v

ls *.jpg | xargs -P1 -L3 hosei_ura.sh
ls *.jpg | xargs -P1 -L3 hosei_ura.sh
ls *[13579].jpg | xargs -P1 -L3 hosei_ura.sh

ls *.jpg | xargs -P1 -L3 hosei_white.sh

ls *.jpg | xargs -P1 -L3 mogrify -trim

#ls *.jpg | xargs -P1 -L3 hosei_sharpen.sh

#make_jisui_pdf.sh $(get_timestamp.sh)
