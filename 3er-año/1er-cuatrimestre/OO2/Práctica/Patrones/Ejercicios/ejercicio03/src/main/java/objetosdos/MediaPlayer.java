package objetosdos;

import java.util.List;

public class MediaPlayer {
    private List<Media> media;

    public void play() {
        for (Media m : media)
            m.play();
    };
}
