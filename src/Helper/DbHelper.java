package Helper;
import java.sql.*;

public class DbHelper {
	
	 public Connection GetConnection()
	 {
		 Connection conn = null;
		 try{
				Class.forName("org.gjt.mm.mysql.Driver");
				String urls = "jdbc:mysql://localhost/test?user=root&password=zhouyang" + "&useUnicode=true&characterEncoding=GB2312";
				conn = DriverManager.getConnection(urls);
		 }
		 catch(Throwable ex)
		 {
			 ex.printStackTrace(System.out);
		 }
		return conn;
	 }
	 
}
