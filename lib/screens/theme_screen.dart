import 'package:flutter/material.dart';
import 'package:meal_app/provider/theme_prov.dart';
import 'package:meal_app/widgets/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemeScreen extends StatelessWidget {
  static const String routName = 'themes';
  final bool onPageview;
  ThemeScreen({this.onPageview=false});

  Widget buildListTile(text,BuildContext ctx){
    var primary= Provider.of<ThemeProv>(ctx,listen: true).primaryColor;
    var accent= Provider.of<ThemeProv>(ctx,listen: true).accentColor;
    return ListTile(
      title: Text('Choose your $text color',
      style: Theme.of(ctx).textTheme.subtitle1,
      ),
      trailing: CircleAvatar(
        backgroundColor: text== 'primary'? primary:accent,
      ),
      onTap: (){
        showDialog(context: ctx, builder: (ctx){
          return AlertDialog(
            title: Text('Choose Color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                colorPickerWidth: 300,
                pickerAreaHeightPercent: .8,
                enableAlpha: false,
                labelTypes: [],
                displayThumbColor: true,
                pickerColor: text=='primary'? Provider.of<ThemeProv>(ctx,listen: true).primaryColor:
                Provider.of<ThemeProv>(ctx,listen: true).accentColor,
                onColorChanged: (newColor){
                  Provider.of<ThemeProv>(ctx,listen: false).onChange(newColor, text);
                },
              ),
            ),
          );
        });
      },
    );
  }

  Widget buildRadioListTile(ThemeMode thVal, Icon icon, text, BuildContext ctx) {
    return RadioListTile(
      activeColor:Theme.of(ctx).accentColor,
      title: Text(text),
      secondary: icon,
      value: thVal,
      groupValue: Provider.of<ThemeProv>(ctx,listen: true).th,
      onChanged: (newThemeVal) {
        print('New Theme: $newThemeVal');
        Provider.of<ThemeProv>(ctx,listen: false).themeModeChange(newThemeVal);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor=Theme.of(context).textTheme.subtitle1.color;
    return Scaffold(
      appBar:onPageview?AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,leading: Container(),)
      :AppBar(
        title: Text('Themes'),
        // backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Choose your Theme',
              style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center,
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildRadioListTile(ThemeMode.system, null, 'system', context),
              buildRadioListTile(
                  ThemeMode.light,
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: iconColor,
                  ),
                  'light',
                  context),
              buildRadioListTile(
                  ThemeMode.dark,
                  Icon(
                    Icons.dark_mode,
                    color: iconColor,
                  ),
                  'dark',
                  context),
              buildListTile('primary',context),
              buildListTile('accent',context),
              SizedBox(height: onPageview?100:0,)

            ],
          )
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
