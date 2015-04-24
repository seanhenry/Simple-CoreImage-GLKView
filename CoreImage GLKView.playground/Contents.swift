// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import GLKit
import CoreImage
import XCPlayground

class MyGLKView: GLKView {
    
    var image: CIImage?
    var ciContext: CIContext?
    
    override func drawRect(rect: CGRect) {
        if let image = self.image {
            // OpenGLES draws in pixels, not points so we scale to whatever the contents scale is.
            let scale = CGAffineTransformMakeScale(self.contentScaleFactor, self.contentScaleFactor)
            let drawingRect = CGRectApplyAffineTransform(rect, scale)
            // The image.extent() is the bounds of the image.
            self.ciContext?.drawImage(image, inRect: drawingRect, fromRect: image.extent())
        }
    }
    
}

// Create an image
let imageURL = NSBundle.mainBundle().URLForResource("pulsar-logo", withExtension: "jpg")
let image = CIImage(contentsOfURL: imageURL)

// Create a GLKView
let eaglContext = EAGLContext(API: .OpenGLES2)
let view = MyGLKView(frame: CGRectMake(0, 0, 128, 128), context: eaglContext)
view.ciContext = CIContext(EAGLContext: eaglContext)
view.image = image

// Tell the GLKView to draw
view.setNeedsDisplay()

// Tell playground to show the view
XCPShowView("MyGLKView", view)
