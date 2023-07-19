package com.example.myBlockchain;

import java.io.ByteArrayOutputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.sql.Timestamp;

import com.example.myHash.Hasher;

public class Block implements Serializable {
    private static final long serialVersionUID = 1L;
    public Header header;
    public Transaction tranx;

    // One block in the chain
    public Block(String prevHash) {
        header = new Header();
        header.setTimestamp(new Timestamp(System.currentTimeMillis()).getTime());
        header.setPrevHash(prevHash);
        String info = String.join("+", Integer.toString(header.getIndex()),
                Long.toString(header.getTimestamp()), header.getPrevHash());
        String blockHash = Hasher.sha256(info);
        header.setCurrHash(blockHash);
    }

    public Header getHeader() {
        return header;
    }

    public Transaction getTranx() {
        return tranx;
    }

    public void setTranx(Transaction tranx) {
        this.tranx = tranx;
    }

}
