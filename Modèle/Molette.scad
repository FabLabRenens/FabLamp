//Définition globale (augmenter pour l'exportation ~100-200)
def = 20;
//Définition des ergots
def2 = 10;

//Molette
facettes = 14;

//Caractéristiques du gobelets
d1 = 70.1; //Diamètre de la grande base du tronc
d2 = 45; //Diamètre de la petite base
h = 98.8; //Hauteur du tronc de cône
ep = 5.7; //Épaisseur approximative de la collerette du gobelet

//Afficher les différents modules séparément
//gobelet();
//breadboard();
//potentiometre();
//piles();
//molette();
final();

module gobelet(){
      color([1, 1, 1])
      difference(){   
            //Partie extérieure
            cylinder(d1=d1, d2=d2, h=h, $fn=def);
            //Partie intérieure
            translate([0, 0, -1]) cylinder(d1=d1-ep, d2=d2-0.2, h=h, $fn=def);
      }
}

module breadboard(){
      color([1, 0, 0])
      union(){
            cube([45.7, 34.6, 9.4]);
            //Petite avancée pour le passage des composants et fils
            translate([1, 0, -4]) cube([43.7, 34.6, 4.1]); 
      }
}

module potentiometre(){
      color([0, 1, 0])
      union(){
            translate([0, 0, -1]) cylinder(d1=10.2, d2=10.2, h=22, $fn=def);
            translate([0, 0, 13.72/2+9]) cube([16.35, 18.25, 13.72], center = true);
      }
}
      
module piles(){
      color([0, 0, 1])
      union(){
            cube([13.1, 25.6, 53]);
            translate([12.9, 25.6/2, 0]) scale([1, 1.3, 1]) cylinder(d1=14, d2=14, h=53, $fn=def);
      }
}


module molette(){
      color([0.5, 0.5, 0.5])
      difference(){
      
            //Cylindre de base
            cylinder(d1=80, d2=80, h=20, $fn=facettes);        
            //Soustraction...
            union(){
                  
                  //Des crans de la molette
                  for (a =[0:facettes-1]){        
                        rotate([0, 0, a*(360/facettes)]) translate([0, 77/2+1.5, 2]) scale([1, 0.3,1]) cylinder(d1=17, d2=17, h=22, $fn=def);
                  }
            
                  //Du gobelet
                  translate([0, 0, 17]) gobelet();
                  
                  //De la breadboard
                  rotate([90, 0, 0]) translate([-45.7/2, 1, 12.7]) breadboard();
                  
                  //Du potentiomètre
                  potentiometre();
                  
                  //Du porte-pile
                  translate([9.8, -8.75, 1]) piles();
                  
                  //D'un trou dans la zone pleine pour utiliser moins de plastique et réduire le temps d'impression 3D
                  hull(){
                        translate([-20, 4, -1]) cylinder(d1=20, d2=20, h=22, $fn=def);
                        translate([-2.5, 20, -1]) cylinder(d1=20, d2=20, h=22, $fn=def);
                  }       
            }//Union        
      }//Difference     
}

module final(){
      //Ajout de trois ergots à la molette         
      union(){
            color([0.5, 0.5, 0.5])
            molette();
            
            color([1, 1, 1])
            difference(){
                  //Anneau
                  translate([0, 0, 19.4]) rotate_extrude(convexity = 10, $fn=def) translate([77/2 - 3.5, 0, 0]) circle(r = 1, $fn=def2);
                  
                  //Soustraction...
                  union(){
                        //Du même anneau vers le bas
                        translate([0, 0, 18.5]) rotate_extrude(convexity = 10, $fn=def) translate([77/2-4, 0, 0]) circle(r = 1.2, $fn=def2);
                        //De trois portions
                        for (a =[0:2]){
                              rotate([0, 0, a*120]) translate([0, 20, 20]) cube([50, 40, 10], center = true);
                        }
                  }//Union
            }//Difference
      }//Union
}