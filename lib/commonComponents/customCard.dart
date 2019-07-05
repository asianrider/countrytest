import 'package:flutter/material.dart';
import '../task.dart';
import '../model/Country.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.title, this.description});

  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    print("Bulding CustomCard...");
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Text(title),
                FlatButton(
                    child: Text("See More"),
                    onPressed: () {
                      /** Push a named route to the stcak, which does not require data to be  passed */
                      // Navigator.pushNamed(context, "/task");

                      /** Create a new page and push it to stack each time the button is pressed */
                      // Navigator.push(context, MaterialPageRoute<void>(
                      //   builder: (BuildContext context) {
                      //     return Scaffold(
                      //       appBar: AppBar(title: Text('My Page')),
                      //       body: Center(
                      //         child: FlatButton(
                      //           child: Text('POP'),
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ));

                      /** Push a new page while passing data to it */
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskPage(
                                  title: title, description: description)));
                    }),
              ],
            )));
  }
}


class CountryTile extends StatelessWidget {
  CountryTile(this.country) ;

  final Country country;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/flags/64/' + country.isoA2 + '.png'),
      title:  Container(
          child: Text(country.name + ' (' + country.isoA2 + ')'),
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
      subtitle: Text(country.adm0A3),
      trailing: Icon(Icons.keyboard_arrow_right),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      onTap: () { showDetail(context); },
    );
  }

  void showDetail(BuildContext context) {
    print(country.name);
     Navigator.push(context, MaterialPageRoute<void>(
       builder: (BuildContext context) {
         return Scaffold(
           appBar: AppBar(title: Text(country.name)),
           body: CountryForm(country),
         );
       },
     ));
  }
}

// Define a custom Form widget.
class CountryForm extends StatefulWidget {
  final Country country;

  CountryForm(this.country);

  @override
  CountryFormState createState() {
    return CountryFormState(country);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CountryFormState extends State<CountryForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final Country country;

  CountryFormState(this.country);

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: country.name,
              decoration: InputDecoration(
                  labelText: 'Country name'
              ),
              onSaved: (value) => country.name = value,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                    country.updateValues();
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),// Build this out in the next steps.
    ),
    );
  }
}
