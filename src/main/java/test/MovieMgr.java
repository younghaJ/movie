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
	
	public ArrayList<MovieBean> getMovielist(String keyField, String keyWord, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<MovieBean> vlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				sql = "select * from movie order by movieidx, movieidx limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
				System.out.println("이거 출력");
			}	else {
				sql = "select * from movie where "
						+ "? like ? order by movieidx, movieidx limit ?, ?";
				System.out.println(keyField);
				System.out.println(keyWord + " : " + start + " : " + cnt);
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyField);
				pstmt.setString(2, "%" + keyWord + "%");
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieBean bean = new MovieBean();
				bean.setTitle(rs.getString("title"));
				bean.setPoster(rs.getString("poster"));
				bean.setContent(rs.getString("content"));
				bean.setGenre(rs.getString("genre"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// Board Total Count : 총게시목록순
		public int getTotalCount(String keyField, String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if(keyWord.trim().equals("")||keyWord==null) {
					sql = "select count(*) from movie";
					pstmt = con.prepareStatement(sql);
				}	else {
					sql = "select count(*) from movie where "
							+ "? like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyField);
					pstmt.setString(2, "%" + keyWord + "%");
					System.out.println(pstmt);
				}
				rs = pstmt.executeQuery();
				if(rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
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


