//
//  Home.swift
//  UI-328 (iOS)
//
//  Created by nyannyan0328 on 2021/10/12.
//

import SwiftUI

struct Home: View {
    @State var wish = false
    
    @State var finishWish = false
    var body: some View {
        ZStack{
            VStack{
                
                Image("cake")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame( height: getRect().width / 1.8)
                
                Text("Happy Birthday\nJacob degrom")
                    .font(.custom("Sketch 3D", size: 35))
                    .kerning(2)
                    .lineSpacing(10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.purple)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                
                
                Button {
                    
                   doAnimation()
                    
                } label: {
                    
                    Text("Wish")
                        .kerning(2)
                        .font(.custom("Sketch 3D", size: 15))
                        .foregroundColor(.white)
                        .padding(.vertical,12)
                        .padding(.horizontal,50)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        .cornerRadius(10)
                    
                    
                }
                .disabled(wish)

                
                
            }
            
            
            EmitterView()
                .scaleEffect(wish ? 1 : 0,anchor: .top)
                .opacity(wish && !finishWish ? 1  : 0 )
                .offset(y: wish ? 0 : getRect().height / 2)
                .ignoresSafeArea()
        }
    }
    
    func doAnimation(){
        
        withAnimation(.spring()){
            
            wish = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            
            withAnimation(.easeInOut(duration: 1.5)){
                
                finishWish = true
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                
                finishWish = false
                wish = false
                
            }
            
        
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct EmitterView : UIViewRepresentable{
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmiterCells()
        
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        
        return view
            
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func createEmiterCells()->[CAEmitterCell]{
        
        var emitterCells : [CAEmitterCell] = []
        
        for index in 1...12{
            let cell = CAEmitterCell()
            
            cell.contents = UIImage(named: getImage(index: index))?.cgImage
            
            cell.color = getColor().cgColor
            
            cell.birthRate = 4.5
            cell.lifetime = 20
            
            cell.velocity = 120
            
            cell.scale = 0.2
            cell.scaleRange = 0.3
            
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.spinRange = 3.5
            cell.spin = 1
            cell.yAcceleration = 40
            
            emitterCells.append(cell)
        }
        return emitterCells
        
    }
    
    func getColor()->UIColor{
        
        
        let colors : [UIColor] =
        [.systemRed,.systemBlue,.systemMint,.systemYellow,.systemPurple]
        
            
        return colors.randomElement()!
        
      
    }
    
    func getImage(index : Int)->String{
        
        
        if index < 4{
            
            return "rectangle"
        }
        else if index > 5 && index <= 8{
            
            return "circle"
        }
        
        else{
            
            return "triangle"
        }
    }
}
