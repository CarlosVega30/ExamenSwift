//
//  ContentView.swift
//  ExamenSwift
//
//  Created by CCDM18 on 14/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let CoreDM: CoreDataManager
    @State var idEmp=""
    @State var empNombre=""
    @State var domicilio=""
    @State var telefono=""
    @State var puesto=""

    @State var seleccionado:Empleado?
    @State var empArray=[Empleado]()
    
    var body: some View {
        VStack{
            TextField("ID", text: $idEmp).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Nombre del Empleado", text: $empNombre).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Domicilio", text: $domicilio).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Telefono", text: $telefono).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Puesto", text: $puesto).textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save"){
                if(seleccionado != nil){
                    seleccionado?.idEmp=idEmp
                    seleccionado?.empNombre=empNombre
                    seleccionado?.domicilio=domicilio
                    CoreDM.actualizaraEmpleado(empleado: seleccionado!)
                }else{
                    CoreDM.guardarEmpleado(idEmp: idEmp, empNombre: empNombre, domicilio: domicilio, telefono: telefono, puesto: puesto)
                }
                mostrarEmpleado()
                idEmp=""
                empNombre=""
                domicilio=""
                telefono=""
                puesto=""
            }
            List{
                ForEach(empArray,id: \.self){
                    emp in
                    VStack{
                        Text(emp.idEmp ?? "")
                        Text(emp.empNombre ?? "")
                        Text(emp.domicilio ?? "")
                        Text(emp.telefono ?? "")
                        Text(emp.puesto ?? "")
                    }.onTapGesture{
                        seleccionado=emp
                        idEmp=emp.idEmp ?? ""
                        empNombre=emp.empNombre ?? ""
                        domicilio=emp.domicilio ?? ""
                        telefono=emp.telefono ?? ""
                        puesto=emp.puesto ?? ""
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    indexSet.forEach({index in let empleado = empArray[index]
                        CoreDM.borrarEmpleado(empleado: empleado)
                            mostrarEmpleado()
                    })
                })
            }
            Spacer()
        }.padding()
            .onAppear(perform:{
                        mostrarEmpleado()
            })
    }
    func mostrarEmpleado(){
        empArray=CoreDM.leerTodosLosEmpleados()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(CoreDM:CoreDataManager())
    }
}
