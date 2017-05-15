package com.wrox;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;

@ServerEndpoint("/ticTacToe")
public class TicTacToeServer
{
    private static Set<Session> sessions = new HashSet<>();
    private Thread testThread = null;

    Thread.UncaughtExceptionHandler h = new Thread.UncaughtExceptionHandler() {
        public void uncaughtException(Thread th, Throwable ex) {
            System.out.println("Uncaught exception: " + ex);
        }
    };

    @OnOpen
    public void onOpen(Session session)
    {
        try
        {
            if (!sessions.contains(session)) {
                sessions.add(session);
            }
            if (testThread == null) {  // Make Sure the Main Thread Started
                testThread = new Thread(this::run);
                testThread.setUncaughtExceptionHandler(h);
                testThread.start();
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
            try
            {
                session.close(new CloseReason(
                        CloseReason.CloseCodes.UNEXPECTED_CONDITION, e.toString()
                ));
            }
            catch(IOException ignore) { }
        }
    }

    @OnMessage
    public void onMessage(Session session, String message)
    {
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }

    @OnError
    public void onError(Session session, Throwable t) {
        System.out.println(t.toString());
    }

    private void run() {
        while (true) {
            LocalDateTime time = LocalDateTime.now();
            ZonedDateTime zonedDateTime = ZonedDateTime.of(time, ZoneId.of("UTC"));
            String message = zonedDateTime.toString();
            for (Session session : sessions) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    System.out.println(e.toString());
                }
            }
            try {
                Thread.sleep(2000);
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        }
    }
}
