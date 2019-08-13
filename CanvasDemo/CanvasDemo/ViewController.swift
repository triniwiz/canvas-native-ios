import UIKit
import CanvasNative
class ViewController: UIViewController {
    var canvas1: Canvas?
    var canvas2: Canvas?
    var imageView: UIImageView?
    let PI: Float = .pi
    let TWO_PI: Float = .pi * 2
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var second: UIView!
    @IBOutlet weak var third: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scale = Int(UIScreen.main.scale)
        // Do any additional setup after loading the view.
        canvas1 = Canvas(frame: first.bounds)
        first.addSubview(canvas1!)
    }
    
    var drawn = false
    func drawAll() {
        let ctx = canvas1?.getContext(type: "2d") as! CanvasRenderingContext2D
        _ = canvas1?.ensureIsContextIsCurrent()
        arcToAnimationExample(ctx: ctx)
    }
    
    
    func draw1() {
        let ctx = canvas1?.getContext(type: "2d") as! CanvasRenderingContext2D
        _ = canvas1?.ensureIsContextIsCurrent()
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
    
    
    func saveRestoreExample(ctx: CanvasRenderingContext2D){
        // Save the default state
        ctx.save();
        
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 0, green: 128/255, blue: 0, alpha: 1.0));
        ctx.fillRect(x: 10, y: 10, width: 100, height: 100);
        
        // Restore the default state
        ctx.restore();
        
        ctx.fillRect(x: 150, y: 40, width: 100, height: 100);
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
        ctx.clearRect(x: 0, y: 0, width: getCanvasWidth(canvas: ctx.getCanvas()), height: getCanvasHeight(canvas: ctx.getCanvas()))
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
        ctx.beginPath();
        ctx.arc(x: p.x, y: p.y, radius: 2, startAngle: 0, endAngle: TWO_PI);
        ctx.fill();
        var text = String(i) + ":"
        text = text + String(Int(p.x)) + ","
        text = text + String(Int(p.y))
        ctx.fillText(text: text, x: p.x + x, y: p.y + y);
    }
    
    private func drawPoints(ctx: CanvasRenderingContext2D, points: [KeyValue]){
        for i in 0...points.count - 1 {
            textPoint(ctx: ctx,p: points[i], offset: KeyValue( x: 0, y: -20 ) , i: i)
        }
    }
    
    private func drawArc(ctx: CanvasRenderingContext2D, points: [KeyValue], r: Float){
        ctx.beginPath();
        let p0 = points[0]
        let p1 = points[1]
        let p2 = points[2]
        ctx.moveTo(x: p0.x, y: p0.y);
        ctx.arcTo(x1: p1.x, y1: p1.y, x2: p2.x, y2: p2.y, radius: r);
        ctx.lineTo(x: p2.x, y: p2.y);
        ctx.stroke();
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
        
        ctx.stroke();
        
    }
    private func loop(ctx: CanvasRenderingContext2D, t: Float){
        let PI2 = TWO_PI
        let points = [p1,p2,p3]
        let t0 = t/1000;
        let a  = t0.truncatingRemainder(dividingBy: PI2);
        let rr = abs(cos(a) * r);
        ctx.clearRect(x: 0, y: 0, width: getCanvasWidth(canvas: ctx.getCanvas()),height: getCanvasHeight(canvas: ctx.getCanvas()));
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
        ctx.fillStyle = CanvasColorStyle.Color(color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3))
        let width = canvas.frame.width
        let height = canvas.frame.height
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
    
    let p1 = KeyValue( x: 100 , y: 100 )
    let p2 = KeyValue( x: 150 , y: 50 )
    let p3 = KeyValue( x: 200 , y: 100 )
    var t = Float(0.0)
    
    
    func arcToAnimationExample(ctx: CanvasRenderingContext2D){
        loop(ctx: ctx, t: 0.0)
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
        let width = Float(ctx.getCanvas().frame.size.width )
        let height = Float(ctx.getCanvas().frame.size.height )
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
            print(FileManager.default.fileExists(atPath: rhino.path))
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
            let sun_url = NSURL(fileURLWithPath: NSHomeDirectory() + "/Canvas_sun.png")
            let moon_url = NSURL(fileURLWithPath: NSHomeDirectory() + "/Canvas_moon.png")
            let earth_url = NSURL(fileURLWithPath: NSHomeDirectory() + "/Canvas_earth.png")
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
    
    var particleCount = 100
    var particles : [Particle] =  []
    var minDist: Float = 70
    var dist: Float = 0
    
    
    var W: Int = 0
    var H: Int = 0
    
    // Function to paint the canvas black
    func  paintCanvas(ctx: CanvasRenderingContext2D) {
        // Set the fill color to black
        ctx.fillStyle = CanvasColorStyle.Color(color: .black)
        
        // This will create a rectangle of white color from the
        // top left (0,0) to the bottom right corner (W,H)
        ctx.fillRect(x: 0,y: 0,width: Float(W),height: Float(H));
    }
    
    
    class Particle{
        var x: Float
        var y: Float
        var vx: Float
        var vy: Float
        var radius: Float = 4
        var W: Int = 0
        var H: Int = 0
        init(width: Int, height: Int) {
            W = width
            H = height
            x = Float.random(in: 0...1) * Float(W)
            y = Float.random(in: 0...1) * Float(H)
            
            vx = -1 + Float.random(in: 0...1) * 2;
            vy = -1 + Float.random(in: 0...1) * 2;
        }
        
        
        
        func draw (ctx: CanvasRenderingContext2D) {
            ctx.fillStyle = CanvasColorStyle.Color(color: .white);
            ctx.beginPath();
            ctx.arc(x: x, y: y, radius: Float(radius), startAngle: 0, endAngle: .pi * 2, anticlockwise: false);
            
            // Fill the color to the arc that we just created
            ctx.fill();
        }
    }
    
    
    func particle_draw(ctx: CanvasRenderingContext2D) {
        
        // Call the paintCanvas function here so that our canvas
        // will get re-painted in each next frame
        paintCanvas(ctx: ctx)
        
        // Call the function that will draw the balls using a loop
        let count = (particleCount - 1)
        for i in 0...count {
            p = particles[i]
            p.draw(ctx: ctx);
        }
        
        //Finally call the update function
        update(ctx: ctx);
    }
    
    var p: Particle = Particle(width: 0, height: 0)
    func update(ctx: CanvasRenderingContext2D) {
        
        // In this function, we are first going to update every
        // particle's position according to their velocities
        let count = (particleCount - 1)
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
            
            let count = (particleCount - 1)
            for j in i...count{
                let p2 = particles[j];
                distance(ctx: ctx,p1: p, p2: p2);
            }
            
        }
    }
    
    
    func distance(ctx:CanvasRenderingContext2D,p1: Particle, p2: Particle) {
        var colorIndex = 0
        let dx = p1.x - p2.x;
        let dy = p1.y - p2.y;
        
        dist = Float.squareRoot(dx*dx + dy*dy)()
        
        // Draw the line when distance is smaller
        // then the minimum distance
        if(dist <= minDist) {
            // Draw the line
            ctx.beginPath();
            colorIndex = Int((100.0 * dist/minDist)) + 25
            ctx.strokeStyle =  CanvasColorStyle.Color(color: .white)
            //        ctx.strokeStyle =   CanvasColorStyle.Color(color: UIColor(hue: 2/360, saturation: CGFloat(colorIndex/100), brightness: 0.5, alpha: (CGFloat(1.2-dist/minDist))))
            ctx.moveTo(x: p.x, y: p.y)
            ctx.lineTo(x: p2.x, y: p2.y);
            ctx.stroke();
            
            // Some acceleration for the partcles
            // depending upon their distance
            var ax = dx/2000,
            ay = dy/2000;
            
            // Apply the acceleration on the particles
            p1.vx -= ax;
            p1.vy -= ay;
            
            p2.vx += ax;
            p2.vy += ay;
        }
    }
    
    
    func animloop(ctx: CanvasRenderingContext2D) {
        particle_draw(ctx: ctx);
        AnimationFrame.requestAnimationFrame(toLoop: {(_) in self.animloop(ctx: ctx)})
    }
    
    func particelAnimation(ctx: CanvasRenderingContext2D){
        W = Int(getCanvasWidth(canvas: ctx.getCanvas())  )
        H = Int(getCanvasHeight(canvas: ctx.getCanvas()) )
        let count = (particleCount - 1)
        for _ in 0...count {
            particles.append(Particle(width: W, height: H))
        }
        print("particles", particles.count)
        
        animloop(ctx:ctx)
    }
    
    
    
    class Ellipses {
        var angle: Float = 0
        
        
        func draw(ctx: CanvasRenderingContext2D) {
            let width = Float(ctx.getCanvas().frame.width )
            let height = Float(ctx.getCanvas().frame.height  )
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
            let width = Float(ctx.getCanvas().frame.width )
            let height = Float(ctx.getCanvas().frame.height  )
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
