package movie;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

public class DetailOut {

	private DBConnectionMgr pool;
	private String movieId;
	private HttpServletRequest request;
	 

	public DetailOut(String movieId, HttpServletRequest request) {
	    pool = DBConnectionMgr.getInstance();
	    this.movieId = movieId;
	    this.request = request;
	}

	public DetailOutBean getDetailOutBean(HttpServletRequest request) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    DetailOutBean detailOutBean = new DetailOutBean();
	    try {
	        con = pool.getConnection();
	        sql = "SELECT * FROM movie WHERE movieIdx = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, request.getParameter("movieId"));
	        rs = pstmt.executeQuery();

	        if (rs.next()) {

	            detailOutBean.setMovieidx(rs.getInt("movieIdx"));
	            detailOutBean.setTitle(rs.getString("title"));
	            detailOutBean.setContent(rs.getString("content"));
	            detailOutBean.setPoster(rs.getString("poster"));
	            detailOutBean.setGenre(rs.getString("genre"));
	            detailOutBean.setDirector(rs.getString("director"));
	            detailOutBean.setActor(rs.getString("actor"));
	            detailOutBean.setPlaytime(rs.getString("playtime"));
	            detailOutBean.setAge(rs.getString("age"));
	            detailOutBean.setTrailer(rs.getString("trailer"));
	            detailOutBean.setWatchott(rs.getString("watchott"));
	            detailOutBean.setMaker(rs.getString("maker"));
	            detailOutBean.setOpendt(rs.getString("releaseDate"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }

	    return detailOutBean;
	}

}
