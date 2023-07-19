#Chen Kai Xian TP053307 - Image 4
#Thean Yee Sin TP061278 - Image 1,2
#Yong Zu Yi TP059577 - Image 3,5

#import
import PySimpleGUI as sg
import os.path
import cv2
import numpy as np
from PIL import Image, ImageTk, ImageDraw, ImageFilter, ImageFont, ImageEnhance, ImageOps
from matplotlib import pyplot

#theme
sg.theme('Dark Grey 13')

#segment 1: button
seg1 = [    
    [
        sg.Text("I M A G E")
    ],
    
    [   
        sg.Button("1"),
        sg.Button("2"),
        sg.Button("3"),
        sg.Button("4"),
        sg.Button("5")
    ],
    [
        sg.Button("CANCEL")
    ]
]

#segment 2: original image
seg2 = [
    [
        sg.Text("O R I G I N A L")
    ],
    [
        sg.Image(key="OriginalImage")
    ]
]

#segment 3: updated/enhanced image
seg3 = [
    [
        sg.Text("U P D A T E D")
    ],
    [
        sg.Image(key="UpdatedImage")
    ]
]

#final layout
layout = [
    [
        sg.Column(seg1),
        sg.VSeperator(),
        sg.Column(seg2),
        sg.VSeparator(),
        sg.Column(seg3)
    ]
]

#the window
wind = sg.Window("Image Enhancement",layout,size = (1920,1080),resizable=True)
while True:
    event, values = wind.read()
    #EXIT
    if event =="CANCEL" or event ==sg.WIN_CLOSED:
        break
#====================================================
#       IMAGE 1
#====================================================    
    if event == "1":
        image = cv2.imread("1-5.png")
        
        #blank image
        updatedImage = np.zeros(image.shape, np.uint8)
        
        #increase contrast using contrastStretching
        cv2.intensity_transform.contrastStretching(image,updatedImage,r1 = 70,s1 = 30,r2 = 130,s2 = 150 )
        cv2.imwrite("updated1-5.png",updatedImage)
        
        #increase sharpness using UnsharpMask
        image = Image.open("1-5.png")
        updatedImage = Image.open("updated1-5.png")
        updatedImage = updatedImage.filter(ImageFilter.UnsharpMask(1,105,2))
        
        #add special effect: text
        draw = ImageDraw.Draw(updatedImage)
        font = ImageFont.truetype("arial.ttf",30)
        draw.text((updatedImage.width*0.15,updatedImage.height*0.45),"Protect your spine",fill=(255,255,255),font=font,stroke_width=2, stroke_fill=(0,0,0))
        
        #update
        original_img = ImageTk.PhotoImage(image)
        updated_img = ImageTk.PhotoImage(updatedImage)   
        wind["OriginalImage"].update(data=original_img)
        wind["UpdatedImage"].update(data=updated_img)
        os.remove("updated1-5.png")
#====================================================
#       IMAGE 2
#====================================================    
    if event == "2":
        image = Image.open("005.jpg").resize((600,400)).convert("RGBA")
        
        #change jpg -> png (because jpg doesn't support transparent background which make the moon hard to add)
        image.save("temp005.png")
        pngImage = Image.open("temp005.png").convert("RGBA")
        
        #special effect: add moon.png
        moon = Image.open("moon.png").resize((55,55)).convert("RGBA")
        moon.crop((50,50,50,50))       
        pngImage.paste(moon,(int(pngImage.width*0.10),int(pngImage.height*0.10)),moon)
        pngImage.save("temp005.png")
        
        #remove noise using bilateral filter
        img = cv2.imread("temp005.png")
        bilateral = cv2.bilateralFilter(img, 8, 40, 40,borderType = cv2.BORDER_CONSTANT)
        
        cv2.imwrite("temp005.png",bilateral)
        
        updatedImage = Image.open("temp005.png")
        #update
        original_img = ImageTk.PhotoImage(image)
        updated_img = ImageTk.PhotoImage(updatedImage)     
        wind["OriginalImage"].update(data=original_img)
        wind["UpdatedImage"].update(data=updated_img)
        os.remove("temp005.png")
#====================================================
#       IMAGE 3
#====================================================    
    if event =="3":
        img = cv2.imread('e.png')

        #enhance noise
        improved_img = cv2.fastNlMeansDenoisingColored(img,None,5,5,7,21)
        cv2.imwrite('Image.jpg',img)

        #enhance brightness
        img = Image.open('Image.jpg')
        result = ImageEnhance.Brightness(img)
        result.enhance(1.5).save('Improved_Image.jpg')

        image = Image.open("e.png")
        improved_img = Image.open('Improved_Image.jpg')
        title_font1 = ImageFont.truetype("arial.ttf", 50)
        title_text1 = "My Garden of Flowers"

        title_font2 = ImageFont.truetype("arial.ttf", 70)
        title_text2 = "Is Also"

        title_font3 = ImageFont.truetype("arial.ttf", 50)
        title_text3 = "My Garden of"

        title_font4 = ImageFont.truetype("arial.ttf", 65)
        title_text4 = "Thoughts and Dreams"

        poster = ImageDraw.Draw(improved_img)
        poster.text((improved_img.width*0.13,improved_img.height*0.48),title_text1,(255,255,255),font=title_font1)
        poster.text((improved_img.width*0.35,improved_img.height*0.53),title_text2,(0,0,0),font=title_font2)
        poster.text((improved_img.width*0.27,improved_img.height*0.6),title_text3,(255,255,255),font=title_font3)
        poster.text((improved_img.width*0,improved_img.height*0.65),title_text4,(0,0,0),font=title_font4)

        #update
        original_img = ImageTk.PhotoImage(image)
        updated_img = ImageTk.PhotoImage(improved_img)     
        wind["OriginalImage"].update(data=original_img)
        wind["UpdatedImage"].update(data=updated_img)
        
#====================================================
#       IMAGE 4
#====================================================    
    if event =="4":
        img = Image.open("3-5.jpg").resize((512,340))

        enImg = ImageEnhance.Brightness(img).enhance(0.78)
        enImg2 = ImageEnhance.Contrast(enImg).enhance(1.7)
        enImg3 = ImageEnhance.Color(enImg2).enhance(1.5)

        enImg3.save("new3-5.jpg")

        #----Add Text----
        img2 = Image.open("new3-5.jpg")

        title_font1 = ImageFont.truetype("arial.ttf", 25)
        title_text1 = "My Favourite"

        title_font2 = ImageFont.truetype("arial.ttf", 20)
        title_text2 = "journey is"

        title_font3 = ImageFont.truetype("arial.ttf", 20)
        title_text3 = "looking from"

        title_font4 = ImageFont.truetype("arial.ttf", 20)
        title_text4 = "the rooftop."

        title_font5 = ImageFont.truetype("arial.ttf", 15)
        title_text5 = "- Edward Gorey"

        mergeword = ImageDraw.Draw(img2)
        mergeword.text((img.width*0.70,img.height*0.25),title_text1,(0,0,0),font=title_font1)
        mergeword.text((img.width*0.71,img.height*0.32),title_text2,(0,0,0),font=title_font2)
        mergeword.text((img.width*0.72,img.height*0.38),title_text3,(0,0,0),font=title_font3)
        mergeword.text((img.width*0.73,img.height*0.44),title_text4,(0,0,0),font=title_font4)
        mergeword.text((img.width*0.75,img.height*0.53),title_text5,(0,0,0),font=title_font5)

        #update
        original_img = ImageTk.PhotoImage(img)
        updated_img = ImageTk.PhotoImage(img2)     
        wind["OriginalImage"].update(data=original_img)
        wind["UpdatedImage"].update(data=updated_img)

#====================================================
#       IMAGE 5
#====================================================    
    if event =="5":
        #open the image (same folder no need to use image path)
        img = Image.open('015.jpg')

        #-------------------------------------------------------------------------------------------#
        #---------------Cut Image into 4 Pieces---------------#
        #convert to matrix array
        img_Matrix = np.array(img)

        subMatrix1 = img_Matrix[0:479,0:98,0:3]
        updated_img1 = Image.fromarray(subMatrix1)

        subMatrix2 = img_Matrix[0:479,98:196,0:3]
        updated_img2 = Image.fromarray(subMatrix2)

        subMatrix3 = img_Matrix[0:479,196:294,0:3]
        updated_img3 = Image.fromarray(subMatrix3)

        subMatrix4 = img_Matrix[0:479,294:393,0:3]
        updated_img4 = Image.fromarray(subMatrix4)

        updated_img1.save('Morning.jpg')
        updated_img2.save('Afternoon.jpg')
        updated_img3.save('Evening.jpg')
        updated_img4.save('Night.jpg')

        #-------------------------------------------------------------------------------------------#
        #---------------Enhance the image using the gammaCorrection function---------------#
        img1 = cv2.imread('Morning.jpg')
        img2 = cv2.imread('Afternoon.jpg')
        img3 = cv2.imread('Evening.jpg')
        img4 = cv2.imread('Night.jpg')
        def gammaCorrection(image, gamma):
            invGamma = 1 / gamma
 
            lktable = [((i / 255) ** invGamma) * 255 for i in range(256)]
            lktable = np.array(lktable, np.uint8)
 
            return cv2.LUT(image, lktable)
        # 
        morning = gammaCorrection(img1, 2)
        afternoon = gammaCorrection(img2, 1.5)
        evening = gammaCorrection(img3, 1)
        night = gammaCorrection(img4, 0.5)

        fullday = np.concatenate((morning, afternoon,evening,night),axis=1)
        cv2.imwrite('King Victor Emmanuel II.jpg', fullday)

        #-------------------------------------------------------------------------------------------#
        #---------------Add Text---------------#
        original_img = Image.open('015.jpg')
        img = Image.open('King Victor Emmanuel II.jpg')

        title_font1 = ImageFont.truetype("arial.ttf", 30)
        title_text1 = "VENICE, ITALY"

        title_font2 = ImageFont.truetype("arial.ttf", 20)
        title_text2 = "King Victor Emmanuel II"

        finalimg = ImageDraw.Draw(img)
        finalimg.text((img.width*0.4,img.height*0.84),title_text1,(255,255,255),font=title_font1)
        finalimg.text((img.width*0.4,img.height*0.9),title_text2,(255,255,255),font=title_font2)

        #update
        original_image = ImageTk.PhotoImage(original_img)
        updated_image = ImageTk.PhotoImage(img)     
        wind["OriginalImage"].update(data=original_image)
        wind["UpdatedImage"].update(data=updated_image)
wind.close()