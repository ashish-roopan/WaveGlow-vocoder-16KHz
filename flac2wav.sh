tar -xvzf train-clean-100.tar.gz
mkdir train-clean-100/data/ train-clean-100/wav_data/
find train-clean-100/LibriSpeech/train-clean-100/ -maxdepth 3 -type f -print0 | xargs -0 mv -t train-clean-100/data/
ls train-clean-100/data/ | wc -l
i=1
for f in $(ls train-clean-100/data/); do
	echo $i
	i=$((i+1))	
	new=$( echo $f | cut -d '.' -f 1 )
	new="train-clean-100/wav_data/$new.wav"
	f="train-clean-100/data/$f"
	# echo $f
	# echo $new
	ffmpeg -i $f $new
done
