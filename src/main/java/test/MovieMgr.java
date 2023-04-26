package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MovieMgr {

	private DBConnectionMgr pool;
	
	public MovieMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public ArrayList<MovieBean> getMovie(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<MovieBean> vlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			sql = "select * from movie where movieidx = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MovieBean bean = new MovieBean();
				bean.setTitle(rs.getString("title"));
				bean.setPoster(rs.getString("poster"));
				bean.setContent(rs.getString("content"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public ArrayList<MovieBean> getMoviel(int cpage, int pages) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<MovieBean> vlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			sql = "select * from movie where movieidx >=" + cpage 
					+ "&& movieidx <= " + cpage + pages;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MovieBean bean = new MovieBean();
				bean.setTitle(rs.getString("title"));
				bean.setPoster(rs.getString("poster"));
				bean.setContent(rs.getString("content"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public int countMovie() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from movie";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	public ArrayList<MovieBean> searchMovie(String str) {
		ArrayList<MovieBean> vlist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select MOVIEIDX, title\r\n"
					+ "from movie\r\n"
					+ "where title like '%?%'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, str);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MovieBean bean = new MovieBean();
				bean.setTitle(rs.getString("title"));
				bean.setPoster(rs.getString("poster"));
				bean.setContent(rs.getString("content"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
}


