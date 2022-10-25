package fileUploadProj02;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

public class Thumbnail
{
   public Thumbnail() {}
 
   public static void createImage(String loadFile, String saveFile,int zoom)
    throws IOException //썸네일 이미지를 생성하는 메서드
 { 
  
   File  save = new File(saveFile);  //썸네일 이미지 파일
   RenderedOp  rOp = JAI.create("fileload", loadFile);  //loadFile는 원본 이미지파일 RenderedOp 객체생성
       BufferedImage im = rOp.getAsBufferedImage();   //BufferedImage 객체를 얻어옴
       
       if(zoom <= 0) zoom = 1;     //zoom이 5이면 원본이미지의 1/5 크기가 된다.
       
       int width = im.getWidth()  / zoom;
       int height = im.getHeight() / zoom;
   
   BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);  //메모리에 이미지 공간을 생성
   Graphics2D  g2 = thumb.createGraphics();   //BufferedImage로 부터 Graphics2D객체를 얻어냄
      
   g2.drawImage(im, 0, 0, width, height, null);  //메모리의 이미지공간에 원본 이미지를 가로 width, 세로 height 크기로 그린다.
      
   ImageIO.write(thumb, "png", save);     //메모리에 그린이미지를 파일로 저장 
 } 
}