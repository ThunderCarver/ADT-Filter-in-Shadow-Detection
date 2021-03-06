import numpy as np
from keras.models import Model
from keras.models import load_model
import matplotlib.pyplot as plt
from scipy.io import loadmat, savemat

data = loadmat('/Documents/ADT-Filter-in-Shadow-Detection/ADT/CNN/sample.mat')
x = data['instance']
x = x.reshape(x.shape[0],x.shape[1],1)
model = load_model('./5010/ADTcnn7.h5')
model.summary()
prediectedclass = model.predict_classes(x)
savemat('/Documents/ADT-Filter-in-Shadow-Detection/ADT/CNN/predictsample.mat',{'predictedclass':np.array(prediectedclass)})
