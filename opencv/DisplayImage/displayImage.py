import cv2   
      
img = cv2.imread("/home/huashuolee/data/tmp/test_fps/pic/output-124.png")   
cv2.namedWindow("Image")   
cv2.imshow("Image", img)   
cv2.waitKey (0)  
cv2.destroyAllWindows()  
