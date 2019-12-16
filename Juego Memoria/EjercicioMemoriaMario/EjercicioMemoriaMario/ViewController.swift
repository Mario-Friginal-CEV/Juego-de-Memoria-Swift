//
//  ViewController.swift
//  EjercicioMemoriaMario
//
//  Created by alumnos on 18/11/2019.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var images : [UIImage] = [#imageLiteral(resourceName: "ak47"),#imageLiteral(resourceName: "aug"),#imageLiteral(resourceName: "awp"),#imageLiteral(resourceName: "galil"),#imageLiteral(resourceName: "m4a1"),#imageLiteral(resourceName: "m4a1s"),#imageLiteral(resourceName: "mp9"),#imageLiteral(resourceName: "scout"),#imageLiteral(resourceName: "usp")]
    
    var randPositions = [Int]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageNumber: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomImages()
        showImages()
        self.playButton.isHidden = true
        self.resetButton.isHidden = true
    }
    
    //Método que selecciona aleatoriamente el orden del array de imagenes
    func randomImages(){
        var i = 0
        for(_) in images {
            randPositions.append(i)
            i+=1
        }
        randPositions.shuffle()
    }
    
    //Metodo que reproduce las imagenes que hay en el array(con unos paramatros como en este caso el tiempo de cambio entre imagenes), tomando como indice los numeros que son generados por el metodo anterior. Tambien suma un +1 por cada foto en el label de la parte superior, y cuando finaliza se vuelven visibles los botones
    func showImages(){
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true, block: { timer in
            if i < self.randPositions.count{
                self.imageView.image = self.images[self.randPositions[i]]
                self.imageNumber.text = String(i+1)
            }
            i+=1
            if i == self.images.count{
                self.playButton.isHidden = false
                self.resetButton.isHidden = false
            }
        })
    }
    
    //Metodo que cuando presionas el boton se reinicia la exposición de la secuencia de imagenes, y vuelve a ocultar los botones
    @IBAction func resetSecuence(_ sender: UIButton) {
        showImages()
        self.playButton.isHidden = true
        self.resetButton.isHidden = true
    }
    
    //Creo us segue para pasar la informacion de la varaible de randPositions al scrip de GameController para poder ser usado alli
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passToCollection" {
            let destinationViewController = segue.destination as! GameController
            destinationViewController.randPositions = self.randPositions
        }
    }
}
