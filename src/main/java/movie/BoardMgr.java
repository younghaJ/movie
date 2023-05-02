package movie;

import java.io.File;
import java.sql.*;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import movie.UtilMgr;

public class BoardMgr {
	DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/eclipse-workspace/movieProject/src/main/webapp/boardfileupload/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;//20MB
	public BoardMgr()
	{
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public Vector<BoardBean> getBoardList(String type, String keyField, String keyWord)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist=new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if(type=="리뷰" || type=="추천" || type=="영화")
			{
				sql = "select * from BOARD where CATEGORY = ?";
				if(!(keyWord.trim().equals("")||keyWord==null))
				{
					sql+=" and "+keyField+" like '%?%'";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, ""+type);
					pstmt.setString(2, keyWord);
				}
				else
				{
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, ""+type);
				}
			}
			else
			{
				sql="select * from BOARD";
				if(!(keyWord.trim().equals("")||keyWord==null))
				{
					sql+=" where "+keyField+" like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
				}
				else
					pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				BoardBean bean=new BoardBean();
				bean.setBoardIdx(rs.getInt(1));
				bean.setUserId(rs.getString(2));
				bean.setCategory(rs.getString(3));
				bean.setTitle(rs.getString(4));
				bean.setDetail(rs.getString(5));
				bean.setMovieIdx(rs.getInt(6));
				bean.setLiked(rs.getInt(7));
				bean.setPostedDate(rs.getDate(8));
				vlist.add(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public int getBoardCount(String type, String keyField, String keyWord)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			if(type=="리뷰" || type=="추천" || type=="영화")
			{
				sql = "select count(*) from BOARD where CATEGORY = ?";
				if(!(keyWord.trim().equals("")||keyWord==null))
				{
					sql+=" and "+keyField+" like '%?%'";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, ""+type);
					pstmt.setString(2, keyWord);
				}
				else
				{
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, ""+type);
				}
			}
			else
			{
				sql="select count(*) from BOARD";
				if(!(keyWord.trim().equals("")||keyWord==null))
				{
					sql+=" where "+keyField+" like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
				}
				else
					pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	public BoardBean getBoard(int boardIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean=new BoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from BOARD where BOARDIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				bean.setBoardIdx(boardIdx);
				bean.setUserId(rs.getString(2));
				bean.setCategory(rs.getString(3));
				bean.setTitle(rs.getString(4));
				bean.setDetail(rs.getString(5));
				bean.setMovieIdx(rs.getInt(6));
				bean.setLiked(rs.getInt(7));
				bean.setPostedDate(rs.getDate(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	public void insertBoard(BoardBean bean)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert BOARD(BOARDIDX, USERID, CATEGORY, TITLE, DETAIL, MOVIEIDX, LIKED, POSTEDDATE) values (?,?,?,?,?,?,0,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getBoardIdx());
			pstmt.setString(2, bean.getUserId());
			pstmt.setString(3, bean.getCategory());
			pstmt.setString(4, bean.getTitle());
			pstmt.setString(5, bean.getDetail());
			pstmt.setInt(6, bean.getMovieIdx());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void insertBoard(HttpServletRequest req)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않는다면*/)
				dir.mkdirs();//상위폴더가 없어도 생성
				//mkdir : 상위폴더가 없으면 생성불가
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCODING, new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			String content = multi.getParameter("DETAIL");
			String contentType = multi.getParameter("contentType");
			if(contentType.equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			//////////////////////////////////////////
			con = pool.getConnection();
			sql = "insert BOARD(USERID, CATEGORY, TITLE, DETAIL, MOVIEIDX, LIKED, POSTEDDATE) values (?,?,?,?,?,0,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("USERID"));
			pstmt.setString(2, multi.getParameter("CATEGORY"));
			pstmt.setString(3, multi.getParameter("TITLE"));
			pstmt.setString(4, content);
			pstmt.setString(5, multi.getParameter("MOVIEIDX"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void updateBoard(HttpServletRequest req)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않는다면*/)
				dir.mkdirs();//상위폴더가 없어도 생성
				//mkdir : 상위폴더가 없으면 생성불가
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCODING, new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			String content = multi.getParameter("DETAIL");
			String contentType = multi.getParameter("contentType");
			if(contentType.equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			//////////////////////////////////////////
			con = pool.getConnection();
			sql = "update BOARD set USERID = ?, CATEGORY = ?, TITLE = ?, DETAIL = ?, MOVIEIDX = ?, LIKED = ?, POSTEDDATE = now() where BOARDIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("USERID"));
			pstmt.setString(2, multi.getParameter("CATEGORY"));
			pstmt.setString(3, multi.getParameter("TITLE"));
			pstmt.setString(4, content);
			pstmt.setString(5, multi.getParameter("MOVIEIDX"));
			pstmt.setString(6, multi.getParameter("LIKED"));
			pstmt.setString(7, multi.getParameter("orignum"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteBoard(int boardIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from BOARD where BOARDIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public Vector<BoardCommentBean> getCommentList(int boardIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardCommentBean> vlist=new Vector<BoardCommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from BOARDCOMMENT where BOARDIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				BoardCommentBean bean=new BoardCommentBean();
				bean.setcIdx(rs.getInt(1));
				bean.setBoardIdx(rs.getInt(2));
				bean.setUserId(rs.getString(3));
				bean.setDetail(rs.getString(4));
				bean.setPostedDate(rs.getDate(5));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public int getCommentCount(int boardIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from BOARDCOMMENT where BOARDIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	public void insertComment(BoardCommentBean bean)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert BOARDCOMMENT(BOARDIDX, USERID, DETAIL, POSTEDDATE) values (?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getBoardIdx());
			pstmt.setString(2, bean.getUserId());
			pstmt.setString(3, bean.getDetail());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void insertComment(HttpServletRequest req)
	{

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCODING, new DefaultFileRenamePolicy());
			String content = multi.getParameter("DETAIL");
			//////////////////////////////////////////
			con = pool.getConnection();
			sql = "insert BOARDCOMMENT(BOARDIDX, USERID, DETAIL, POSTEDDATE) values (?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("BOARDIDX"));
			pstmt.setString(2, multi.getParameter("USERID"));
			pstmt.setString(3, content);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteComment(int cIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from BOARDCOMMENT where CIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteCommentAtBoard(int boardIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from BOARDCOMMENT where BOARDIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public boolean hasLiked(int boardIdx, String userId)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from BOARDLIKE where BOARDIDX = ? and USERID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			pstmt.setString(2, userId);
			rs = pstmt.executeQuery();
			if(rs.next())
				flag=true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	public void pushLike(int boardIdx, String userId)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert BOARDLIKE(BOARDIDX, USERID, LIKEDDATE) values (?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			pstmt.setString(2, userId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		checkLike(boardIdx);
	}
	public void cancelLike(int boardIdx, String userId)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from BOARDLIKE where BOARDIDX = ? and USERID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			pstmt.setString(2, userId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		checkLike(boardIdx);
	}
	public void checkLike(int boardIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update BOARD set LIKED = (select count(*) from BOARDLIKE where BOARDIDX = ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
}