import 'package:bad_dad_jokes/dad_types.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Joke extends StatelessWidget {
  final text;
  final DadTypes typeOfDad;

  const Joke({Key key, this.text, this.typeOfDad}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: typeOfDad.color, // Colors.white24,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QuoteImage(),
            Text(
              '$text',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Roboto slab', fontSize: 25.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'A ${typeOfDad.name} Dad',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'League spartan', color: Colors.blueAccent),
              ),
            ),
            QuoteImage(
              isTopImage: false,
            )
          ],
        ),
      ),
    );
  }
}

class QuoteImage extends StatelessWidget {
  final bool isTopImage;

  const QuoteImage({Key key, this.isTopImage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Padding(
        padding: EdgeInsets.only(
            top: isTopImage ? 0.0 : 10.0, bottom: isTopImage ? 10.0 : 0.0),
        child: Align(
          alignment: isTopImage ? Alignment.topLeft : Alignment.bottomRight,
          child: SizedBox(
            child: FadeInImage(
              fadeInDuration: Duration(milliseconds: 300),
              placeholder: MemoryImage(kTransparentImage),
              fadeInCurve: Curves.easeInOut,
              image: AssetImage(
                isTopImage
                    ? 'assets/images/left-quote.png'
                    : 'assets/images/right-quote.png',
              ),
            ),
            height: 80,
          ),
        ),
      ),
    );
  }
}
