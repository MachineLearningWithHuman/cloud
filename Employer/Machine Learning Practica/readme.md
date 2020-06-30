<h1> How Google Uses Machine Leraning in their production </h1>

<li>Image Classification</li>
<li>Fairness in Perspective API</li>

<h2>Image Classification</h2>
<h3>Basic Classification Model</h3>
<h2>Introducing Convolutional Neural Networks</h2>
<p>A breakthrough in building models for image classification came with the discovery that a convolutional neural network (CNN) could be used to progressively extract higher- and higher-level representations of the image content. Instead of preprocessing the data to derive features like textures and shapes, a CNN takes just the image's raw pixel data as input and "learns" how to extract these features, and ultimately infer what object they constitute.

To start, the CNN receives an input feature map: a three-dimensional matrix where the size of the first two dimensions corresponds to the length and width of the images in pixels. The size of the third dimension is 3 (corresponding to the 3 channels of a color image: red, green, and blue). The CNN comprises a stack of modules, each of which performs three operations.</p>
<li>Convolution</li>
<li>ReLU</li>
<li>Pooling</li>

<h2>Fully Connected Layers</h2>
<p>At the end of a convolutional neural network are one or more fully connected layers (when two layers are "fully connected," every node in the first layer is connected to every node in the second layer). Their job is to perform classification based on the features extracted by the convolutions. Typically, the final fully connected layer contains a softmax activation function, which outputs a probability value from 0 to 1 for each of the classification labels the model is trying to predict.</p>

<h3>Introduction of Regularization </h3>
As with any machine learning model, a key concern when training a convolutional neural network is overfitting: a model so tuned to the specifics of the training data that it is unable to generalize to new examples. Two techniques to prevent overfitting when building a CNN are:

<b>Data augmentation:</b> artificially boosting the diversity and number of training examples by performing random transformations to existing images to create a set of new variants (see Figure 7). Data augmentation is especially useful when the original training data set is relatively small.
<b>Dropout regularization:</b> Randomly removing units from the neural network during a training gradient step.

<h3>Leveraging Pretrained Models</h3>
Training a convolutional neural network to perform image classification tasks typically requires an extremely large amount of training data, and can be very time-consuming, taking days or even weeks to complete. But what if you could leverage existing image models trained on enormous datasets, such as Inception, and adapt them for use in your own classification tasks?

One common technique for leveraging pretrained models is feature extraction: retrieving intermediate representations produced by the pretrained model, and then feeding these representations into a new model as input. For example, if you're training an image-classification model to distinguish different types of vegetables, you could feed training images of carrots, celery, and so on, into a pretrained model, and then extract the features from its final convolution layer, which capture all the information the model has learned about the images' higher-level attributes: color, texture, shape, etc. Then, when building your new classification model, instead of starting with raw pixels, you can use these extracted features as input, and add your fully connected classification layers on top. To increase performance when using feature extraction with a pretrained model, engineers often fine-tune the weight parameters applied to the extracted features.
