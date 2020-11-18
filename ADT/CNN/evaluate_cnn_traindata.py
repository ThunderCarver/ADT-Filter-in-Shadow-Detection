import numpy as np
import keras
import matplotlib.pyplot as plt
from scipy.io import loadmat, savemat
from keras.models import load_model
from keras import Sequential
from keras.layers import Conv1D, MaxPooling1D, Flatten, Dense, Dropout
from keras.utils import to_categorical


num_classes = 2
data = loadmat('/Documents/ADT-Fliter-in-Shadow-Detection/ADT/cross validation/1/Ttraindata.mat')
x_train = data['Ttraindata']
y_train = data['TtrainLabel']
x_train = x_train.reshape(x_train.shape[0],x_train.shape[1],1)
y_train[np.where(y_train==-1)]=0
y_train=to_categorical(y_train,2)

model = load_model('./5010/ADTcnn1.h5')

[loss, acc] = model.evaluate(x_train, y_train)
print("Evaluation result on Test Data : Loss = {}, accuracy = {}".format(loss, acc))
