/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.deutsche.dba.web;

import com.deutsche.dba.utils.SimpleJsonMessage;

import deutschebank.MainUnit;
import deutschebank.core.ApplicationScopeHelper;
import deutschebank.core.UserController;
import deutschebank.dbutils.User;
import deutschebank.dbutils.UserHandler;
import deutschebank.dbutils.UserIterator;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author Selvyn
 */
@Path("/services")
public class DBDAServicePort implements IDBDAServicePort {
	final UserController userController = new UserController();

	private final static String DBDRIVER = "com.mysql.cj.jdbc.Driver";
	private final static String DBDRIVER2 = "com.mysql.jdbc.Driver";
	private final static String DBPATH = "jdbc:mysql://localhost:3307/";
	private final static String DBNAME = "mysql";
	private final static String DBUSER = "root";
	private final static String DBPWD = "ppp";
	private static final String SCHEMANAME = "db_grad_1917.";
	private Connection con = null;
	private static PreparedStatement stmt;

	// oldIP= 10.11.32.20

	public boolean initialization() {
		if (con != null) {
			return false;
		}
		try {
			Class.forName(DBDRIVER);
			con = DriverManager.getConnection(DBPATH + DBNAME, DBUSER, DBPWD);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("connection made");
		return true;

	}

	@GET
	@Path("/init")
	public Response init() throws SQLException {
		String returnVAl = "";
		try {
			Class.forName(DBDRIVER);
			con = DriverManager.getConnection(DBPATH + DBNAME, DBUSER, DBPWD);
			String sbQuery = "select * from db_grad_1917.users";// where user_id=selvyn and user_pwd=gradprog2016";
			// Statement stmt = con.createStatement();
			// ResultSet r = stmt.executeQuery(sbQuery);

			PreparedStatement stmt = con.prepareStatement(sbQuery);
			// stmt.setString(1, "selvyn");
			// stmt.setString(2, "gradprog2016");
			ResultSet rs = stmt.executeQuery();
			ResultSetMetaData md = rs.getMetaData();
			int len = md.getColumnCount();

			while (rs.next()) {
				String row = "";
				for (int i = 1; i <= len; ++i) {
					row += rs.getString(i) + " | ";

				}
				row += "\n";
				returnVAl += row;
				// System.out.println("User ID: " +rs.getString("user_id"));
				System.out.println(row);
			}
			UserIterator iter = new UserIterator(rs);

			if (iter.next()) {
				User result = iter.buildUser();
				MainUnit.log(result.getUserID() + "//" + result.getUserPwd());
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// DBConnector connector = new DBConnector();
		if (con != null)
			System.out.println("connection with DB made");
		String result = "<html> " + "<title>" + "DBDA" + "</title>" + "<body><h1>" + "the dbda is running..."
				+ "</h1></body>" + "</html> ";

		return Response.status(200).entity(returnVAl).build();
	}

	@Override
	@GET
	@Path("/sayhello")
	public Response sayHtmlHelloTest() {
		String result = "<html> " + "<title>" + "DBDA" + "</title>" + "<body><h1>" + "the dbda is running..."
				+ "</h1></body>" + "</html> ";

		return Response.status(200).entity(result).build();
	}

	@Override
	@GET
	@Path("/getAllTags")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response getAllTags() {
		String result = "getAllTags() need to be built";
		return Response.ok(result, MediaType.APPLICATION_JSON_TYPE).build();
	}

	@Override
	@GET
	@Path("/getAllURL")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response getAllURL() {
		String result = "getAllURL() need to be built";
		return Response.ok(result, MediaType.APPLICATION_JSON_TYPE).build();
	}

	@Override
	@GET
	@Path("/get/{tags}")
	public Response getSavedURLWithInfo(@PathParam("tags") String tags) {
		String result = "getSavedURLWithInfo() need to be built";
		return Response.ok(result, MediaType.APPLICATION_JSON_TYPE).build();
	}

	@Override
	@GET
	@Path("/login/{usr}/{pwd}")
	public Response loginWithInfo(@PathParam("url") String usr, @PathParam("description") String description,
			@PathParam("tags") String tags) {
		String result = "loginWithInfo() need to be built";
		System.out.print(usr + " " + description + " " + tags);
		return Response.ok(result, MediaType.APPLICATION_JSON_TYPE).build();
	}

	@Override
	@POST
	@Path("/login")
	public Response loginWithInfoFromForm(@FormParam("usr") String usr, @FormParam("pwd") String pwd)
			throws SQLException {
		System.out.println("jhsru98tydrhy89serdtpy89dtrsepy89serhp789srhtp789dtr"+usr + pwd);
		initialization();
		String result = userController.verifyLoginDetails(con, usr, pwd);

		if (result != null) {
			return Response.ok(new User(usr, pwd), MediaType.APPLICATION_JSON_TYPE).build();

			// return Response.status(200).entity(new User(usr, pwd)).build();

		} else
			return Response.status(400).entity(new SimpleJsonMessage("User could not be found")).build();

	}
	
	@GET
	@Path("/tables2")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTableInfo( @PathParam("tableName")String name,
            @PathParam("filters")String filters)
			throws SQLException {
		// System.out.println(usr + pwd);
		 initialization();

		// String result = userController.verifyLoginDetails(con, usr, pwd);
		System.out.println("table info called ");
		Statement stmt = con.createStatement();
		
		ArrayList<ArrayList<String>> table = selectDataFromTable("deal", "", stmt);
		if (table != null) {
			return Response.ok(table, MediaType.APPLICATION_JSON_TYPE).build();

			// return Response.status(200).entity(new User(usr, pwd)).build();

		} else
			return Response.status(400).entity(new SimpleJsonMessage("User could not be found")).build();

	}
	@GET
	@Path("/ibs")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response getIBS( @PathParam("tableName")String name,
            @PathParam("filters")String filters)
			throws SQLException {
		// System.out.println(usr + pwd);
		 initialization();

		// String result = userController.verifyLoginDetails(con, usr, pwd);
		System.out.println("IBS info called " + con);
		Statement stmt = con.createStatement();
		
		ArrayList<ArrayList<String>> table = correlationDealInstr(stmt);
		if (table != null) {
			return Response.ok(table, MediaType.APPLICATION_JSON_TYPE).build();

			// return Response.status(200).entity(new User(usr, pwd)).build();

		} else
			return Response.status(400).entity(new SimpleJsonMessage("User could not be found")).build();

	}
	
	
	@Override
	@POST
	@Path("/tables")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response tableinfo( @FormParam("tableName")String name,
            @FormParam("filters")String filters)
			throws SQLException {
		// System.out.println(usr + pwd);
		 initialization();

		// String result = userController.verifyLoginDetails(con, usr, pwd);
		System.out.println("table info called ");
		Statement stmt = con.createStatement();
		ArrayList<ArrayList<String>> table = selectDataFromTable(name, filters, stmt);
		if (table != null) {
			return Response.ok(table, MediaType.APPLICATION_JSON_TYPE).build();

			// return Response.status(200).entity(new User(usr, pwd)).build();

		} else
			return Response.status(400).entity(new SimpleJsonMessage("User could not be found")).build();
//asdfas
	}
	
	public static void insertDataToTable(String tbl, String dta, Statement stmt) throws SQLException {
		String query = "INSERT INTO db_grad_1917." + tbl + " VALUES (" + dta + ");";
		stmt.executeUpdate(query);
	}

	public static void deleteDataFromTable(String tbl, String filter, Statement stmt) throws SQLException {
		String query = "DELETE from db_grad_1917." + tbl;
		if (filter != "") {
			query += " WHERE " + filter;
		}
		// System.out.println(query);
		stmt.executeUpdate(query);
	}

	public static void averagePrices(String startDate, String finishDate, Statement stmt) throws SQLException {

		String query = "select\n" + "i.instrument_name,\n"
				+ "sum(case when d.deal_type = 'S' then d.deal_amount else 0 end)/sum(d.deal_quantity) as average_sell_prices,\n"
				+ "sum(case when d.deal_type = 'B' then d.deal_amount else 0 end)/sum(d.deal_quantity) as average_buy_prices\n"
				+ "from " + SCHEMANAME + "deal as d\n" + "inner join \n" + "db_grad_cs_1917.instrument as i\n"
				+ "on d.deal_instrument_id = i.instrument_id\n" + "where d.deal_time between '" + startDate + "' and '"
				+ finishDate + "'\n" + "group by i.instrument_name";
		// System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			System.out.println(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + "\n");
		}
	}

	public static ArrayList<ArrayList<String>> selectDataFromTable(String tbl, String filter, Statement stmt)
			throws SQLException {
		ArrayList<ArrayList<String>> ret = new ArrayList<ArrayList<String>>();
		String query = "SELECT * from " + SCHEMANAME + tbl;
		if (filter != "") {
			query += " WHERE " + filter;
		}
		ResultSet rs = stmt.executeQuery(query);
		ResultSetMetaData md = rs.getMetaData();
		int len = md.getColumnCount();
		while (rs.next()) {
			ArrayList<String> row = new ArrayList<String>();
			for (int i = 1; i <= len; ++i) {
				row.add(rs.getString(i));
			}
			ret.add(row);
		}
		return ret;
	}
	public static ArrayList<ArrayList<String>> correlationDealInstr( Statement stmt) throws SQLException {
		ArrayList<ArrayList<String>> ret = new ArrayList<ArrayList<String>>();
		String query = "select " + 
				"i.instrument_name, " +
				"d.deal_type, " +
				"sum(d.deal_amount * d.deal_quantity) " +
				"from " + SCHEMANAME + "deal as d " +
				"inner join " + SCHEMANAME + "instrument as i " +
				"on d.deal_instrument_id = i.instrument_id " +
				"group by 1, 2 "+
				"order by 1, 2";
		//System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		ResultSetMetaData md = rs.getMetaData();
		int len = md.getColumnCount();
		while(rs.next()) {
			ArrayList<String> row = new ArrayList<String>();
			for (int i = 1; i <= len; ++i) {
				row.add(rs.getString(i));
			}
			ret.add(row);
		}
		return ret;
	}
	/*
	 * Example
	 * 
	 * ArrayList<ArrayList<String>> tbl = selectDataFromTable("deal", "", stmt); for
	 * (ArrayList<String> row: tbl) { for(String dta: row) { System.out.print(dta +
	 * " "); } System.out.println(); }
	 * 
	 */
}
