package com.jsu.bean;

public class Song {
    private Integer id;
    private String songName;
    private String singerName;
    private String type;
    private Integer playCount;
    private String url;

    public Song() {
    }

    public Song(Integer id, String songName, String singerName, String type, Integer playCount, String url) {
        this.id = id;
        this.songName = songName;
        this.singerName = singerName;
        this.type = type;
        this.playCount = playCount;
        this.url = url;
    }

    public Song(Integer id, String songName) {
        this.id = id;
        this.songName = songName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSongName() {
        return songName;
    }

    public void setSongName(String songName) {
        this.songName = songName;
    }

    public String getSingerName() {
        return singerName;
    }

    public void setSingerName(String singerName) {
        this.singerName = singerName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getPlayCount() {
        return playCount;
    }

    public void setPlayCount(Integer playCount) {
        this.playCount = playCount;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Song{" +
                "id=" + id +
                ", songName='" + songName + '\'' +
                ", singerName='" + singerName + '\'' +
                ", type='" + type + '\'' +
                ", playCount=" + playCount +
                ", url='" + url + '\'' +
                '}';
    }
}
