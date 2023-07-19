package com.example.myBlockchain;

import java.io.Serializable;

public class Header implements Serializable {
    private static final long serialVersionUID = 1L;
    public int index;
    public String currHash, prevHash;
    public long timeStamp;

    public String getCurrHash() {
        return currHash;
    }

    public void setCurrHash(String currHash) {
        this.currHash = currHash;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public String getPrevHash() {
        return prevHash;
    }

    public void setPrevHash(String prevHash) {
        this.prevHash = prevHash;
    }

    public long getTimestamp() {
        return timeStamp;
    }

    public void setTimestamp(long timeStamp) {
        this.timeStamp = timeStamp;
    }

    @Override
    public String toString() {
        return "Header [index=" + index +
                ", currHash=" + currHash +
                ", prevHash=" + prevHash +
                ", timestamp=" + timeStamp + "]";
    }
}