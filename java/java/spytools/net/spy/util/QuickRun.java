// Copyright (c) 2000  Dustin Sallings <dustin@spy.net>
//
// $Id: QuickRun.java,v 1.1 2000/11/05 11:55:30 dustin Exp $

package net.spy.util;

import java.util.*;
import java.net.*;
import java.io.*;

import net.spy.SpyUtil;

/**
 * Listens on a socket and lets you run stuff without firing up a new JVM.
 */

public class QuickRun extends Thread {

	// Server stuff
	protected ServerSocket server=null;
	protected int port=11011;

	// Client stuff
	protected Socket client=null;
	protected BufferedReader in=null;
	protected PrintWriter out=null;
	protected OutputStream ostream=null;

	public QuickRun(Socket s) throws Exception {
		super();
		this.client=s;
	}

	public QuickRun(int port) throws Exception {
		super();
		this.port=port;
	}

	public void run() {
		try {
			in = new BufferedReader(
				new InputStreamReader(client.getInputStream()));
			ostream=client.getOutputStream();
		out = new PrintWriter(new OutputStreamWriter(ostream));

			// Greet the client
			out.println("QuickRun ready.");
			out.flush();

			// Get the command.
			String cmd=in.readLine();

			processCmd(cmd);
		} catch(Exception e) {
			System.err.println("QuickRun exception:  " +e);
			e.printStackTrace();
		} finally {
			try { ostream.close(); } catch(Exception e) {}
			try { out.close(); } catch(Exception e) {}
			try { in.close(); } catch(Exception e) {}
		}
	}

	protected void processCmd(String line) throws Exception {
		String cmd=null, args=null;
		int colon=line.indexOf(":");
		cmd=line.substring(0, colon);
		args=line.substring(colon+1);

		System.out.println("Got command:  " + cmd + " args:  " + args);

		if(cmd.equals("COMPILE")) {
			// Grab the Sun compiler
			sun.tools.javac.Main compiler=
				new sun.tools.javac.Main(ostream, "javac");
			compiler.compile(SpyUtil.split(" ", args));
		} else if(cmd.equalsIgnoreCase("QUIT")) {
			out.close();
			ostream.close();
			in.close();
		} else {
			out.println("Invalid command:  " + cmd);
		}
	}

	public void goServer() throws Exception {
		server=new ServerSocket(port);
		System.out.println("QuickRun server listening on port " + port);

		while(true) {
			Socket client=server.accept();
			client.setSoTimeout(15000);
			QuickRun c=new QuickRun(client);
			c.start();
		}
	}

	public static void main(String args[]) throws Exception {
		QuickRun qr=new QuickRun(Integer.parseInt(args[0]));
		qr.goServer();
	}
}