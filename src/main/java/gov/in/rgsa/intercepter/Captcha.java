package gov.in.rgsa.intercepter;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Captcha extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int height = 0;
	private int width = 0;

	public static final String CAPTCHA_KEY = "captcha_key_name";

	public void init(ServletConfig config) throws ServletException {
		
		super.init(config);
		height = Integer.parseInt(getServletConfig().getInitParameter("height"));
		width = Integer.parseInt(getServletConfig().getInitParameter("width"));
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException {
		// Expire response
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Max-Age", 0);

		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D graphics2D = image.createGraphics();

		graphics2D = (Graphics2D) image.getGraphics();

		graphics2D.setColor(new Color(133, 133, 133));
		graphics2D.fillRect(0, 0, width, height);

		GradientPaint gp1 = new GradientPaint(5, 5, Color.BLACK, 8, 8, Color.DARK_GRAY, true);

		graphics2D.setPaint(gp1);
		graphics2D.fillRect(0, 0, width, height);

		Random r = new Random();
		String token = Long.toString(Math.abs(r.nextLong()), 36);// "jw62k"

		String topChar = token.substring(0, 2);
		String midChar = token.substring(2, 6);
		topChar = topChar.replace('0', '1');
		topChar = topChar.replace('o', 'a');
		topChar = topChar.replace('9', '8');
		topChar = topChar.replace('q', 'b');

		midChar = midChar.replace('0', '1');
		midChar = midChar.replace('o', 'a');
		midChar = midChar.replace('9', '8');
		midChar = midChar.replace('q', 'b');

		// Font properties
		Color c = new Color(255, 255, 255); // Font Color
		Font font = new Font("Segoe Print", Font.CENTER_BASELINE + Font.ITALIC, 37);

		GradientPaint fontGradientPaint = new GradientPaint(60, 170, c, 60, 170, Color.WHITE, true);
		graphics2D.setPaint(fontGradientPaint);

		graphics2D.setFont(font);
		FontMetrics fm = graphics2D.getFontMetrics();

		int topX = 10;
		int topY = fm.getHeight() / 2 + 10;

		graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		graphics2D.drawString(topChar, topX, topY);

		int midX = 75;
		int midY = 40;

		graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		graphics2D.drawString(midChar, midX, midY);

		graphics2D.dispose();

		HttpSession session = req.getSession(true);
		session.setAttribute(CAPTCHA_KEY, topChar + midChar);

		OutputStream outputStream = response.getOutputStream();
		ImageIO.write(image, "jpeg", outputStream);

		outputStream.close();

	}

}
