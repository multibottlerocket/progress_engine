import Image, os
images = os.listdir('C:/Users/Jon/Pictures/riotcaptcha/pureletters/')
os.chdir('C:/Users/Jon/Pictures/riotcaptcha/')

def removeNoise(imgName):
    
    im = Image.open('pureletters/'+imgName)

    imArray = im.load()

    (width, height) = im.size
    for x in range(width):
        for y in range(height):
            if (imArray[x,y] == (227, 218, 237)):
                imArray[x,y] = (255,255,255)
            elif (imArray[x,y] == (128, 191, 255)):
                imArray[x,y] = (255,255,255)
            elif (imArray[x,y] == (128, 128, 255)):
                imArray[x,y] = (255,255,255)
            else:
                pass

    return im.save('processed/'+imgName)

def convertBW(imgName):
    im = Image.open('processed/'+imgName)
    imArray = im.load()

    (width, height) = im.size
    for x in range(width):
        for y in range(height):
            bwValue = ((imArray[x,y][0] * 299 / 1000) + (imArray[x,y][1] *
                            587 / 1000) + (imArray[x,y][1] * 114 / 1000))
            imArray[x,y] = (bwValue, bwValue, bwValue)

    return im.save('bw/'+imgName)

def convertBinary(imgName):
    im = Image.open('processed/'+imgName)

    imArray = im.load()

    (width, height) = im.size
    for x in range(width):
        for y in range(height):
            if (imArray[x,y] == (255, 255, 255)):
                pass
            else:
                imArray[x,y] = (0, 0, 0)

    return im.save('binary/'+imgName)
    
for item in images:
    convertBinary(item)

