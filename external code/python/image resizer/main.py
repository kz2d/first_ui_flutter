from os import listdir
from os.path import isfile, join
import os
from PIL import Image

onlyfiles = [f for f in listdir('./images') if isfile(join('./images', f))]
print(len(onlyfiles))

count=0
constants=[(400,600),(1080,1080/9*14)]

for file in onlyfiles:
    im = Image.open('images/'+file) 
    print(im.size)

    newsize = min(im.size[0]/constants[0][0],im.size[1]/constants[0][1])

    print(newsize)
    newsize=(int(im.size[0]/newsize), int(im.size[1]/newsize))
    print(newsize)
    im1 = im.resize(newsize)

    os.mkdir(f'output/{count}')

    im1.save(f'output/{count}/image{count}-400-600.jpg')


    newsize = min(im.size[0]/constants[1][0],im.size[1]/constants[1][1])

    print(newsize)
    newsize=(int(im.size[0]/newsize), int(im.size[1]/newsize))
    print(newsize)
    im2 = im.resize(newsize)
    print(newsize)

    im2.save(f'output/{count}/image{count}-1080-1680.jpg')

    im.save(f'output/{count}/image{count}-original.jpg')

    count+=1