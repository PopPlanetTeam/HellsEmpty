extends AudioStreamPlayer

func play_stream(audioStream: AudioStream, db: float = 0.0):
	if audioStream == self.stream:
		if not self.playing:
			play()
	else:
		self.stream = audioStream
		self.volume_db = db
		play()

func stop_stream():
	stop()
	self.stream = null
	
	
