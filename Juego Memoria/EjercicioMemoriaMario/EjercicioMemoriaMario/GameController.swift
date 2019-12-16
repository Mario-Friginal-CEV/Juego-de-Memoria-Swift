//
//  GameController.swift
//  EjercicioMemoriaMario
//
//  Created by alumnos on 18/11/2019.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit


class GameController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var errors = 0
    @IBOutlet weak var errorsText: UILabel!
    var images : [UIImage] = [#imageLiteral(resourceName: "ak47"),#imageLiteral(resourceName: "aug"),#imageLiteral(resourceName: "awp"),#imageLiteral(resourceName: "galil"),#imageLiteral(resourceName: "m4a1"),#imageLiteral(resourceName: "m4a1s"),#imageLiteral(resourceName: "mp9"),#imageLiteral(resourceName: "scout"),#imageLiteral(resourceName: "usp")]
    public var randPositions = [Int]()
    @IBOutlet weak var finishGameText: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var goOutButton: UIButton!
    
    //Funcion que procesa el numero de celdas que se van a generar en el ollection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    //Funcion que muestra las imagenes en las celdas, en el orden que estaban colocadas en el array
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "Mycell", for: indexPath) as! myCell
        cel.myImageCell.image = self.images[indexPath.row]
        return cel
    }
    
    //Funcion que se activa cuando se presiona encima de una celda
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let celda = collectionView.cellForItem(at: indexPath)  as! myCell
        //Comprueba si la posición de la celda es la misma que la del array random
        if self.randPositions.count != 0{
            if self.randPositions[0] == indexPath.row {
                //Si es correcta la respuesta, la celda desaparece lentamente con un degradado, y esa zona de celda se vuelve inactiva
                celda.myImageCell.alpha = 1;
                UIView.animate(withDuration: 0.5, animations: {
                    celda.myImageCell.alpha = 0;
                }) { (ok) in
                    celda.isHidden = true
                }
                self.randPositions.remove(at: 0)
            }else{
                //
                errors+=1
                errorsText.text = String(errors)
            }
        }
        
       isEndgame()

    }
    //Función que comprueba cada vez que se ha tocado una celda, si ha finalizado el juego y de esta forma mostrar un mensaje final, y activar los botones de jugar de nuevo o salir de la aplicación
    func isEndgame (){
        if randPositions.count == 0 {
            finishGameText.isHidden = false
            playAgainButton.isHidden = false
            goOutButton.isHidden = false
            errorsText.isHidden = true
            if errors>10{
                finishGameText.text = "Te has equivocado " + String(errors) + " veces. Tienes muchos fallos, intentalo de nuevo"
            }else if(errors == 0){
                finishGameText.text = "LO HAS HECHO PERFECTO, SIGUE ASI!!"
            }else{
                finishGameText.text = "No esta mal, pero los he visto mejores... lo has conseguido con " + String (errors) + " errores"
            }
        }
    }
    
    //Funcion que se ejecuta cuando se presiona el boton, y te saca de la app
    @IBAction func goOutApp(_ sender: UIButton) {
        exit(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
