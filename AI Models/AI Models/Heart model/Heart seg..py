import os
import cv2
import numpy as np
import tensorflow as tf
from tensorflow.keras.utils import Sequence
from tensorflow.keras import layers, models
import albumentations as A
from albumentations.core.composition import OneOf

# Enable GPU memory growth
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    try:
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
    except RuntimeError as e:
        print(e)

# Paths
images_train = r"D:\BIG DATA\Models\CT-Heart-segmentation-using-U-NET\CT-Heart\new_data\train\image"
masks_train = r"D:\BIG DATA\Models\CT-Heart-segmentation-using-U-NET\CT-Heart\new_data\train\mask"
images_val = r"D:\BIG DATA\Models\CT-Heart-segmentation-using-U-NET\CT-Heart\new_data\valid\image"
masks_val = r"D:\BIG DATA\Models\CT-Heart-segmentation-using-U-NET\CT-Heart\new_data\valid\mask"

# Data generator with Albumentations
class DataGenerator(Sequence):
    def __init__(self, image_dir, mask_dir, batch_size=4, img_size=(256, 256), augment=False):
        self.image_filenames = sorted(os.listdir(image_dir))
        self.mask_filenames = sorted(os.listdir(mask_dir))
        self.image_paths = [os.path.join(image_dir, fname) for fname in self.image_filenames]
        self.mask_paths = [os.path.join(mask_dir, fname) for fname in self.mask_filenames]
        self.batch_size = batch_size
        self.img_size = img_size
        self.augment = augment

        if len(self.image_paths) != len(self.mask_paths):
            raise ValueError("Image and mask count mismatch.")

        self.on_epoch_end()

        self.augmentations = A.Compose([
            A.HorizontalFlip(p=0.5),
            A.VerticalFlip(p=0.2),
            A.RandomRotate90(p=0.5),
            A.ShiftScaleRotate(shift_limit=0.05, scale_limit=0.05, rotate_limit=15, p=0.5),
            OneOf([
                A.GaussNoise(p=0.5),
                A.Blur(blur_limit=3, p=0.5),
                A.MotionBlur(p=0.5),
            ], p=0.3),
        ])

    def __len__(self):
        return int(np.floor(len(self.image_paths) / self.batch_size))

    def on_epoch_end(self):
        combined = list(zip(self.image_paths, self.mask_paths))
        np.random.shuffle(combined)
        self.image_paths, self.mask_paths = zip(*combined)

    def __getitem__(self, index):
        batch_images = self.image_paths[index * self.batch_size:(index + 1) * self.batch_size]
        batch_masks = self.mask_paths[index * self.batch_size:(index + 1) * self.batch_size]

        images, masks = [], []

        for img_path, mask_path in zip(batch_images, batch_masks):
            img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
            mask = cv2.imread(mask_path, cv2.IMREAD_GRAYSCALE)
            if img is None or mask is None:
                continue

            img = cv2.resize(img, self.img_size)
            mask = cv2.resize(mask, self.img_size)

            if self.augment:
                augmented = self.augmentations(image=img, mask=mask)
                img = augmented['image']
                mask = augmented['mask']

            images.append(np.expand_dims(img, axis=-1) / 255.0)
            masks.append(np.expand_dims(mask, axis=-1) / 255.0)

        return np.array(images, dtype=np.float32), np.array(masks, dtype=np.float32)

# U-Net model
def unet_model(input_size=(256, 256, 1)):
    inputs = tf.keras.Input(input_size)

    # Downsampling
    c1 = layers.Conv2D(64, 3, activation='relu', padding='same')(inputs)
    c1 = layers.Conv2D(64, 3, activation='relu', padding='same')(c1)
    p1 = layers.MaxPooling2D((2, 2))(c1)

    c2 = layers.Conv2D(128, 3, activation='relu', padding='same')(p1)
    c2 = layers.Conv2D(128, 3, activation='relu', padding='same')(c2)
    p2 = layers.MaxPooling2D((2, 2))(c2)

    c3 = layers.Conv2D(256, 3, activation='relu', padding='same')(p2)
    c3 = layers.Conv2D(256, 3, activation='relu', padding='same')(c3)
    p3 = layers.MaxPooling2D((2, 2))(c3)

    c4 = layers.Conv2D(512, 3, activation='relu', padding='same')(p3)
    c4 = layers.Conv2D(512, 3, activation='relu', padding='same')(c4)
    p4 = layers.MaxPooling2D(pool_size=(2, 2))(c4)

    # Bottleneck
    c5 = layers.Conv2D(1024, 3, activation='relu', padding='same')(p4)
    c5 = layers.Conv2D(1024, 3, activation='relu', padding='same')(c5)

    # Upsampling
    u6 = layers.UpSampling2D((2, 2))(c5)
    u6 = layers.Concatenate()([u6, c4])
    c6 = layers.Conv2D(512, 3, activation='relu', padding='same')(u6)
    c6 = layers.Conv2D(512, 3, activation='relu', padding='same')(c6)

    u7 = layers.UpSampling2D((2, 2))(c6)
    u7 = layers.Concatenate()([u7, c3])
    c7 = layers.Conv2D(256, 3, activation='relu', padding='same')(u7)
    c7 = layers.Conv2D(256, 3, activation='relu', padding='same')(c7)

    u8 = layers.UpSampling2D((2, 2))(c7)
    u8 = layers.Concatenate()([u8, c2])
    c8 = layers.Conv2D(128, 3, activation='relu', padding='same')(u8)
    c8 = layers.Conv2D(128, 3, activation='relu', padding='same')(c8)

    u9 = layers.UpSampling2D((2, 2))(c8)
    u9 = layers.Concatenate()([u9, c1])
    c9 = layers.Conv2D(64, 3, activation='relu', padding='same')(u9)
    c9 = layers.Conv2D(64, 3, activation='relu', padding='same')(c9)

    outputs = layers.Conv2D(1, 1, activation='sigmoid')(c9)

    model = models.Model(inputs=[inputs], outputs=[outputs])
    return model

# Initialize data generators
train_gen = DataGenerator(images_train, masks_train, batch_size=4, augment=True)
val_gen = DataGenerator(images_val, masks_val, batch_size=4, augment=False)

# Compile model
model = unet_model()
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# Train model
history = model.fit(
    train_gen,
    validation_data=val_gen,
    epochs=10,
    verbose=1
)
model.save("D:unet_heart_segmentation_modelkkkkk.h5")
