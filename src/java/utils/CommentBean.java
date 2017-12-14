/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author Blumie
 */
public class CommentBean implements Serializable {
    
    private int id;
    private String comment;
    private String author;
    private Timestamp date;
    private int ticketId;
    private String clientView;

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
    
    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }
    
    public String getClientView() {
        return clientView;
    }

    public void setClientView(String clientView) {
        this.clientView = clientView;
    }

    
}
