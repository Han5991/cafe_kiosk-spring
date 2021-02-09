package com.mycafe.kiosk;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;

import com.mycafe.beans.ClientDto;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.websocket.Session;

@Controller
@ServerEndpoint(value = "/webChatServer")
public class WebChatServer extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static Map<Session, ClientDto> users = Collections.synchronizedMap(new HashMap<Session, ClientDto>());
	private static Session session;

	@OnMessage
	public void onMsg(String message, Session session) throws IOException {
//		String userName = users.get(session).getName();
//		message = OderDao.getInstance().getOneOder(message);
		synchronized (users) {
//			WebChatServer.session.getBasicRemote().sendText( message+ ","+userName);
//			WebChatServer.session.getBasicRemote().sendText(message);
			Iterator<Session> it = users.keySet().iterator();
			while (it.hasNext()) {
				Session currentSession = it.next();
				currentSession.getBasicRemote().sendText(message);
			}
		}
	}

	@OnOpen
	public void onOpen(Session session) {

		ClientDto client = new ClientDto();

		client.setName(ClientDto.getinstance().getName());
		if (client.getName().equals("admin"))
			WebChatServer.session = session;

		System.out.println(session + " connect");

		users.put(session, client);
//		sendNotice(client.getName() + "님이 입장 하셨습니다 현재 사용자 수 : " + users.size() + "紐�");
	}

//	public void sendNotice(String message) {
//		String userName = "server";
//		System.out.println(userName + " : " + message);
//
//		synchronized (users) {
//			Iterator<Session> it = users.keySet().iterator();
//			while (it.hasNext()) {
//				Session currentSession = it.next();
//				try {
//					currentSession.getBasicRemote().sendText(userName + " : " + message);
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//			}
//		}
//	}

	@OnClose
	public void onClose(Session session) {
		String userName = users.get(session).getName();
		users.remove(session);
//		sendNotice(userName + "님이 입장 하셨습니다 현재 사용자 수 : " + users.size() + "명");
	}

}