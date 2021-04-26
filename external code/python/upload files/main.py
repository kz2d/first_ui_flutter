from firebase_admin import firestore
from firebase_admin import credentials
from firebase_admin import storage
import firebase_admin
from os import listdir
from os.path import isfile, join
import os
import numpy as np
from PIL import Image
import random
import string
import uuid
import datetime
import hashlib

onlyfolders = [f for f in listdir('./images')]
print(len(onlyfolders))


# Use the application default credentials
cred = credentials.Certificate(
    './flutter-test-42648-firebase-adminsdk-62hix-4fc6ed0a3e.json')
firebase_admin.initialize_app(cred, {
    'storageBucket': 'flutter-test-42648.appspot.com'
})

db = firestore.client()


doc_ref = db.collection(u'images')


bucket = storage.bucket()

count = 0
#onlyfolders = [onlyfolders[0]]

for folder in onlyfolders:

    image=Image.open(
        f'images/{folder}/image{folder}-original.jpg')

    color = np.asarray(image.resize((1, 1)), dtype='f')
    color = color[0, 0, 0]*16*16*16*16+color[0, 0, 1]*16*16+color[0, 0, 2]+4278190080
    color = int(color)

    md5hash = hashlib.md5(image.tobytes())

    creator = random.choice([db.collection(u'users').document('Lfh5HtQzz0Mhe2iTnGNc'),
                            db.collection(u'users').document('Oxc8ntPjl9wDkfDCxHBk'),
                             db.collection(u'users').document('ZztsXug2AALWZqX8W69F')])

    # random_string = ''.join(
    #     (random.choice(string.ascii_lowercase) for x in range(10)))
    blob = bucket.blob(f'posted_images/{md5hash.hexdigest()}/400.jpg')
    blob.upload_from_filename(f'images/{folder}/image{folder}-400-600.jpg')
    metadata = {'firebaseStorageDownloadTokens': uuid.uuid4()}
    blob.metadata = metadata
    blob.patch()
    blob = bucket.blob(f'posted_images/{md5hash.hexdigest()}/1080.jpg')
    blob.upload_from_filename(f'images/{folder}/image{folder}-1080-1680.jpg')
    blob.metadata = metadata
    blob.patch()
    blob = bucket.blob(f'posted_images/{md5hash.hexdigest()}/original.jpg')
    blob.upload_from_filename(f'images/{folder}/image{folder}-original.jpg')
    blob.metadata = metadata
    blob.patch()

    doc_ref.document(md5hash.hexdigest()).set({
        u'smallResURL': f"https://firebasestorage.googleapis.com/v0/b/flutter-test-42648.appspot.com/o/posted_images%2F{md5hash.hexdigest()}%2F400.jpg?alt=media&token={metadata['firebaseStorageDownloadTokens']}",
        u'bigResURL': f"https://firebasestorage.googleapis.com/v0/b/flutter-test-42648.appspot.com/o/posted_images%2F{md5hash.hexdigest()}%2F1080.jpg?alt=media&token={metadata['firebaseStorageDownloadTokens']}",
        u'originalURL': f"https://firebasestorage.googleapis.com/v0/b/flutter-test-42648.appspot.com/o/posted_images%2F{md5hash.hexdigest()}%2Foriginal.jpg?alt=media&token={metadata['firebaseStorageDownloadTokens']}",
        u'color': color,
        u'creator': creator,
        u'downloads': 0,
        u'likes': 0,
        u'published at': datetime.datetime.now(),
        u'views': 0,
        u'md5':blob.md5_hash
    })

    print(
        "Blob downloaded to "+f"{bucket.name}"
    )
