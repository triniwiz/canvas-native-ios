import UIKit
import CanvasNative
@available(iOS 13.0, *)
class ViewController: UIViewController {
    var canvas1: Canvas?
    var canvas2: Canvas?
    var imageView: UIImageView?
    let PI: Float = .pi
    let TWO_PI: Float = .pi * 2
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var second: UIView!
    @IBOutlet weak var third: UIView!
    var tapped = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        scale = Int(UIScreen.main.scale)
        // Do any additional setup after loading the view.
        canvas1 = Canvas(frame: first.bounds, useGL: true)
        first.addSubview(canvas1!)
        //let matrix = Canvas.createSVGMatrix()
        //matrix.a = 3.0
    }
    
    var drawn = false
    var count = 0
    
    var vertexShaderSource = """
        void main() {
            gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
            gl_PointSize = 256.0;
        }
    """
    var fragmentShaderSource = """
        precision mediump float;
            void main() {
                vec2 fragmentPosition = 2.0*gl_PointCoord - 1.0;
                float distance = length(fragmentPosition);
                float distanceSqrd = distance * distance;
                gl_FragColor = vec4(
                    0.2/distanceSqrd,
                    0.1/distanceSqrd,
                    0.0, 1.0 );
                }
    """
    
    
    
    var vertCode = """
    attribute vec3 position;
    uniform mat4 Pmatrix;
    uniform mat4 Vmatrix;
    uniform mat4 Mmatrix;
    attribute vec3 color;
    varying vec3 vColor;
    void main() {
    gl_Position = Pmatrix*Vmatrix*Mmatrix*vec4(position, 1.0);
    vColor = color;
    }
    """
    
    var fragCode = """
    precision mediump float;
    varying vec3 vColor;
    void main() {
    gl_FragColor = vec4(vColor, 1.0);
    }
    """
    var buffer: UInt32?
    var gl: WebGLRenderingContext?
    var program : UInt32?
    func initializeAttributes(gl: WebGLRenderingContext?) {
        gl!.enableVertexAttribArray(index: 0)
        buffer = gl!.createBuffer()
        gl!.bindBuffer(target: gl!.ARRAY_BUFFER, buffer: buffer!)
        let data: [Float] = [0.0, 0.0]
        gl!.bufferData(target: gl!.ARRAY_BUFFER, floatArray: data, usage: gl!.STATIC_DRAW)
        gl!.vertexAttribPointer(index: 0, size: 2, type: gl!.FLOAT, normalized: false, stride: 0, offset: 0);
    }
    
    func cleanup(gl: WebGLRenderingContext?){
        gl!.useProgram(program: 0)
        if (buffer != nil){
            gl!.deleteBuffer(buffer: buffer!)
        }
        if (program != nil){
            gl!.deleteProgram(program: program!)
        }
        
    }
    
    
    
    
    func drawGL(canvas: Canvas){
        var gl = canvas.getContext(type: "webgl") as! WebGLRenderingContext
        gl.viewport(x: 0, y: 0,
        width: gl.drawingBufferWidth, height: gl.drawingBufferHeight)
        
        let vertexShader = gl.createShader(type: gl.VERTEX_SHADER)
        gl.shaderSource(shader: vertexShader,source: vertexShaderSource)
        gl.compileShader(shader: vertexShader)
        let fragmentShader = gl.createShader(type: gl.FRAGMENT_SHADER)
        gl.shaderSource(shader: fragmentShader,source: fragmentShaderSource)
        gl.compileShader(shader: fragmentShader)
        let program = gl.createProgram()
        gl.attachShader(program: program, shader: vertexShader)
        gl.attachShader(program: program, shader: fragmentShader)
        gl.linkProgram(program: program)
        gl.detachShader(program: program, shader: vertexShader)
        gl.detachShader(program: program, shader: fragmentShader)
        gl.deleteShader(shader: vertexShader)
        gl.deleteShader(shader: fragmentShader)
        
        
        if (!(gl.getProgramParameter(program: program, pname: gl.LINK_STATUS) as! Bool)) {
        let linkErrLog = gl.getProgramInfoLog(program: program)
        print("error", linkErrLog)
            cleanup(gl: gl)
        }
        
        initializeAttributes(gl: gl)
        gl.useProgram(program: program)
        gl.drawArrays(mode: gl.POINTS, first: 0, count: 1)
        cleanup(gl: gl)
        canvas1?.flush()
    }
    
    func clearExample(ctx: CanvasRenderingContext2D) {
        ctx.beginPath()
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromString: "#ff6"))
        ctx.fillRect(x: 0, y: 0, width: canvas1!.width, height: canvas1!.height)

        // Draw blue triangle
        ctx.beginPath();
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromString: "blue"))
        ctx.moveTo(x: 20, y: 20)
        ctx.lineTo(x: 180, y: 20)
        ctx.lineTo(x: 130, y: 130)
        ctx.closePath()
        ctx.fill()

        // Clear part of the canvas
        ctx.clearRect(x: 10, y: 10, width: 120, height: 100)
    }
    
    
    func drawAll() {
     // gl = (canvas1?.getContext(type: "webgl")  as! WebGLRenderingContext)
       // canvas1?.handleInvalidationManually = true
        
       // drawPoints(canvas: canvas1!)
        
      //  drawRotatingCube(gl: gl!)
        
       // drawRotatingCube(gl: gl!)
       
     // drawGL(canvas: canvas1!) // sun
        
       // drawTextures(canvas: canvas1!)
        
       // canvas1?.handleInvalidationManually = true
        
       // drawPoints(canvas: canvas1!)
      // canvas1?.handleInvalidationManually = true
        let ctx = canvas1?.getContext(type: "2d") as! CanvasRenderingContext2D
       // clearExample(ctx: ctx)
        //drawImageExample(ctx: ctx)
       // canvas1?.flush()
      //  drawImageBlock(ctx: ctx)
        //  doSolarAnimation(ctx: ctx)
         // drawFace(ctx: ctx)
        // fontExample(ctx: ctx)
        //arcToAnimationExample(ctx: ctx)
        //  saveRestoreExample(ctx: ctx)
        //ballExample(ctx: ctx)
        
        //ctx.fillRect(x: 200, y: 10, width: 200, height: 200);
        // scaleTransformation(ctx: ctx)
        particleAnimation(ctx: ctx)
        //        canvas1!.toDataURLAsync { (data) in
        //           print("data: ", data)
        //        }
    }
    
    var vertCode2 = """
                   attribute vec3 coordinates;
                       void main() {
                       gl_Position = vec4(coordinates, 1.0);
                       gl_PointSize = 10.0;
       }
"""
    
    var fragCode2 = """
    void main() {
       gl_FragColor = vec4(0.0, 0.0, 0.0, 0.1);
    }
"""
    
    func drawPoints(canvas: Canvas){
        let gl = canvas.getContext(type: "webgl") as! WebGLRenderingContext

                /*==========Defining and storing the geometry=======*/

        let vertices: [Float] = [
                   -0.5,0.5,0.0,
                   0.0,0.5,0.0,
                   -0.25,0.25,0.0,
                ]

                // Create an empty buffer object to store the vertex buffer
        let vertex_buffer = gl.createBuffer();
     

                //Bind appropriate array buffer to it
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: vertex_buffer);
        

                // Pass the vertex data to the buffer
        gl.bufferData(target: gl.ARRAY_BUFFER, floatArray: vertices, usage: gl.STATIC_DRAW);

                // Unbind the buffer
       gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: 0)

                /*=========================Shaders========================*/

                // vertex shader source code
           

                // Create a vertex shader object
        let vertShader = gl.createShader(type: gl.VERTEX_SHADER);
                
                // Attach vertex shader source code
        gl.shaderSource(shader: vertShader, source: vertCode2);

                // Compile the vertex shader
        gl.compileShader(shader: vertShader);

                // fragment shader source code
                

                // Create fragment shader object
        let fragShader = gl.createShader(type: gl.FRAGMENT_SHADER);

                // Attach fragment shader source code
        gl.shaderSource(shader: fragShader, source: fragCode2);

                // Compile the fragmentt shader
        gl.compileShader(shader: fragShader);
                
                // Create a shader program object to store
                // the combined shader program
        let shaderProgram = gl.createProgram();

                // Attach a vertex shader
        gl.attachShader(program: shaderProgram, shader: vertShader);

                // Attach a fragment shader
        gl.attachShader(program: shaderProgram, shader: fragShader);

                // Link both programs
        gl.linkProgram(program: shaderProgram);
        
        
        let linked = gl.getProgramParameter(program: shaderProgram, pname: gl.LINK_STATUS) as! Bool
               if (!linked) {
                 // something went wrong with the link
                   let lastError = gl.getProgramInfoLog(program: shaderProgram);
                 print("Error in program linking:" + lastError);

                   gl.deleteProgram(program: shaderProgram);
                 return
               }

                // Use the combined shader program object
        gl.useProgram(program: shaderProgram);

                /*======== Associating shaders to buffer objects ========*/

                // Bind vertex buffer object
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: vertex_buffer);

                // Get the attribute location
        let coord = gl.getAttribLocation(program: shaderProgram, name: "coordinates");
                // Point an attribute to the currently bound VBO
        gl.vertexAttribPointer(index: coord, size: 3, type: gl.FLOAT, normalized: false, stride: 0, offset: 0);

                // Enable the attribute
        gl.enableVertexAttribArray(index: coord);

                /*============= Drawing the primitive ===============*/

                // Clear the canvas
        gl.clearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.9);

                // Enable the depth test
        gl.enable(cap: gl.DEPTH_TEST);
        
                // Clear the color buffer bit
        gl.clear(mask: UInt32(gl.COLOR_BUFFER_BIT));
   
                // Set the view port
        gl.viewport(x: 0,y: 0,width: Int32(canvas.width),height: Int32(canvas.height));

                // Draw the triangle
        gl.drawArrays(mode: gl.POINTS, first: 0, count: 3);
        canvas1?.flush()
    }
    
    
    
    func drawTextures(canvas: Canvas) {
        let gl = canvas.getContext(type: "webgl") as! WebGLRenderingContext
    
        let vertexShaderSrc = """
      attribute vec2 a_position;
      uniform vec2 u_resolution;
      void main() {
         vec2 zeroToOne = a_position / u_resolution;
         vec2 zeroToTwo = zeroToOne * 2.0;
         vec2 clipSpace = zeroToTwo - 1.0;
         gl_Position = vec4(clipSpace * vec2(1, -1), 0, 1);
        }
    """

        let fragmentShaderSrc = """
         precision mediump float;
         uniform vec4 u_color;
         void main() {
            gl_FragColor = u_color;
         }
         """

        // setup GLSL program

        let vertexShader = gl.createShader(type: gl.VERTEX_SHADER);
        gl.shaderSource(shader: vertexShader, source: vertexShaderSrc);
        gl.compileShader(shader: vertexShader);

        var compiled = gl.getShaderParameter(shader: vertexShader, pname: gl.COMPILE_STATUS) as! Bool
        if (!compiled) {
          // Something went wrong during compilation; get the error
            let lastError = gl.getShaderInfoLog(shader: vertexShader);
          print(
            "*** Error compiling vertexShader ", vertexShader, ":" , lastError
          )
            gl.deleteShader(shader: vertexShader)
          return
        }

        let fragmentShader = gl.createShader(type: gl.FRAGMENT_SHADER);
        gl.shaderSource(shader: fragmentShader, source: fragmentShaderSrc);
        gl.compileShader(shader: fragmentShader);

        compiled = gl.getShaderParameter(shader: fragmentShader, pname: gl.COMPILE_STATUS) as! Bool
        if (!compiled) {
          // Something went wrong during compilation; get the error
            let lastError = gl.getShaderInfoLog(shader: fragmentShader);
          print(
            "*** Error compiling fragmentShader ",
              fragmentShader,
              ":",
              lastError
          );
            gl.deleteShader(shader: fragmentShader);
          return;
        }

        let program = gl.createProgram();

        gl.attachShader(program: program, shader: vertexShader);
        gl.attachShader(program: program, shader: fragmentShader);
        gl.linkProgram(program: program);

        // Check the link status
        let linked = gl.getProgramParameter(program: program, pname: gl.LINK_STATUS) as! Bool
        if (!linked) {
          // something went wrong with the link
            let lastError = gl.getProgramInfoLog(program: program);
          print("Error in program linking:" + lastError);

            gl.deleteProgram(program: program);
          return
        }

        // look up where the vertex data needs to go.
        let positionAttributeLocation = gl.getAttribLocation(program: program, name: "a_position");

        // look up uniform locations
        let resolutionUniformLocation = gl.getUniformLocation(
            program: program,
            name: "u_resolution"
        );
   
        let colorUniformLocation = gl.getUniformLocation(program: program, name: "u_color");

        // Create a buffer to put three 2d clip space points in
        let positionBuffer = gl.createBuffer();

        // Bind it to ARRAY_BUFFER (think of it as ARRAY_BUFFER = positionBuffer)
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: positionBuffer);

        print(gl.drawingBufferWidth, gl.drawingBufferHeight)
        // Tell WebGL how to convert from clip space to pixels
        gl.viewport(x: 0, y: 0, width: gl.drawingBufferWidth, height: gl.drawingBufferHeight);

        // Clear the canvas
        gl.clearColor(red: 1, green: 1, blue: 1, alpha: 1);
        gl.clear(mask: UInt32(gl.COLOR_BUFFER_BIT));

        // Tell it to use our program (pair of shaders)
        gl.useProgram(program: program);

        // Bind the position buffer.
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: positionBuffer);

        // create the buffer
        let indexBuffer = gl.createBuffer();
  

        // make this buffer the current 'ELEMENT_ARRAY_BUFFER'
        gl.bindBuffer(target: gl.ELEMENT_ARRAY_BUFFER, buffer: indexBuffer);

        // Fill the current element array buffer with data
        let indices: [UInt16] = [
          0,
          1,
          2, // first triangle
          2,
          1,
          3, // second triangle
        ]
        
        gl.bufferData(
            target: gl.ELEMENT_ARRAY_BUFFER,
            shortArray: indices,
            usage: gl.STATIC_DRAW
        )

        // code above this line is initialization code
        // --------------------------------
        // code below this line is rendering code

        // Turn on the attribute
        gl.enableVertexAttribArray(index: positionAttributeLocation);

        // Tell the attribute how to get data out of positionBuffer (ARRAY_BUFFER)
        var size = 2; // 2 components per iteration
        var type = gl.FLOAT; // the data is 32bit floats
        var normalize = false; // don't normalize the data
        var stride = 0; // 0 = move forward size * sizeof(type) each iteration to get the next position
        var offset = 0; // start at the beginning of the buffer
        
        gl.vertexAttribPointer(
            index: positionAttributeLocation,
            size: Int32(size),
            type: type,
            normalized: normalize,
            stride: Int32(stride),
            offset: offset
        );

        // bind the buffer containing the indices
        gl.bindBuffer(target: gl.ELEMENT_ARRAY_BUFFER, buffer: indexBuffer);

        // set the resolution
        gl.uniform2f(
            location: resolutionUniformLocation,
            v0: Float(gl.drawingBufferWidth),
            v1: Float(gl.drawingBufferHeight)
        );

        // draw 50 random rectangles in random colors
        for i in 0 ... 50 {
            // Setup a random rectangle
            // This will write to positionBuffer because
            // its the last thing we bound on the ARRAY_BUFFER
            // bind point
            setRectangle(
                gl: gl,
                x: randomInt(range: 300),
                y: randomInt(range: 300),
                width: randomInt(range: 300),
                height: randomInt(range: 300)
            );

            // Set a random color.
            gl.uniform4f(
                location: colorUniformLocation,
                v0: Float.random(in: 0 ... 1),
                v1: Float.random(in: 0 ... 1),
                v2: Float.random(in: 0 ... 1),
                v3: 1
            );

            // Draw the rectangle.
            let primitiveType = gl.TRIANGLES
            let offset = 0
            let count = 6
            let indexType = gl.UNSIGNED_SHORT
            gl.drawElements(mode: primitiveType, count: Int32(count), type: indexType, offset: Int32(offset));
        }
     
        canvas.flush()
      }

      // Returns a random integer from 0 to range - 1.
    func randomInt(range: Float) -> Float{
        return floor(Float.random(in: -1 ... 0) * range)
      }

      // Fill the buffer with the values that define a rectangle.
    func setRectangle(gl: WebGLRenderingContext, x: Float, y: Float, width: Float, height: Float) {
        let x1 = x;
        let x2 = x + width;
        let y1 = y;
        let y2 = y + height;
        gl.bufferData(
            target: gl.ARRAY_BUFFER,
            floatArray: [x1, y1, x2, y1, x1, y2, x2, y2],
            usage: gl.STATIC_DRAW
        );
      }

    
    
    
    func drawRotatingCube(gl: WebGLRenderingContext){
        let width = gl.getCanvas().width
        let height = gl.getCanvas().height
        let vertices: [Float] = [
            -1,-1,-1, 1,-1,-1, 1, 1,-1, -1, 1,-1,
            -1,-1, 1, 1,-1, 1, 1, 1, 1, -1, 1, 1,
            -1,-1,-1, -1, 1,-1, -1, 1, 1, -1,-1, 1,
            1,-1,-1, 1, 1,-1, 1, 1, 1, 1,-1, 1,
            -1,-1,-1, -1,-1, 1, 1,-1, 1, 1,-1,-1,
            -1, 1,-1, -1, 1, 1, 1, 1, 1, 1, 1,-1,
        ]
        let colors: [Float] = [
            5,3,7, 5,3,7, 5,3,7, 5,3,7,
            1,1,3, 1,1,3, 1,1,3, 1,1,3,
            0,0,1, 0,0,1, 0,0,1, 0,0,1,
            1,0,0, 1,0,0, 1,0,0, 1,0,0,
            1,1,0, 1,1,0, 1,1,0, 1,1,0,
            0,1,0, 0,1,0, 0,1,0, 0,1,0
        ]
        
        indices = [
            0,1,2, 0,2,3, 4,5,6, 4,6,7,
            8,9,10, 8,10,11, 12,13,14, 12,14,15,
            16,17,18, 16,18,19, 20,21,22, 20,22,23
        ]
        
        
        
        // Create and store data into vertex buffer
        let vertex_buffer = gl.createBuffer()
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: vertex_buffer)
        gl.bufferData(target: gl.ARRAY_BUFFER, floatArray: vertices, usage: gl.STATIC_DRAW)
        
        // Create and store data into color buffer
        let color_buffer = gl.createBuffer ()
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: color_buffer)
        gl.bufferData(target: gl.ARRAY_BUFFER, floatArray: colors, usage: gl.STATIC_DRAW)
        
        // Create and store data into index buffer
        index_buffer = gl.createBuffer()
        gl.bindBuffer(target: gl.ELEMENT_ARRAY_BUFFER, buffer: index_buffer)
        gl.bufferData(target: gl.ELEMENT_ARRAY_BUFFER, shortArray: indices, usage: gl.STATIC_DRAW)
    
        
        let vertShader = gl.createShader(type: gl.VERTEX_SHADER)
        gl.shaderSource(shader: vertShader, source: vertCode)
        gl.compileShader(shader: vertShader)
        
        
        let fragShader = gl.createShader(type: gl.FRAGMENT_SHADER)
        gl.shaderSource(shader: fragShader, source: fragCode)
        gl.compileShader(shader: fragShader)
        
        
        let shaderProgram = gl.createProgram()
        gl.attachShader(program: shaderProgram, shader: vertShader)
        gl.attachShader(program: shaderProgram, shader: fragShader)
        gl.linkProgram(program: shaderProgram)
        
        /* ====== Associating attributes to vertex shader =====*/
        Pmatrix = gl.getUniformLocation(program: shaderProgram, name: "Pmatrix")
        Vmatrix = gl.getUniformLocation(program: shaderProgram, name: "Vmatrix")
        Mmatrix = gl.getUniformLocation(program: shaderProgram, name: "Mmatrix")

        
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: vertex_buffer)
        let position = gl.getAttribLocation(program: shaderProgram, name: "position")
        gl.vertexAttribPointer(index: position, size: 3, type: gl.FLOAT, normalized: false,stride: 0,offset: 0)
        
        // Position
        gl.enableVertexAttribArray(index: position)
        gl.bindBuffer(target: gl.ARRAY_BUFFER, buffer: color_buffer)
        let color = gl.getAttribLocation(program: shaderProgram, name: "color")
        gl.vertexAttribPointer(index: color, size: 3, type: gl.FLOAT, normalized: false,stride: 0,offset: 0)
        
        // Color
        gl.enableVertexAttribArray(index: color)
        gl.useProgram(program: shaderProgram)
        
        
        proj_matrix = get_projection(angle: 40, a: Int32(width / height), zMin: 1, zMax: 100)
        
        mov_matrix = [1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1]
        view_matrix = [1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1]
        
        // translating z
        view_matrix[14] = view_matrix[14]-6;//zoom
        
          
        cubeRotationAnimation(gl: gl, time: 0)
        
    }
    
    
    
    func cubeRotationAnimation(gl: WebGLRenderingContext,time: Float) {
        let width = gl.drawingBufferWidth
        let height = gl.drawingBufferHeight
        let dt = time - time_old
        rotateZ(m: &mov_matrix, angle: dt*0.005) //time
        rotateY(m: &mov_matrix, angle: dt*0.002)
        rotateX(m: &mov_matrix, angle: dt*0.003)
        time_old = time
        
        gl.enable(cap: gl.DEPTH_TEST)
        gl.depthFunc(fn: gl.LEQUAL)
        gl.clearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
        gl.clearDepth(depth: 1.0)
        gl.viewport(x: 0, y: 0, width: Int32(width), height: Int32(height))
        gl.clear(mask: UInt32(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT))
        gl.uniformMatrix4fv(location: Pmatrix, transpose: false, value: proj_matrix)
        gl.uniformMatrix4fv(location: Vmatrix, transpose: false, value: view_matrix)
        gl.uniformMatrix4fv(location: Mmatrix, transpose: false, value: mov_matrix)
        gl.bindBuffer(target: gl.ELEMENT_ARRAY_BUFFER, buffer: index_buffer)
        gl.drawElements(mode: gl.TRIANGLES, count: Int32(indices.count), type: gl.UNSIGNED_SHORT, offset: 0)
        gl.getCanvas().flush()
        AnimationFrame.requestAnimationFrame { (t) in
            self.cubeRotationAnimation(gl: gl, time: t)
        }
    }
    
    var index_buffer: UInt32 = 0
    var indices: [UInt16] = []
    var Pmatrix: Int32 = 0
    var Vmatrix: Int32 = 0
    var Mmatrix: Int32 = 0
    var proj_matrix: [Float]  = []
    var mov_matrix: [Float] = []
    var view_matrix:[Float] = []
    var time_old: Float = 0
    
    func get_projection(angle: Float, a: Int32, zMin: Int32, zMax: Int32) -> [Float] {
        let ang = tan((angle * Float(0.5)) * PI/180) //angle*.5
        return [
            0.5 / ang, 0.0 , 0.0, 0.0,
            0.0, Float(0.5) * (Float(a)/ang), 0.0, 0.0,
            0.0, 0.0, -(Float(zMax) + Float(zMin)) / (Float(zMax) - Float(zMin)), -1.0,
            0.0, 0.0, (-2 * Float(zMax) * Float(zMin))/(Float(zMax) - Float(zMin)), 0.0
        ];
    }
    
    
    
    func rotateZ(m: inout Array<Float>, angle: Float) {
        let c = cos(angle)
        let s = sin(angle)
        let mv0 = m[0], mv4 = m[4], mv8 = m[8]
        
        m[0] = c*m[0]-s*m[1]
        m[4] = c*m[4]-s*m[5]
        m[8] = c*m[8]-s*m[9]
        
        m[1]=c*m[1]+s*mv0
        m[5]=c*m[5]+s*mv4
        m[9]=c*m[9]+s*mv8
    }
    
    func rotateX(m: inout Array<Float>, angle: Float) {
        let c = cos(angle)
        let s = sin(angle)
        let mv1 = m[1], mv5 = m[5], mv9 = m[9]
        
        m[1] = m[1]*c-m[2]*s
        m[5] = m[5]*c-m[6]*s
        m[9] = m[9]*c-m[10]*s
        
        m[2] = m[2]*c+mv1*s
        m[6] = m[6]*c+mv5*s
        m[10] = m[10]*c+mv9*s
    }
    
    func rotateY(m: inout Array<Float>, angle: Float) {
        let c = cos(angle)
        let s = sin(angle)
        let mv0 = m[0], mv4 = m[4], mv8 = m[8]
        
        m[0] = c*m[0]+s*m[2]
        m[4] = c*m[4]+s*m[6]
        m[8] = c*m[8]+s*m[10]
        
        m[2] = c*m[2]-s*mv0
        m[6] = c*m[6]-s*mv4
        m[10] = c*m[10]-s*mv8
    }
    
    
    
    func scaleTransformation(ctx: CanvasRenderingContext2D){
        // Scaled rectangle
        ctx.scale(x: 9, y: 3);
        ctx.fillStyle = CanvasColorStyle.Color(color: .red);
        ctx.fillRect(x: 10, y: 10, width: 8, height: 20);
        
        // Reset current transformation matrix to the identity matrix
        ctx.setTransform(a: 1, b: 0, c: 0, d: 1, e: 0, f: 0);
        
        // Non-scaled rectangle
        ctx.fillStyle = CanvasColorStyle.Color(color: .gray);
        ctx.fillRect(x: 10, y: 10, width: 8, height: 20);
    }
    
    func drawNight(ctx: CanvasRenderingContext2D) {
        ctx.fillRect(x: 0, y: 0, width: 150, height: 150);
        ctx.translate(x: 75, y: 75);
        
        // Create a circular clipping path
        ctx.beginPath();
        ctx.arc(x: 0, y: 0, radius: 60, startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.clip();
        
        // draw background
        let lingrad = ctx.createLinearGradient(x0: 0, y0: -75, x1: 0, y1: 75);
        lingrad.addColorStop(offset: 0, color: UIColor(fromString: "#232256"));
        lingrad.addColorStop(offset: 1, color: UIColor(fromString: "#143778"));
        
        ctx.fillStyle = lingrad;
        ctx.fillRect(x: -75, y: -75, width: 150, height: 150);
        
        // draw stars
        for _ in 0 ... 49 {
            ctx.save()
            ctx.fillStyle = CanvasColorStyle.Color.init(color: .white)
            ctx.translate(x: 75 - floor(Float.random(in: 0.0...1.0) * 150),
                          y: 75 - floor(Float.random(in: 0.0...1.0) * 150));
            drawStar(ctx: ctx, r: floor(Float.random(in: 0.0...1.0) * 4) + 2);
            ctx.restore();
        }
        
    }
    
    func drawStar(ctx: CanvasRenderingContext2D, r: Float) {
        ctx.save();
        ctx.beginPath();
        ctx.moveTo(x: r, y: 0)
        for i in 0 ... 8 {
            ctx.rotate(angle: PI / 5);
            if (i % 2 == 0) {
                ctx.lineTo(x: (r / 0.525731) * 0.200811, y: 0);
            } else {
                ctx.lineTo(x: r, y: 0);
            }
        }
        ctx.closePath();
        ctx.fill();
        ctx.restore();
    }
    
    func rotateSquare(ctx: CanvasRenderingContext2D) {
        // left rectangles, rotate from canvas origin
        ctx.save();
        // blue rect
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromString: "#0095DD"));
        ctx.fillRect(x: 30, y: 30, width: 100, height: 100);
        ctx.rotate(angle: (PI / 180) * 25);
        // grey rect
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromString: "#4D4E53"));
        ctx.fillRect(x: 30, y: 30, width: 100, height: 100);
        ctx.restore();
        
        // right rectangles, rotate from rectangle center
        // draw blue rect
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromString: "#0095DD"));
        ctx.fillRect(x: 150, y: 30, width: 100, height: 100);
        
        ctx.translate(x: 200, y: 80); // translate to rectangle center
        // x = x + 0.5 * width
        // y = y + 0.5 * height
        ctx.rotate(angle: (PI / 180) * 25); // rotate
        ctx.translate(x: -200, y: -80); // translate back
        
        // draw grey rect
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromString: "#4D4E53"));
        ctx.fillRect(x: 150, y: 30, width: 100, height: 100);
    }
    
    func drawImageBlock(ctx: CanvasRenderingContext2D){
        
        do {
            let home = URL(fileURLWithPath:NSTemporaryDirectory())
            let rhino = home.appendingPathComponent("rhino.jpg")
            let image: UIImage?
            if(!FileManager.default.fileExists(atPath: rhino.path)){
                let data = try Data(contentsOf: URL(string: "https://mdn.mozillademos.org/files/5397/rhino.jpg")!)
                try data.write(to: rhino)
                image = UIImage(data: data)
            }else {
                image = UIImage(contentsOfFile: rhino.path)
            }
            let s = Float(UIScreen.main.scale) * 2
            
            for i in 0...3{
                for j in 0 ... 3 {
                    ctx.drawImage(image: image!, dx: Float(j * 50) * s, dy: Float(i * 38) * s, dWidth: 50 * s, dHeight: 38 * s);
                }
            }
            ctx.getCanvas().flush()
        } catch  {
            print(error)
            
        }
    }
    
    func radialGradient(ctx: CanvasRenderingContext2D){
        // Create gradients
        var radgrad = ctx.createRadialGradient(x0: 45, y0: 45, r0: 10, x1: 52, y1: 50, r1: 30);
        radgrad.addColorStop(offset: 0, color: UIColor(fromString: "#A7D30C"))
        radgrad.addColorStop(offset: 0.9, color: UIColor(fromString: "#019F62"));
        radgrad.addColorStop(offset: 1, color: UIColor(fromString: "rgba(1, 159, 98, 0)"));
        
        var radgrad2 = ctx.createRadialGradient(x0: 105, y0: 105, r0: 20, x1: 112, y1: 120, r1: 50);
        radgrad2.addColorStop(offset: 0, color: UIColor(fromString: "#FF5F98"));
        radgrad2.addColorStop(offset: 0.75, color: UIColor(fromString: "#FF0188"));
        radgrad2.addColorStop(offset: 1, color: UIColor(fromString: "rgba(255, 1, 136, 0)"));
        
        var radgrad3 = ctx.createRadialGradient(x0: 95, y0: 15, r0: 15, x1: 102, y1: 20, r1: 40);
        radgrad3.addColorStop(offset: 0, color: UIColor(fromString: "#00C9FF"));
        radgrad3.addColorStop(offset: 0.8, color: UIColor(fromString: "#00B5E2"));
        radgrad3.addColorStop(offset: 1, color: UIColor(fromString: "rgba(0, 201, 255, 0)"));
        
        var radgrad4 = ctx.createRadialGradient(x0: 0, y0: 150, r0: 50, x1: 0, y1: 140, r1: 90);
        radgrad4.addColorStop(offset: 0, color: UIColor(fromString: "#F4F201"));
        radgrad4.addColorStop(offset: 0.8, color: UIColor(fromString: "#E4C700"));
        radgrad4.addColorStop(offset: 1, color: UIColor(fromString: "rgba(228, 199, 0, 0)"));
        
        // draw shapes
        ctx.fillStyle = radgrad4;
        ctx.fillRect(x: 0, y: 0, width: 150, height: 150);
        ctx.fillStyle = radgrad3;
        ctx.fillRect(x: 0, y: 0, width: 150, height: 150);
        ctx.fillStyle = radgrad2;
        ctx.fillRect(x: 0, y: 0, width: 150, height: 150);
        ctx.fillStyle = radgrad;
        ctx.fillRect(x: 0, y: 0, width: 150, height: 150);
    }
    
    func drawLinearGradient(ctx: CanvasRenderingContext2D) {
        // Create gradients
        var lingrad = ctx.createLinearGradient(x0: 0, y0: 0, x1: 0, y1: 150);
        lingrad.addColorStop(offset: 0, color: UIColor(fromHex: "#00ABEB"))
        lingrad.addColorStop(offset: 0.5, color: UIColor(fromHex: "#fff"));
        lingrad.addColorStop(offset: 0.5, color: UIColor(fromHex: "#26C000"));
        lingrad.addColorStop(offset: 1, color: UIColor(fromHex: "#fff"));
        
        var lingrad2 = ctx.createLinearGradient(x0: 0, y0: 50, x1: 0, y1: 95);
        lingrad2.addColorStop(offset: 0.5, color: UIColor(fromHex: "#000"));
        lingrad2.addColorStop(offset: 1, color: UIColor(red: 0, green: 0, blue: 0, alpha: 0));
        
        // assign gradients to fill and stroke styles
        ctx.fillStyle = lingrad;
        ctx.strokeStyle = lingrad2;
        
        // draw shapes
        ctx.fillRect(x: 10, y: 10, width: 130, height: 130);
        ctx.strokeRect(x: 50, y: 50, width: 50, height: 50);
    }
    
    
    
    
    func drawPM(ctx: CanvasRenderingContext2D) {
        let s = Float(UIScreen.main.scale)
        roundedRect(ctx: ctx, x: 12 * s, y: 12 * s, width: 150 * s, height: 150 * s, radius: 15 * s);
        roundedRect(ctx: ctx, x: 19 * s, y: 19 * s, width: 150 * s, height: 150 * s, radius: 9 * s);
        roundedRect(ctx: ctx, x: 53 * s, y: 53 * s, width: 49 * s, height: 33 * s, radius: 10 * s);
        roundedRect(ctx: ctx, x: 53 * s, y: 119 * s, width: 49 * s, height: 16 * s, radius: 6 * s);
        roundedRect(ctx: ctx, x: 135 * s, y: 53 * s, width: 49 * s, height: 33 * s, radius: 10 * s);
        roundedRect(ctx: ctx, x: 135 * s, y: 119 * s, width: 25 * s, height: 49 * s, radius: 10 * s);
        
        ctx.beginPath();
        ctx.arc(x: 37 * s, y: 37 * s, radius: 13 * s, startAngle: PI / 7, endAngle: -PI / 7, anticlockwise: false);
        ctx.lineTo(x: 31 * s, y: 37 * s);
        ctx.fill();
        
        for i in 0...7{
            ctx.fillRect(x: Float(51 + i * 16)  * s, y: 35 * s, width: 4 * s, height: 4 * s);
        }
        
        for i in 0...5{
            ctx.fillRect(x: 115 * s, y: Float(51 + i * 16) * s, width: 4 * s, height: 4 * s);
        }
        
        for i in 0...7{
            ctx.fillRect(x: Float(51 + i * 16) * s, y: 99 * s, width: 4 * s, height: 4 * s);
        }
        
        
        ctx.beginPath();
        ctx.moveTo(x: 83 * s, y: 116 * s);
        ctx.lineTo(x: 83 * s, y: 102 * s);
        ctx.bezierCurveTo(cp1x: 83 * s, cp1y: 94 * s, cp2x: 89 * s, cp2y: 88 * s, x: 97 * s, y: 88 * s);
        ctx.bezierCurveTo(cp1x: 105 * s, cp1y: 88 * s, cp2x: 111 * s, cp2y: 94 * s, x: 111 * s, y: 102 * s);
        ctx.lineTo(x: 111 * s, y: 116 * s);
        ctx.lineTo(x: 106.333 * s, y: 111.333 * s);
        ctx.lineTo(x: 101.666 * s, y: 116 * s);
        ctx.lineTo(x: 97 * s, y: 111.333 * s);
        ctx.lineTo(x: 92.333 * s, y: 116 * s);
        ctx.lineTo(x: 87.666 * s, y: 111.333 * s);
        ctx.lineTo(x: 83 * s, y: 116 * s);
        ctx.fill();
        
        ctx.fillStyle = CanvasColorStyle.Color(color: .white);
        ctx.beginPath();
        ctx.moveTo(x: 91 * s, y: 96 * s);
        ctx.bezierCurveTo(cp1x: 88 * s, cp1y: 96 * s, cp2x: 87 * s, cp2y: 99 * s, x: 87 * s, y: 101 * s);
        ctx.bezierCurveTo(cp1x: 87 * s, cp1y: 103 * s, cp2x: 88 * s, cp2y: 106 * s, x: 91 * s, y: 106 * s);
        ctx.bezierCurveTo(cp1x: 94 * s, cp1y: 106 * s, cp2x: 95 * s, cp2y: 103 * s, x: 95 * s, y: 101 * s);
        ctx.bezierCurveTo(cp1x: 95 * s, cp1y: 99 * s, cp2x: 94 * s, cp2y: 96 * s, x: 91 * s, y: 96 * s);
        ctx.moveTo(x: 103 * s, y: 96 * s);
        ctx.bezierCurveTo(cp1x: 100 * s, cp1y: 96 * s, cp2x: 99 * s, cp2y: 99 * s, x: 99 * s, y: 101 * s);
        ctx.bezierCurveTo(cp1x: 99 * s, cp1y: 103 * s, cp2x: 100 * s, cp2y: 106 * s, x: 103 * s, y: 106 * s);
        ctx.bezierCurveTo(cp1x: 106 * s, cp1y: 106 * s, cp2x: 107 * s, cp2y: 103 * s, x: 107 * s, y: 101 * s);
        ctx.bezierCurveTo(cp1x: 107 * s, cp1y: 99 * s, cp2x: 106 * s, cp2y: 96 * s, x: 103 * s, y: 96 * s);
        ctx.fill();
        
        ctx.fillStyle = CanvasColorStyle.Color(color: .black);
        ctx.beginPath();
        ctx.arc(x: 101 * s, y: 102 * s, radius: 2 * s, startAngle: 0 * s, endAngle: PI * 2, anticlockwise: true);
        ctx.fill();
        
        ctx.beginPath();
        ctx.arc(x: 89 * s, y: 102 * s, radius: 2 * s, startAngle: 0 * s, endAngle: PI * 2, anticlockwise: true);
        ctx.fill();
        
    }
    
    // A utility function to draw a rectangle with rounded corners.
    
    func roundedRect(ctx: CanvasRenderingContext2D, x: Float, y: Float, width: Float, height:Float, radius:Float) {
        ctx.beginPath();
        ctx.moveTo(x: x, y: y + radius);
        ctx.lineTo(x: x, y: y + height - radius);
        ctx.arcTo(x1: x, y1: y + height, x2: x + radius, y2: y + height, radius: radius);
        ctx.lineTo(x: x + width - radius, y: y + height);
        ctx.arcTo(x1: x + width, y1: y + height, x2: x + width, y2: y + height-radius, radius: radius);
        ctx.lineTo(x: x + width, y: y + radius);
        ctx.arcTo(x1: x + width, y1: y, x2: x + width - radius, y2: y, radius: radius);
        ctx.lineTo(x: x + radius, y: y);
        ctx.arcTo(x1: x, y1: y, x2: x, y2: y + radius, radius: radius);
        ctx.stroke();
    }
    
    func drawWindow(ctx: CanvasRenderingContext2D){
        // draw background
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#FD0"));
        ctx.fillRect(x: 0, y: 0, width: Float(75 * scale), height: Float(75 * scale));
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#6C0"));
        ctx.fillRect(x: Float(75 * scale), y: 0, width: Float(75 * scale), height: Float(75 * scale));
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#09F"));
        ctx.fillRect(x: 0, y: Float(75 * scale), width: Float(75 * scale), height: Float(75 * scale));
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#F30"));
        ctx.fillRect(x: Float(75 * scale), y: Float(75 * scale), width: Float(75 * scale), height: Float(75 * scale));
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#FFF"));
        
        // set transparency value
        ctx.globalAlpha = 0.2;
        
        // Draw semi transparent circles
        
        for i in 0...6 {
            ctx.beginPath();
            ctx.arc(x: Float(75 * scale), y: Float(75 * scale), radius: Float((10 + 10 * i) * scale), startAngle: 0, endAngle: PI * 2, anticlockwise: true);
            ctx.fill();
        }
    }
    
    func draw1() {
        let ctx = canvas1?.getContext(type: "2d") as! CanvasRenderingContext2D
        ctx.beginPath()
        ctx.arc(x: 240, y: 20, radius: 40, startAngle: 0, endAngle: PI)
        ctx.moveTo(x: 100, y: 20)
        ctx.arc(x: 60, y: 20, radius: 40, startAngle: 0, endAngle: PI)
        ctx.moveTo(x: 215, y: 80)
        ctx.arc(x: 150, y: 80, radius: 65, startAngle: 0, endAngle: PI)
        ctx.closePath()
        ctx.lineWidth = 6
        ctx.stroke()
    }
    
    
    func scaleText(ctx: CanvasRenderingContext2D){
        ctx.scale(x: -1, y: 1);
        ctx.font = "48px serif";
        ctx.fillText(text: "Hello world!", x: -280, y: 90);
        ctx.setTransform(a: 1, b: 0, c: 0, d: 1, e: 0, f: 0);
    }
    func saveRestoreExample(ctx: CanvasRenderingContext2D){
        // Save the default state
        ctx.save();
        let s = Float(UIScreen.main.scale)
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 0, green: 128/255, blue: 0, alpha: 1.0));
        ctx.fillRect(x: 10 * s, y: 10 * s, width: 100 * s, height: 100 * s);
        
        // Restore the default state
        ctx.restore();
        
        ctx.fillRect(x: 150 * s, y: 40 * s, width: 100 * s, height: 100 * s);
        
    }
    func closePathExample(ctx: CanvasRenderingContext2D){
        ctx.beginPath();
        ctx.arc(x: 240, y: 20, radius: 40, startAngle: 0, endAngle: PI);
        ctx.moveTo(x: 100, y: 20);
        ctx.arc(x: 60, y: 20, radius: 40, startAngle: 0, endAngle: PI);
        ctx.moveTo(x: 215, y: 80);
        ctx.arc(x: 150, y: 80, radius: 65, startAngle: 0, endAngle: PI);
        ctx.closePath();
        ctx.lineWidth = 6;
        ctx.stroke();
    }
    
    func bezierCurveToExample(ctx: CanvasRenderingContext2D) {
        // Define the points as {x, y}
        let start = KeyValue(x: 50, y: 20)
        let cp1 = KeyValue(x: 230, y: 30)
        let cp2 = KeyValue(x: 150, y: 80)
        let end = KeyValue(x: 250, y: 100)
        
        // Cubic Bézier curve
        ctx.beginPath()
        ctx.moveTo(x: start.x, y: start.y)
        ctx.bezierCurveTo(cp1x: cp1.x, cp1y: cp1.y, cp2x: cp2.x, cp2y: cp2.y, x: end.x, y: end.y)
        ctx.stroke()
        
        // Start and end points
        ctx.fillStyle = CanvasColorStyle.Color(color: .blue)
        ctx.beginPath()
        ctx.arc(x: start.x, y: start.y, radius: 5, startAngle: 0, endAngle: TWO_PI)  // Start point
        ctx.arc(x: end.x, y: end.y, radius: 5, startAngle: 0, endAngle: TWO_PI)      // End point
        ctx.fill()
        
        // Control points
        ctx.fillStyle = CanvasColorStyle.Color(color: .red)
        ctx.beginPath()
        ctx.arc(x: cp1.x, y: cp1.y, radius: 5, startAngle: 0, endAngle: TWO_PI)  // Control point one
        ctx.arc(x: cp2.x, y: cp2.y, radius: 5, startAngle: 0, endAngle: TWO_PI)  // Control point two
        ctx.fill()
    }
    
    func drawHouse(ctx: CanvasRenderingContext2D){
        ctx.lineWidth = 10
        
        // Wall
        ctx.strokeRect(x: 75, y: 140, width: 150, height: 110)
        
        // Door
        ctx.fillRect(x: 130, y: 190, width: 40, height: 60)
        
        // Roof
        ctx.moveTo(x: 50, y: 140)
        ctx.lineTo(x: 150, y: 60)
        ctx.lineTo(x: 250, y: 140)
        ctx.closePath()
        ctx.stroke()
    }
    
    
    func arcExample(ctx: CanvasRenderingContext2D){
        for i in 0...3    {
            for j in 0...2{
                ctx.beginPath();
                let x             = Float32(25 + j * 50);                 // x coordinate
                let y             = Float32(25 + i * 50);                 // y coordinate
                let radius        = Float32(20);                          // Arc radius
                let startAngle    = Float32(0);                           // Starting point on circle
                let endAngle      = Float32((PI + (PI * Float(j)) / 2)) // End point on circle
                let anticlockwise = i % 2 == 1;                  // Draw anticlockwise
                
                ctx.arc(x: x, y: y, radius: radius, startAngle: startAngle, endAngle: endAngle, anticlockwise: anticlockwise);
                if (i > 1) {
                    ctx.fill();
                } else {
                    ctx.stroke();
                }
            }
        }
    }
    
    func ellipseExample(ctx: CanvasRenderingContext2D){
        // Draw the ellipse
        ctx.beginPath();
        ctx.ellipse(x: 100, y: 100, radiusX: 50, radiusY: 75, rotation: (PI / 4), startAngle: 0, endAngle: TWO_PI);
        ctx.stroke();
        
        // Draw the ellipse's line of reflection
        ctx.beginPath();
        ctx.setLineDash(segments: [5, 5]);
        ctx.moveTo(x: 0, y: 200);
        ctx.lineTo(x: 200, y: 0);
        ctx.stroke();
        ctx.clearRect(x: 0, y: 0, width: ctx.getCanvas().width, height: ctx.getCanvas().height)
        ctx.setLineDash(segments: []);
        ctx.beginPath();
        ctx.ellipse(x: 100, y: 100, radiusX: 50, radiusY: 75, rotation: (PI / 4), startAngle: 0, endAngle: TWO_PI);
        ctx.stroke();
        ctx.beginPath();
        ctx.moveTo(x: 0, y: 200);
        ctx.lineTo(x: 200, y: 0);
        ctx.stroke();
    }
    
    func getCanvasWidth(canvas: Canvas) -> Float32 {
        return Float32(canvas.frame.width )
    }
    
    func getCanvasHeight(canvas: Canvas) -> Float32 {
        return Float32(canvas.frame.height )
    }
    
    func strokeExample(ctx: CanvasRenderingContext2D){
        // First sub-path
        ctx.lineWidth = 26
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(red: 1, green: 165/255, blue: 0, alpha: 1.0))
        ctx.moveTo(x: 20, y: 20)
        ctx.lineTo(x: 160, y: 20)
        ctx.stroke()
        
        // Second sub-path
        ctx.lineWidth = 14
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(red: 0, green: 128/255, blue: 0, alpha: 1.0))
        ctx.moveTo(x: 20, y: 80)
        ctx.lineTo(x: 220, y: 80)
        ctx.stroke()
        
        // Third sub-path
        ctx.lineWidth = 4
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1.0))
        ctx.moveTo(x: 20, y: 140)
        ctx.lineTo(x: 280, y: 140)
        ctx.stroke()
    }
    
    @IBAction func firstTap(_ sender: UITapGestureRecognizer) {
        drawAll()
    }
    
    class KeyValue{
        let x: Float
        let y: Float
        init(x: Float, y: Float) {
            self.x = x
            self.y = y
        }
    }
    @IBAction func secondTap(_ sender: UITapGestureRecognizer) {
        let ctx = canvas2?.getContext(type: "2d") as! CanvasRenderingContext2D
        //_ = canvas2?.ensureIsContextIsCurrent()
        drawHouse(ctx: ctx)
    }
    
    
    private func textPoint(ctx: CanvasRenderingContext2D,p: KeyValue, offset: KeyValue,i: Int){
        let x = offset.x
        let y = offset.y
        ctx.beginPath()
        ctx.arc(x: p.x, y: p.y, radius: 2, startAngle: 0, endAngle: TWO_PI)
        ctx.fill()
        var text = String(i) + ":"
        text = text + String(Int(p.x)) + ","
        text = text + String(Int(p.y))
        ctx.fillText(text: text, x: p.x + x, y: p.y + y);
    }
    
    private func drawPoints(ctx: CanvasRenderingContext2D, points: [KeyValue]){
        for i in 0...points.count - 1 {
            autoreleasepool {
                textPoint(ctx: ctx,p: points[i], offset: KeyValue( x: 0, y: -20 ) , i: i)
            }
        }
    }
    
    private func drawArc(ctx: CanvasRenderingContext2D, points: [KeyValue], r: Float){
        ctx.beginPath()
        p1 = points[0]
        p2 = points[1]
        p3 = points[2]
        
        ctx.moveTo(x: p1.x, y: p1.y)
        ctx.arcTo(x1: p2.x, y1: p2.y, x2: p3.x, y2: p3.y, radius: r)
        ctx.lineTo(x: p3.x, y: p3.y)
        ctx.stroke()
    }
    
    
    
    func drawFace(ctx: CanvasRenderingContext2D) {
        ctx.beginPath()
        ctx.arc(x: 75, y: 75, radius: 50, startAngle: 0,endAngle: TWO_PI, anticlockwise: true) // Outer circle
        ctx.moveTo(x: 110, y: 75)
        ctx.arc(x: 75, y: 75, radius: 35, startAngle: 0, endAngle: PI, anticlockwise: false) // Mouth (clockwise)
        ctx.moveTo(x: 65, y: 65)
        ctx.arc(x: 60, y: 65, radius: 5, startAngle: 0, endAngle: TWO_PI, anticlockwise: true)  // Left eye
        ctx.moveTo(x: 95, y: 65);
        ctx.arc(x: 90, y: 65, radius: 5, startAngle: 0, endAngle: TWO_PI, anticlockwise: true)  // Right eye
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromString: "blue"))
        ctx.stroke();
        
    }
    var last = 0
    private func loop(ctx: CanvasRenderingContext2D, t: Float){
        let PI2 = TWO_PI
        let points = [p1,p2,p3]
        let t0 = t / 1000
        let a  = t0.truncatingRemainder(dividingBy: PI2);
        let rr = abs(cos(a) * r)
        ctx.clearRect(x: 0, y: 0, width: ctx.getCanvas().width, height: ctx.getCanvas().height);
        drawArc(ctx: ctx,points: points, r: rr)
        drawPoints(ctx: ctx,points: points)
        AnimationFrame.requestAnimationFrame(toLoop: { (id) in
            self.loop(ctx: ctx, t: Float(id))
        })
    }
    
    class Ball {
        var x = 100.0
        var y = 100.0
        var vx = 5.0
        var vy = 2.0
        var radius: Float = 25
        var color = UIColor.blue
        init() {
            
        }
        func draw(ctx: CanvasRenderingContext2D){
            ctx.beginPath();
            ctx.arc(x: Float(x), y: Float(y),radius: radius, startAngle: 0, endAngle: .pi * 2, anticlockwise: true);
            ctx.closePath();
            ctx.fillStyle = CanvasColorStyle.Color(color: color)
            ctx.fill();
        }
    }
    
    
    
    func draw(ctx: CanvasRenderingContext2D) {
        let canvas = ctx.getCanvas()
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromString: "rgba(255, 255, 255, 0.3)"))
        let width = canvas.width
        let height = canvas.height
        ctx.fillRect(x: 0, y: 0, width: Float(width), height: Float(height));
        ball.draw(ctx: ctx)
        ball.x += ball.vx;
        ball.y += ball.vy;
        ball.vy *= 0.99;
        ball.vy += 0.25;
        
        if (Int(ball.y + ball.vy) > Int(height) ||
            ball.y + ball.vy < 0) {
            ball.vy = -ball.vy;
        }
        if (Int(ball.x + ball.vx) > Int(width) ||
            ball.x + ball.vx < 0) {
            ball.vx = -ball.vx;
        }
        
        AnimationFrame.requestAnimationFrame(toLoop: { (timer) in
            self.draw(ctx: ctx)
        })
    }
    
    var ball = Ball()
    
    func ballExample(ctx: CanvasRenderingContext2D) {
        AnimationFrame.requestAnimationFrame(toLoop:{ (timer) in
            self.draw(ctx: ctx)
        })
    }
    
    
    func globalCompositeOperationExample(ctx: CanvasRenderingContext2D){
        ctx.globalCompositeOperation = CanvasCompositeOperationType(rawValue: "xor")!
        
        ctx.fillStyle = CanvasColorStyle.Color(color: .blue)
        ctx.fillRect(x: 10, y: 10, width: 100, height: 100)
        
        ctx.fillStyle = CanvasColorStyle.Color(color: .red)
        ctx.fillRect(x: 50, y: 50, width: 100, height: 100)
    }
    
    
    func createRadialGradientExample(ctx: CanvasRenderingContext2D){
        // Create a radial gradient
        // The inner circle is at x=110, y=90, with radius=30
        // The outer circle is at x=100, y=100, with radius=70
        let gradient = ctx.createRadialGradient(x0: 110,y0: 90,r0: 30, x1: 100,y1: 100,r1: 70);
        // Add three color stops
        //gradient.addColorStop(offset: 0, color: UIColor(red: 1.0, green: 192/255, blue: 203/255, alpha: 1.0));
        // gradient.addColorStop(offset: 0.9, color: .white);
        gradient.addColorStop(offset: 1, color: UIColor(red: 0.0, green: 128/255, blue: 0.0, alpha: 1.0));
        
        // Set the fill style and draw a rectangle
        ctx.fillStyle = gradient;
        ctx.fillRect(x: 20, y: 20, width: 160, height: 160);
    }
    
    
    func createLinearGradientExample(ctx: CanvasRenderingContext2D) {
        // Create a linear gradient
        // The start gradient point is at x=20, y=0
        // The end gradient point is at x=220, y=0
        let gradient = ctx.createLinearGradient(x0: 20,y0: 0, x1: 220,y1: 0);
        
        // Add three color stops
        let green = UIColor(red: 0.0, green: 128/255, blue: 0.0, alpha: 1.0)
        gradient.addColorStop(offset: 0, color: green);
        gradient.addColorStop(offset: 0.5, color: UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0));
        gradient.addColorStop(offset: 1, color: green);
        
        // Set the fill style and draw a rectangle
        ctx.fillStyle = gradient;
        ctx.fillRect(x: 20, y: 20, width: 200, height: 100);
    }
    var scale = 0
    var r  = Float(100.0) * 3 ; // Radius
    let p0 = KeyValue( x: 0, y: 50 )
    
    var p1 = KeyValue( x: 100 , y: 100 )
    var p2 = KeyValue( x: 150 , y: 50 )
    var p3 = KeyValue( x: 200 , y: 100 )
    var t = Float(0.0)
    
    
    func arcToAnimationExample(ctx: CanvasRenderingContext2D){
        AnimationFrame.requestAnimationFrame(toLoop:{ (timer) in
            self.loop(ctx: ctx, t: timer)
        })
    }
    
    func arcToExample(ctx: CanvasRenderingContext2D) {
        // Tangential lines
        ctx.beginPath()
        ctx.strokeStyle = CanvasColorStyle.Color(color: .darkGray)
        ctx.moveTo(x: 200, y: 20)
        ctx.lineTo(x: 200, y: 130)
        ctx.lineTo(x: 50, y: 20)
        ctx.stroke()
        
        // Arc
        ctx.beginPath()
        ctx.strokeStyle = CanvasColorStyle.Color(color: .black)
        ctx.lineWidth = 5
        ctx.moveTo(x: 200, y: 20)
        ctx.arcTo(x1: 200, y1: 130, x2: 50, y2: 20, radius: 40)
        ctx.stroke()
        
        // Start point
        ctx.beginPath()
        ctx.fillStyle = CanvasColorStyle.Color(color: .blue)
        ctx.arc(x: 200, y: 20, radius: 5, startAngle: 0, endAngle: (TWO_PI))
        ctx.fill()
        
        // Control points
        ctx.beginPath()
        ctx.fillStyle = CanvasColorStyle.Color(color: .red)
        ctx.arc(x: 200, y: 130, radius: 5, startAngle: 0, endAngle: TWO_PI) // Control point one
        ctx.arc(x: 50, y: 20, radius: 5, startAngle: 0, endAngle: TWO_PI)   // Control point two
        ctx.fill()
    }
    
    func clearRectExample(ctx: CanvasRenderingContext2D){
        // Draw yellow background
        let width = ctx.getCanvas().width
        let height = ctx.getCanvas().height
        ctx.beginPath();
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#ff6"))
        ctx.fillRect(x: 0, y: 0, width: width, height: height);
        
        // Draw blue triangle
        ctx.beginPath();
        ctx.fillStyle = CanvasColorStyle.Color(color: .blue);
        ctx.moveTo(x: 20, y: 20);
        ctx.lineTo(x: 180, y: 20);
        ctx.lineTo(x: 130, y: 130);
        ctx.closePath();
        ctx.fill();
        
        // Clear part of the canvas
        ctx.clearRect(x: 10, y: 10, width: 120, height: 100);
    }
    
    func fontExample(ctx: CanvasRenderingContext2D){
        ctx.font = "bold 48px serif"
        ctx.strokeText(text: "Hello world", x: 50, y: 100);
        
        ctx.font = "50px serif"
        ctx.fillText(text: "Hello world", x:50, y:190);
    }
    
    func setTransformExample(ctx: CanvasRenderingContext2D){
        ctx.setTransform(a: 1, b: 0.2, c: 0.8, d: 1, e: 0, f: 0);
        ctx.fillRect(x: 0, y: 0, width: 100, height: 100);
    }
    
    func scaleExample(ctx: CanvasRenderingContext2D){
        // Scaled rectangle
        ctx.scale(x: 9, y: 3)
        ctx.fillStyle = CanvasColorStyle.Color(color: .red)
        ctx.fillRect(x: 10, y: 10, width: 8, height: 20);
        
        // Reset current transformation matrix to the identity matrix
        ctx.setTransform(a: 1, b: 0, c: 0, d: 1, e: 0, f: 0);
        
        // Non-scaled rectangle
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        ctx.fillRect(x: 10, y: 10, width: 8, height: 20);
    }
    
    func rotateAngleExample(ctx: CanvasRenderingContext2D){
        // Point of transform origin
        ctx.arc(x: 0, y: 0, radius: 5, startAngle: 0, endAngle: TWO_PI);
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0));
        ctx.fill();
        
        // Non-rotated rectangle
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        ctx.fillRect(x: 100, y: 0, width: 80, height: 20);
        
        // Rotated rectangle
        ctx.rotate(angle: 45 * PI / 180);
        ctx.fillStyle =  CanvasColorStyle.Color(color: .red)
        ctx.fillRect(x: 100, y: 0, width: 80, height: 20);
        
        // Reset transformation matrix to the identity matrix
        ctx.setTransform(a: 1, b: 0, c: 0, d: 1, e: 0, f: 0);
    }
    
    func secondRotateAngleExample(ctx: CanvasRenderingContext2D) {
        // Non-rotated rectangle
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        ctx.fillRect(x: 80, y: 60, width: 140, height: 30);
        
        // Matrix transformation
        ctx.translate(x: 150, y: 75);
        ctx.rotate(angle: PI / 2);
        ctx.translate(x: -150, y: -75);
        
        // Rotated rectangle
        ctx.fillStyle = CanvasColorStyle.Color(color: .red)
        ctx.fillRect(x: 80, y: 60, width: 140, height: 30);
    }
    
    func translateExample(ctx: CanvasRenderingContext2D){
        ctx.translate(x: 110, y: 30);
        ctx.fillStyle = CanvasColorStyle.Color(color: .red)
        ctx.fillRect(x: 0, y: 0, width: 80, height: 80);
        
        // Reset current transformation matrix to the identity matrix
        ctx.setTransform(a: 1, b: 0, c: 0, d: 1, e: 0, f: 0);
        
        // Unmoved square
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        ctx.fillRect(x: 0, y: 0, width: 80, height: 80);
    }
    
    func quadraticCurveToExample(ctx: CanvasRenderingContext2D){
        // Quadratic Bézier curve
        ctx.beginPath();
        ctx.moveTo(x: 50, y: 20);
        ctx.quadraticCurveTo(cpx: 230, cpy: 30, x: 50, y: 100);
        ctx.stroke();
        
        // Start and end points
        ctx.fillStyle = CanvasColorStyle.Color(color: .blue)
        ctx.beginPath();
        ctx.arc(x: 50, y: 20, radius: 5, startAngle: 0, endAngle: TWO_PI);   // Start point
        ctx.arc(x: 50, y: 100, radius: 5, startAngle: 0, endAngle: TWO_PI);  // End point
        ctx.fill();
        
        // Control point
        ctx.fillStyle = CanvasColorStyle.Color(color: .red)
        ctx.beginPath();
        ctx.arc(x: 230, y: 30, radius: 5, startAngle: 0, endAngle: TWO_PI);
        ctx.fill();
    }
    
    func drawImageExample(ctx: CanvasRenderingContext2D) {
        do {
            let home = URL(fileURLWithPath:NSHomeDirectory())
            let rhino = home.appendingPathComponent("rhino.jpg")
            let image: UIImage?
            if(!FileManager.default.fileExists(atPath: rhino.path)){
                let data = try Data(contentsOf: URL(string: "https://mdn.mozillademos.org/files/5397/rhino.jpg")!)
                try data.write(to: rhino)
                image = UIImage(data: data)
            }else {
                image = UIImage(contentsOfFile: rhino.path)
            }
            
            ctx.drawImage(image: image!, dx: 0,dy: 0);
        } catch  {
            
        }
    }
    
    func doSolarAnimation(ctx: CanvasRenderingContext2D){
        AnimationFrame.requestAnimationFrame(toLoop: { (id) in
            self.solarSystemExample(ctx: ctx)
        })
    }
    
    func solarSystemExample(ctx: CanvasRenderingContext2D){
        do{
            let sun_url = NSURL(fileURLWithPath: NSTemporaryDirectory() + "/Canvas_sun.png")
            let moon_url = NSURL(fileURLWithPath: NSTemporaryDirectory() + "/Canvas_moon.png")
            let earth_url = NSURL(fileURLWithPath: NSTemporaryDirectory() + "/Canvas_earth.png")
            var sun = UIImage(contentsOfFile: sun_url.absoluteString!)
            var moon = UIImage(contentsOfFile: sun_url.absoluteString!)
            var earth = UIImage(contentsOfFile: sun_url.absoluteString!)
            if sun == nil {
                let sun_data = try Data(contentsOf: URL(string: "https://mdn.mozillademos.org/files/1456/Canvas_sun.png")!)
                try sun_data.write(to: sun_url.absoluteURL!, options: .atomicWrite)
                sun = UIImage(data: sun_data)
            }
            if moon == nil {
                let moon_data = try Data(contentsOf: URL(string: "https://mdn.mozillademos.org/files/1443/Canvas_moon.png")!)
                try moon_data.write(to: moon_url.absoluteURL!, options: .atomicWrite)
                moon = UIImage(data: moon_data)
            }
            
            if earth == nil {
                let earth_data = try Data(contentsOf: URL(string: "https://mdn.mozillademos.org/files/1429/Canvas_earth.png")!)
                try earth_data.write(to: earth_url.absoluteURL!, options: .atomicWrite)
                earth = UIImage(data: earth_data)
            }
            
            
            ctx.globalCompositeOperation = CanvasCompositeOperationType.DestinationOver
            ctx.clearRect(x: 0, y: 0, width: 300, height: 300); // clear canvas
            
            ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4))
            ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(red: 0.0, green: 153/255, blue: 1.0, alpha: 0.4))
            ctx.save();
            ctx.translate(x: 150, y: 150);
            
            // Earth
            let time = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.second,.nanosecond], from: time)
            _ = components.second!
            let nanoseconds = components.nanosecond!
            let milliseconds = nanoseconds/1000000
            let part_one = (TWO_PI / 60) * Float(milliseconds)
            let part_two = (TWO_PI / 60000) * Float(milliseconds)
            
            
            let first_angle = part_one + part_two
            ctx.rotate(angle: first_angle)
            ctx.translate(x: 105, y: 0);
            ctx.fillRect(x: 0, y: -12, width: 40, height: 24); // Shadow
            ctx.drawImage(image: earth!, dx: -12, dy: -12);
            
            
            // Moon
            ctx.save();
            let part_one_second = (TWO_PI / 6) * Float(milliseconds)
            let part_two_second = (TWO_PI / 60000) * Float(milliseconds)
            let second_angle = part_one_second + part_two_second
            ctx.rotate(angle: second_angle)
            ctx.translate(x: 0, y: 28.5);
            ctx.drawImage(image: moon!, dx: -3.5, dy: -3.5);
            ctx.restore();
            
            ctx.restore();
            
            ctx.beginPath();
            ctx.arc(x: 150, y: 150, radius: 105, startAngle: 0, endAngle: TWO_PI, anticlockwise: false); // Earth orbit
            ctx.stroke();
            
            ctx.drawImage(image: sun!, dx: 0, dy: 0, dWidth: 300, dHeight: 300);
            
            AnimationFrame.requestAnimationFrame(toLoop:{ id in
                self.solarSystemExample(ctx: ctx)
            })
            
        }catch {
            print(error)
        }
    }
    
    
    func clockAnimation(ctx: CanvasRenderingContext2D){
        AnimationFrame.requestAnimationFrame(toLoop: { (timer) in
            self.clock(ctx: ctx)
        })
    }
    
    func x2Clock(ctx: CanvasRenderingContext2D){
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second,.minute,.hour], from: date)
        let seconds = components.second!
        let minutes = components.minute!
        let hours = components.hour!
        ctx.save();
        let scale = UIScreen.main.scale
        ctx.clearRect(x: 0, y: 0, width: Float(150 ), height: Float(150 ));
        ctx.translate(x: Float(75 ), y: Float(75 ));
        ctx.scale(x: 0.4, y: 0.4);
        ctx.rotate(angle: -PI / 2);
        ctx.strokeStyle = CanvasColorStyle.Color(color: .black);
        ctx.fillStyle = CanvasColorStyle.Color(color: .white);
        ctx.lineWidth = Float(8  );
        ctx.lineCap = LineCap.Round;
        
        // Hour marks
        ctx.save();
        for _ in 0...11{
            ctx.beginPath();
            ctx.rotate(angle: PI / 6);
            ctx.moveTo(x: Float(100 ), y: 0);
            ctx.lineTo(x: Float(120 ), y: 0);
            ctx.stroke();
        }
        ctx.restore();
        
        // Minute marks
        ctx.save();
        ctx.lineWidth = Float(5 );
        for i in 0...59{
            if (i % 5 != 0) {
                ctx.beginPath();
                ctx.moveTo(x: Float(117 ), y: 0);
                ctx.lineTo(x: Float(120 ), y: 0);
                ctx.stroke();
            }
            ctx.rotate(angle: PI / 30);
        }
        ctx.restore();
        
        let sec = Float(seconds)
        let min = Float(minutes)
        var hr  = Float(hours)
        hr = hr >= 12 ? hr - 12 : hr;
        
        ctx.fillStyle = CanvasColorStyle.Color(color: .black);
        
        // write Hours
        ctx.save();
        let first = hr * (PI / 6)
        let second = first + (PI / 360) * min
        let third = second  + (PI / 21600) * sec
        ctx.rotate(angle: third)
        ctx.lineWidth = Float(14 );
        ctx.beginPath();
        ctx.moveTo(x: Float(-20 ), y: 0);
        ctx.lineTo(x: Float(80 ), y: 0);
        ctx.stroke();
        ctx.restore();
        
        // write Minutes
        ctx.save();
        ctx.rotate(angle: (PI / 30) * min + (PI / 1800) * sec);
        ctx.lineWidth = Float(10 );
        ctx.beginPath();
        ctx.moveTo(x: Float(-28 ), y: 0);
        ctx.lineTo(x: Float(112 ), y: 0);
        ctx.stroke();
        ctx.restore();
        
        // Write seconds
        ctx.save();
        ctx.rotate(angle: sec * PI / 30);
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#D40000"));
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#D40000"));
        ctx.lineWidth = Float(6 );
        ctx.beginPath();
        ctx.moveTo(x: Float(-30 ), y: 0);
        ctx.lineTo(x: Float(83 ), y: 0);
        ctx.stroke();
        ctx.beginPath();
        ctx.arc(x: 0, y: 0, radius: Float(10 ), startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.fill();
        ctx.beginPath();
        ctx.arc(x: Float(95 ), y: 0, radius: Float(10 ), startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.stroke();
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0));
        ctx.arc(x: 0, y: 0, radius: Float(3 ), startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.fill();
        ctx.restore();
        
        ctx.beginPath();
        ctx.lineWidth = Float(14 );
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#325FA2"));
        ctx.arc(x: 0, y: 0, radius: Float(142 ), startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.stroke();
        
        ctx.restore();
        
        AnimationFrame.requestAnimationFrame(toLoop: { (timer) in
            self.clock(ctx: ctx)
        })
    }
    
    func clock(ctx: CanvasRenderingContext2D){
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second,.minute,.hour], from: date)
        let seconds = components.second!
        let minutes = components.minute!
        let hours = components.hour!
        ctx.save();
        ctx.clearRect(x: 0, y: 0, width: 150, height: 150);
        ctx.translate(x: 75, y: 75);
        ctx.scale(x: 0.5, y: 0.5);
        ctx.rotate(angle: -PI / 2);
        ctx.strokeStyle = CanvasColorStyle.Color(color: .black);
        ctx.fillStyle = CanvasColorStyle.Color(color: .white);
        ctx.lineWidth = 8;
        ctx.lineCap = LineCap.Round;
        
        // Hour marks
        ctx.save();
        for _ in 0...11{
            ctx.beginPath();
            ctx.rotate(angle: PI / 6);
            ctx.moveTo(x: 100, y: 0);
            ctx.lineTo(x: 120, y: 0);
            ctx.stroke();
        }
        ctx.restore();
        
        // Minute marks
        ctx.save();
        ctx.lineWidth = 5;
        for i in 0...59{
            if (i % 5 != 0) {
                ctx.beginPath();
                ctx.moveTo(x: 117, y: 0);
                ctx.lineTo(x: 120, y: 0);
                ctx.stroke();
            }
            ctx.rotate(angle: PI / 30);
        }
        ctx.restore();
        
        let sec = Float(seconds)
        let min = Float(minutes)
        var hr  = Float(hours)
        hr = hr >= 12 ? hr - 12 : hr;
        
        ctx.fillStyle = CanvasColorStyle.Color(color: .black);
        
        // write Hours
        ctx.save();
        let first = hr * (PI / 6)
        let second = first + (PI / 360) * min
        let third = second  + (PI / 21600) * sec
        ctx.rotate(angle: third)
        ctx.lineWidth = 14;
        ctx.beginPath();
        ctx.moveTo(x: -20, y: 0);
        ctx.lineTo(x: 80, y: 0);
        ctx.stroke();
        ctx.restore();
        
        // write Minutes
        ctx.save();
        ctx.rotate(angle: (PI / 30) * min + (PI / 1800) * sec);
        ctx.lineWidth = 10;
        ctx.beginPath();
        ctx.moveTo(x: -28, y: 0);
        ctx.lineTo(x: 112, y: 0);
        ctx.stroke();
        ctx.restore();
        
        // Write seconds
        ctx.save();
        ctx.rotate(angle: sec * PI / 30);
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#D40000"));
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#D40000"));
        ctx.lineWidth = 6;
        ctx.beginPath();
        ctx.moveTo(x: -30, y: 0);
        ctx.lineTo(x: 83, y: 0);
        ctx.stroke();
        ctx.beginPath();
        ctx.arc(x: 0, y: 0, radius: 10, startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.fill();
        ctx.beginPath();
        ctx.arc(x: 95, y: 0, radius: 10, startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.stroke();
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0));
        ctx.arc(x: 0, y: 0, radius: 3, startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.fill();
        ctx.restore();
        
        ctx.beginPath();
        ctx.lineWidth = 14;
        ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#325FA2"));
        ctx.arc(x: 0, y: 0, radius: 142, startAngle: 0, endAngle: PI * 2, anticlockwise: true);
        ctx.stroke();
        
        ctx.restore();
        
        AnimationFrame.requestAnimationFrame(toLoop: { (timer) in
            self.clock(ctx: ctx)
        })
    }
    
    var particleCount = 400
    var particleLoopCount = 399
    var particles : [Particle] = []
    var minDist: Float = 70
    var dist: Float = 0
    
    
    var W: Int = 0
    var H: Int = 0
    
    // Function to paint the canvas black
    func paintCanvas(ctx: CanvasRenderingContext2D) {
        ctx.fillStyle = blackColor
        ctx.fillRect(x: 0,y: 0,width: Float(W),height: Float(H));
    }
    
    
    class Particle: NSObject{
        var x: Float
        var y: Float
        var vx: Float
        var vy: Float
        var radius: Float = 4
        var W: Int = 0
        var H: Int = 0
        var color: CanvasColorStyle.Color
        static var PI_TWO = Float.pi * 2
        init(width: Int, height: Int, color: CanvasColorStyle.Color) {
            W = width
            H = height
            x = Float.random(in: 0...1) * Float(W)
            y = Float.random(in: 0...1) * Float(H)
            vx = -1 + Float.random(in: 0...1) * 2;
            vy = -1 + Float.random(in: 0...1) * 2;
            self.color = color
        }
        
        
        
        func draw (ctx: CanvasRenderingContext2D) {
            ctx.fillStyle = color
            ctx.beginPath()
            ctx.arc(x: x, y: y, radius: Float(radius), startAngle: 0, endAngle: Particle.PI_TWO, anticlockwise: false);
            ctx.closePath()
            ctx.fill()
        }
    }
    
    func increaseParticles() {
        if(particleCount == 300){
            return
        }
        particleCount += 20
        let count = (20 - 1)
        for _ in 0...count {
            particles.append(Particle(width: W, height: H, color: whiteColor))
        }
        
    }
    
    func particle_draw(ctx: CanvasRenderingContext2D) {
        // increaseParticles()
        // Call the paintCanvas function here so that our canvas
        // will get re-painted in each next frame
        paintCanvas(ctx: ctx)
        
       // Call the function that will draw the balls using a loop
        let count = particleLoopCount
        for i in 0...count {
            p = particles[i]
            p.draw(ctx: ctx)
        }
        
        
        
        //Finally call the update function
        update(ctx: ctx)
        
        
    }
    
    var p: Particle = Particle(width: 0, height: 0, color: CanvasColorStyle.Color(color: UIColor(fromString: "white")))
    func update(ctx: CanvasRenderingContext2D) {
        
        // In this function, we are first going to update every
        // particle's position according to their velocities
        let count = particleLoopCount
        for i in 0...count {
            p = particles[i]
            
            // Change the velocities
            p.x += p.vx;
            p.y += p.vy
            
            // We don't want to make the particles leave the
            // area, so just change their position when they
            // touch the walls of the window
            if(Int(p.x + p.radius) > W){
                p.x = p.radius;
            }else if(p.x - p.radius < 0) {
                p.x = Float(W) - p.radius;
            }
            
            if(Int(p.y + p.radius) > H){
                p.y = p.radius;
            }else if(p.y - p.radius < 0) {
                p.y = Float(H) - p.radius;
            }
            
            // Now we need to make them attract each other
            // so first, we'll check the distance between
            // them and compare it to the minDist we have
            // already set
            
            // We will need another loop so that each
            // particle can be compared to every other particle
            // except itself
            
            for j in i...count{
                let p2 = self.particles[j]
                distance(ctx: ctx,p1: self.p, p2: p2)
            }
            
        }
    }
    
    let whiteColor = CanvasColorStyle.Color(color: UIColor(fromString: "white"))
    let blackColor = CanvasColorStyle.Color(color: UIColor(fromString: "black"))
    func distance(ctx:CanvasRenderingContext2D,p1: Particle, p2: Particle) {
        var colorIndex = 0
        let dx = p1.x - p2.x;
        let dy = p1.y - p2.y;
        
        //dist = Float.squareRoot(dx*dx + dy*dy)()
        dist = sqrt(dx*dx + dy*dy)
        
        // Draw the line when distance is smaller
        // then the minimum distance
        if(dist <= minDist) {
            // Draw the line
            ctx.beginPath()
            colorIndex = Int((100.0 * dist/minDist)) + 25
             ctx.strokeStyle = whiteColor
//            ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(hue: 2/360, saturation: CGFloat(colorIndex/100), brightness: 0.5, alpha: (CGFloat(1.2-dist/minDist))))
            ctx.moveTo(x: p1.x, y: p1.y)
            ctx.lineTo(x: p2.x, y: p2.y)
            ctx.closePath()
            ctx.stroke()
            
            // Some acceleration for the partcles
            // depending upon their distance
            let ax = dx/2000,
            ay = dy/2000;
            
            // Apply the acceleration on the particles
            p1.vx -= ax;
            p1.vy -= ay;
            
            p2.vx += ax;
            p2.vy += ay;
        }
        
    }
    
    
    func animloop(ctx: CanvasRenderingContext2D) {
         AnimationFrame.requestAnimationFrame(toLoop: {(_) in self.animloop(ctx: ctx)})
        particle_draw(ctx: ctx)
    }
    
    func particleAnimation(ctx: CanvasRenderingContext2D){
        ctx.getCanvas().handleInvalidationManually =  true
        W = Int(ctx.getCanvas().width)
        H = Int(ctx.getCanvas().height)
        //  particles =  Array(repeating: Particle(width: W, height: H, color: whiteColor), count: particleCount)
        let count = (particleCount - 1)
        for _ in 0...count {
            particles.append(Particle(width: W, height: H, color: whiteColor))
        }
        animloop(ctx:ctx)
    }
    
    
    
    class Ellipses {
        var angle: Float = 0
        
        
        func draw(ctx: CanvasRenderingContext2D) {
            let width = ctx.getCanvas().width
            let height = ctx.getCanvas().height
            ctx.clearRect(x: 0, y: 0, width: width, height: height);
            var count = 0;
            
            for i in stride(from: 0, to: 360, by: 6) {
                ctx.beginPath();
                ctx.ellipse(
                    x: Float(width/2),
                    y: Float(height/2),
                    radiusX: 15, radiusY: 235,
                    rotation: Float(Int(angle) + i) * Float.pi / 180,
                    startAngle: 0, endAngle: 2 * .pi
                );
                
                switch(count) {
                case 0:
                    ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#008000"))
                case 1:
                    ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#0000ff"))
                case 2:
                    ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#ff0000"))
                case 3:
                    ctx.strokeStyle = CanvasColorStyle.Color(color: UIColor(fromHex: "#800080"))
                default: break
                    
                }
                
                ctx.stroke()
                ctx.closePath()
                
                if (count == 3){
                    count = 0;
                } else {
                    count+=1
                }
            }
            
            angle+=1;
            
            if (angle == 361) {angle = 0;}
        };
    }
    
    func runEllipse(ctx: CanvasRenderingContext2D) {
        let ellipse = Ellipses()
        AnimationFrame.requestAnimationFrame(toLoop: { (_) in
            self.ellipseAnimation(ctx: ctx, ellipse: ellipse)
        })
    }
    func ellipseAnimation(ctx: CanvasRenderingContext2D, ellipse: Ellipses){
        ellipse.draw(ctx: ctx)
        AnimationFrame.requestAnimationFrame(toLoop: { (_) in
            self.ellipseAnimation(ctx: ctx, ellipse: ellipse)
        })
    }
    
    
    
    class ColorSquares{
        
        
        func draw(ctx: CanvasRenderingContext2D) {
            let width = ctx.getCanvas().width
            let height = ctx.getCanvas().height
            ctx.clearRect(x: 0, y: 0, width: width, height: height);
            
            for i in 0...23 {
                for j in 0...23 {
                    drawRect(ctx: ctx,x: Float(i), y: Float(j));
                }
            }
        }
        
        func drawRect(ctx: CanvasRenderingContext2D, x: Float, y:Float) {
            let red = randomHue()/255
            let green = randomHue()/255
            let blue = randomHue()/255
            
            ctx.beginPath();
            ctx.rect(x: (x * 25) , y: (y * 25) , width: Float(24 ) , height: Float(24 ));
            ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0))
            ctx.fill();
        }
        
        func randomHue() -> Double {
            
            let num = floor(.random(in: 0...1) * 256) + 1
            return num
        }
    }
    func colorSquares(ctx: CanvasRenderingContext2D){
        let squares = ColorSquares()
        squares.draw(ctx: ctx)
    }
}
