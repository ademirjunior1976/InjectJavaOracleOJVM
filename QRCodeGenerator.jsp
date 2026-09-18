create or replace and compile java source named "QRCodeGenerator" as
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import oracle.sql.BLOB;

public class QRCodeGenerator {
    public static BLOB generateQRCode(String dataText, int width, int height) throws Exception {
        if (dataText == null || dataText.trim().isEmpty()) return null;

        // ZXing encoding and margin configurations
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);
        hints.put(EncodeHintType.MARGIN, 1);

        // 1. Generates the bit matrix (BitMatrix) using ZXing core.jar
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(dataText, BarcodeFormat.QR_CODE, width, height, hints);

        int matrixWidth = bitMatrix.getWidth();
        int matrixHeight = bitMatrix.getHeight();

        // 2. Renders pixels using the JDK's native AWT API (eliminates the need for javase.jar)
        BufferedImage image = new BufferedImage(matrixWidth, matrixHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = image.createGraphics();
        
        // White Background
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, matrixWidth, matrixHeight);
        
        // Black Modules
        graphics.setColor(Color.BLACK);
        for (int i = 0; i < matrixWidth; i++) {
            for (int j = 0; j < matrixHeight; j++) {
                if (bitMatrix.get(i, j)) {
                    graphics.fillRect(i, j, 1, 1);
                }
            }
        }
        graphics.dispose();

        // 3. Converts the image to PNG format in bytes
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "PNG", baos);
        byte[] imageBytes = baos.toByteArray();

        // 4. Creates and returns the temporary Oracle BLOB
        Connection conn = DriverManager.getConnection("jdbc:default:connection:");
        BLOB newBlob = BLOB.createTemporary(conn, false, BLOB.DURATION_SESSION);
        newBlob.setBytes(1, imageBytes);
        return newBlob;
    }
}
/
