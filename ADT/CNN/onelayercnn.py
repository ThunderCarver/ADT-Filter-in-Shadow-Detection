import numpy as np
import keras
import matplotlib.pyplot as plt
from scipy.io import loadmat, savemat
from keras import Sequential
from keras.layers import Conv1D, MaxPooling1D, Flatten, Dense, Dropout
from keras.utils import to_categorical

for i in range(1,8):
    # read data
    num_classes = 2
    data = loadmat('/Users/xxx/Documents/MATLAB/ADT/cross validation/'+str(i)+'/Ttraindata.mat',)
    x_train = data['Ttraindata']
    y_train = data['TtrainLabel']
    testdata = loadmat('/Users/xxx/Documents/MATLAB/ADT/cross validation/1/Ttestdata.mat')
    x_test = testdata['Ttestdata']
    y_test = testdata['TtestLabel']

    x_train = x_train.reshape(x_train.shape[0],x_train.shape[1],1)
    x_test = x_test.reshape(x_test.shape[0],x_test.shape[1],1)
    # one-hot encode label  0->nonshadow 1->shadow
    y_train[np.where(y_train==-1)]=0
    y_test[np.where(y_test==-1)]=0
    y_train=to_categorical(y_train,2)
    y_test=to_categorical(y_test,2)


    # configure the cnn
    model = Sequential()
    model.add(Conv1D(filters=4, kernel_size=3, strides=1, activation='relu', input_shape=(36,1)))
    model.add(MaxPooling1D(pool_size=2))
    model.add(Flatten())
    model.add(Dense(50, activation='relu'))
    # model.add(Dense(10,activation='relu'))
    model.add(Dense(num_classes, activation='softmax'))
    model.compile(loss='mse',optimizer=keras.optimizers.SGD(lr=0.01), metrics=['accuracy'])
    # train the cnn
    # batch_size 每次梯度更新的样本数。未指定，默认为32
    # epochs 训练模型迭代次数
    # verbose 日志展示 0:为不在标准输出流输出日志信息 1:显示进度条 2:每个epoch输出一行记录
    # shuffle 布尔值 是否在每轮迭代之前混洗数据
    # validation_split 浮点数0-1之间 用作验证集的训练数据的比例。验证数据是混洗之前x和y数据的最后一部分样本中。
    # validation_data 元组 (x_val，y_val) 或元组 (x_val，y_val，val_sample_weights)，用来评估损失，以及在每轮结束时的任何模型度量指标。模型将不会在这个数据上进行训练。这个参数会覆盖 validation_split。

    # model.fit(x_train, y_train, batch_size=108, epochs=10, verbose=2,validation_data=(x_test, y_test))
    # model.save('./5010/ADTcnn1.h5')

    model.fit(x_train, y_train, batch_size=108, epochs=10, verbose=2,validation_data=(x_train, y_train))
    [testloss, testacc] = model.evaluate(x_train,y_train)
    print("Evaluation result on Test Data : Loss = {}, accuracy = {}".format(testloss, testacc))
    model.save('./50/ADTcnn'+str(i)+'.h5')
'''
[testloss, testacc] = model.evaluate(x_test,y_test)
print("Evaluation result on Test Data : Loss = {}, accuracy = {}".format(testloss, testacc))
# predict output probabilities -> predict
# predict output class -> predict_classes
pre = model.predict_classes(x_test)
savemat("./5010/pre7.mat",{'predictedclass':np.array(pre)})
'''

# load model
# model.load_weights('ADTcnn.h5')
# 在Keras中记录网络性能
'''
class AccuracyHistory(keras.callbacks.Callback):
    def on_train_begin(self, logs={}):
        self.acc = []
    def on_epoch_end(self, batch, logs={}):
        self.acc.append(logs.get('acc'))
'''
# history = AccuracyHistory() # 要访问我们在训练完成后创建的准确性列表，你可以简单地调用history.acc：
# model.fit(x_train, y_train,
#           batch_size=batch_size,
#           epochs=epochs,
#           verbose=1,validation_data=(x_test, y_test),callbacks=[history])



# plt.plot(range(1,11), history.acc)
# plt.xlabel('Epochs')
# plt.ylabel('Accuracy')
# plt.show()