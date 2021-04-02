import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_supervisor.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';

class DialogoVisualizarSupervisor extends StatefulWidget {
  
  Supervisor supervisor = new Supervisor();
  
  DialogoVisualizarSupervisor({this.supervisor});

  @override
  _DialogoVisualizarSupervisorState createState() => _DialogoVisualizarSupervisorState();
}

class _DialogoVisualizarSupervisorState extends State<DialogoVisualizarSupervisor> {
  
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: temaFormularios(),  
        child: 
        Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          width: 800.0,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.1)),
                    color: kPrimaryColor,
                  ),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Supervisor',
                         textAlign: TextAlign.left,
                         style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: (){
                          Navigator.pop(context, widget.supervisor);
                        },
                  ),
                    ],
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:40.0),
                  child: FormSupervisorInformation(
                    supervisor: widget.supervisor,
                    enabled: false,
                    ),
                ),
               ],
              ),
           ]
          ),
        ),
      ),
    );
  }
}
