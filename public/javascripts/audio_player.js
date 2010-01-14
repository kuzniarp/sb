AudioPlayer = Class.create({
  initialize: function(){
  },
  setPlayer: function(flashPlayer){
    this.flashPlayer = flashPlayer;
  },
  onInit: function(){
  },
  onUpdate: function(){
    if (this.isPlaying == "false") {
      this.stop();
    }
  },
  play: function(track){
    this.stop();
    this.currentTrack = track;
    this.flashPlayer.SetVariable("method:setUrl", this.currentTrack.url);
    this.flashPlayer.SetVariable("method:play", "");
    this.flashPlayer.SetVariable("enabled", "true");
    this.currentTrack.play();
  },
  stop: function(){
    if (this.currentTrack != null) {
      this.currentTrack.stop();
    }
    this.flashPlayer.SetVariable("method:stop", "");
  }
});

Track = Class.create({
  initialize: function(url, playButton, stopButton){
    this.url = url;
    this.playButton = playButton;
    this.stopButton = stopButton;
  },
  play: function(){
    this.playButton.hide();
    this.stopButton.show();
  },
  stop: function(){
    this.stopButton.hide();
    this.playButton.show();
  }
});

var audioPlayer = new AudioPlayer();
