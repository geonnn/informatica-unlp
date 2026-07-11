package objetosdos;

public class VideoStreamAdapter implements Media {
    VideoStream videoStream;

    public VideoStreamAdapter(VideoStream videoStream) {
        this.videoStream = videoStream;
    }

    @Override
    public void play() {
        videoStream.reproduce();
    }
}
