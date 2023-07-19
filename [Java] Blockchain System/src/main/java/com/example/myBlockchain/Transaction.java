package com.example.myBlockchain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Transaction implements Serializable {
    public static final int SIZE = 10;

    public String merkleRoot;
    public List<String> tranxList;

    public Transaction() {
        tranxList = new ArrayList<>(SIZE);
    }

    public String getMerkleRoot() {
        return merkleRoot;
    }

    public void setMerkleRoot(String merkleRoot) {
        this.merkleRoot = merkleRoot;
    }

    public List<String> getTranxLst() {
        return tranxList;
    }

    public void add(String tranx) {
        tranxList.add(tranx);
    }

    @Override
    public String toString() {
        return "Transaction [tranxLst=" + tranxList + "]";
    }
}
