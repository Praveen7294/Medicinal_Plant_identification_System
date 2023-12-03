import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image;
  late List _outputs;
  late String output1;
  final picker = ImagePicker();

  loadModel() async {
    await Tflite.loadModel(
        labels: 'assets/labels.txt', model: 'assets/model_unquant.tflite');
  }

  pickedImageCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickedImageGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _outputs = output!;
      output1 = '${_outputs[0]['label']}';
      output1 = output1.substring(2,output1.length);
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Forest.jpg'),
                fit: BoxFit.cover
              )
            ),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.green.withOpacity(0.9),
              child: const Text(
                "Arogyam",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                            child: _loading == true
                                ? Container(
                              width: MediaQuery.of(context).size.width-200,
                                child: Column(
                                  children: const [
                                    Text("Wellness Lies In Nature's Wisdom",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 37,
                                      ),
                                    ),
                                    SizedBox(height: 40,)
                                  ],
                                )
                            )
                                : Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.file(
                                              _image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        _outputs != null
                                            ? GestureDetector(
                                          child: Text(
                                            output1,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          onTap: (){
                                            Navigator.pushReplacementNamed(context, '/result', arguments: {
                                              'rsoutput' : output1,
                                              'Aloevera': 'Aloe vera gel contains various long-chain sugars (polysaccharides) such as acemannan, which are believed to have immune-boosting and anti-inflammatory properties. Aloe vera contains compounds like aloin and emodin, which have natural laxative effects. These compounds can aid in digestion and relieve constipation. Aloe vera contains a variety of amino acids, including seven of the eight essential amino acids that the body cannot produce on its own. Amino acids are the building blocks of proteins and play various roles in the body. Aloe vera contains a variety of amino acids, including seven of the eight essential amino acids that the body cannot produce on its own. Amino acids are the building blocks of proteins and play various roles in the body. Aloe vera contains enzymes such as amylase and lipase, which can aid in digestion. Aloe vera is perhaps best known for its skin-healing properties. It can be used to soothe sunburn, minor burns, insect bites, and skin irritations. Aloe vera gel is applied topically to promote wound healing and reduce inflammation. Aloe vera can be used as a natural remedy for digestive issues. It may help alleviate symptoms of acid reflux, indigestion, and irritable bowel syndrome. Some compounds in aloe vera may have a mild laxative effect.',
                                              'Amla': 'Amla is one of the richest natural sources of vitamin C (ascorbic acid). Vitamin C is a powerful antioxidant that plays a crucial role in boosting the immune system and promoting healthy skin. Amla contains various polyphenolic compounds, including flavonoids, tannins, and ellagic acid. Polyphenols have antioxidant properties and contribute to the overall health benefits of amla. Amla contains minerals such as calcium, phosphorus, iron, and potassium, which are essential for various physiological functions in the body. Amla contains several essential and non-essential amino acids, which are the building blocks of proteins. Amino acids are vital for processes such as protein synthesis and enzyme function. Amla contains carbohydrates, including sugars and dietary fiber. Dietary fiber is important for digestive health. Amla contains various bioactive compounds, including alkaloids, phyllantin, quercetin, and gallic acid, which contribute to its medicinal properties. Amla contains pectin, a type of soluble fiber that helps in digestion and has cholesterol-lowering effects. Like most fruits, amla has a high water content, which helps keep the body hydrated.',
                                              'Amrutha Balli': 'tannins, alkaloids, flavonoids, glycosides, saponins and steroids. The active principles found in the powder of it are supposed to be antioxidant, antimicrobial, antitoxic, antidiabetic, anticancer, antistress, anti-inflammatory, anti-allergic etc.Amrutha Balli Powder is renowned for the treatment of diabetes, urinary tract conditions, kidney infections, asthma, cardiac conditions, amongst others. It is rich in antioxidants and has anti-viral and healing properties. It helps boost your immunity and helps battle several chronic conditions.',
                                              'Ashoka': 'Ashoka bark and leaves contain flavonoids, which are known for their antioxidant properties. Flavonoids, such as quercetin and kaempferol, are abundant in the plant. Ashoka is rich in tannins, which have astringent properties. Tannins can help tone and tighten tissues, making them useful in traditional medicine. Phytosterols, including beta-sitosterol, are found in the plant and have been studied for their potential health benefits. Phytosterols, including beta-sitosterol, are found in the plant and have been studied for their potential health benefits.  Alkanes, esters, and other compounds are also present in the chemical composition of Ashoka. Ashoka is particularly known for its traditional use in promoting womens reproductive health. It is believed to have astringent properties that can help in cases of excessive uterine bleeding, menstrual disorders, and uterine infections. It is used as a uterine tonic. The plants bioactive compounds, including flavonoids, may have anti-inflammatory properties, which can help reduce inflammation in various parts of the body. Ashoka has been used traditionally for its wound-healing properties. The application of Ashoka bark paste or decoction to wounds is believed to promote faster healing.',
                                              'Peepal': 'Peepal tree leaves contains chemicals such as Glucose, Asteriod and Mennos,Phenolic while its bark is rich in Vitamin K, tainen and Phaetosteroline. All of these ingredients make the peepal tree an exceptional medicinal tree. Its bark is used in traditional medicine for its analgesic and anti-inflammatory properties. Fruits of this plant contain numerous amino acids whereas the fig of this plant has been reported to contain the highest amount of serotonin than other Ficus speciesthe leaf juice of the peepal tree may be helpful for cough, asthma, diarrhoea, ear pain, toothache, haematuria (blood in urine), migraine, scabies, eye troubles, and gastric problems. The stem bark of the peepal tree might help with paralysis, gonorrhoea, bone fractures, diarrhoea, and diabetes.',
                                              'Ashwagandha': 'Ashwagandha contains alkaloids (isopelletierine, anaferine, cuseohygrine, anahygrine, etc.), steroidal lactones (withanolides, withaferins) and saponins (Mishra, 2000 et al., 2000). Sitoindosides and acylsterylglucosides in Ashwagandha are anti-stress agents.',
                                              'Mint': 'Mint contains chemicals as monoterpenes, menthol is the major constituent (35–60%), followed by menthone (2–44%), menthyl acetate (0.7–23%), 1,8-cineole (eucalyptol) (1–13%), menthofuran (0.3–14%), isomenthone (2–5%), neomenthol (3–4%), and limonene (0.1–6%), whereas β-caryophyllene is the main sesquiterpene (1.6–1.8%). These chemicals are used in medicines as different parts of the plant including its leaves, flower, stem, bark, and seeds have been also used widely in traditional folk medicine as antimicrobial, carminative, stimulant, antispasmodic and for the treatment of various diseases such as headaches and digestive disorders ',
                                              'Neem': 'The chemical constituents are found in the leaves of neem as nimbin, nimbanene, 6-desacetylnimbinene, nimbandiol, nimbolide, ascorbic acid, n-hexacosanol and amino acid, 7-desacetyl-7-benzoylazadiradione, 7-desacetyl-7-benzoylgedunin, 17-hydroxyazadiradione and nimbiol [3], [10], [12]. Neem leaf and its constituents have been demonstrated to exhibit immunomodulatory, anti-inflammatory, antihyperglycaemic, antiulcer, antimalarial, antifungal, antibacterial, antiviral, antioxidant, antimutagenic and anticarcinogenic properties. It is the best medicinal plant with a wide range of medical uses.',
                                              'Noni': 'Noni fruit is rich in water and dietary fiber, providing a good source of hydration and promoting digestive health. Noni is a source of phenolic compounds, including anthraquinones and coumarins. These compounds have antioxidant properties and can help neutralize free radicals. Noni contains a variety of phytochemicals, such as flavonoids, terpenoids, alkaloids, and iridoids. Some of these compounds have potential health benefits. Noni contains polysaccharides that may contribute to its immune-boosting effects. Noni provides essential vitamins and minerals, including vitamin C, vitamin A, vitamin B3 (niacin), potassium, and calcium. The phenolic compounds in noni have antioxidant properties that can help protect cells from oxidative damage. Antioxidants are important for overall health and may contribute to the prevention of chronic diseases. Noni has been traditionally used for its potential anti-inflammatory effects. It may help reduce inflammation and alleviate symptoms of inflammatory conditions. Noni has been used for pain relief, particularly for conditions like arthritis and joint pain. It may help reduce discomfort and improve mobility.',
                                              'Tulsi': 'There are many chemical constituent present in ocimum sanctum (tulsi ) due to the presence of the following Phenols and Flavonoids. Such as, oleanolic acid, rosmarinic acid, ursolic acid eugenol, , linalool, carvacrol, β elemene, β caryophyllene, germacrene. ocimum sanctum is considered to have diuretic, stimulant property. Rama Tulsi also known as Sri Tulasi has healing properties and the taste of this Tulsi is slightly on the sweeter side, with an aromatic aroma.',
                                              'Insulin': 'Insulin is a protein hormone composed of two peptide chains: an A-chain and a B-chain, linked together by disulfide bonds. These chains are formed from a series of amino acids. The specific structure of insulin is critical for its biological activity and function in regulating glucose metabolism. The primary medicinal value of insulin is its use in the treatment of diabetes. In individuals with type 1 diabetes, the pancreas does not produce insulin, and in some cases of type 2 diabetes, the body cells become resistant to insulin. Insulin therapy is essential for regulating blood sugar levels in these individuals. Insulin helps lower elevated blood sugar levels by promoting the uptake of glucose into cells, particularly in muscle, fat, and liver cells. This action reduces blood glucose levels and prevents hyperglycemia. Proper insulin management in individuals with diabetes can help prevent or reduce the risk of diabetes-related complications, such as cardiovascular disease, kidney disease, neuropathy, and retinopathy. Proper insulin management in individuals with diabetes can help prevent or reduce the risk of diabetes-related complications, such as cardiovascular disease, kidney disease, neuropathy, and retinopathy.',
                                              'Ekka': 'Calotropis procera (ekka) contains many biological active chemical groups including, cardenolides, steroids, tannins, glycosides, phenols, terpenoids, sugars, flavonoids, alkaloids and saponins. The leaves of Calotropis procera are said to be valuable as an antidote for snake bite, sinus fistula, rheumatism, mumps, burn injuries, and body pain. The leaves of Calotropis procera are also used to treat jaundice.It can help relieve mild to severe skin woes, and digestive, respiratory, and neurological disorders. It has also been highly beneficial when used to treat fevers, nausea, vomiting, and diarrhoea. The milky latex of the herb is used in preventing cancers.',
                                              'RaktaChandan': 'Also known as Red Sandalwood. The major bioactive compound of  it may be santalin which imparts a distinct red colour. Red Chandan may also contain biologically active compounds like phenols, alkaloids, saponins, flavonoids, glycosides, triterpenoids, sterols, tannins, isoflavones, glucosides, savinin and calocedrin. Its wood at the center of the trunk (heartwood) is used as medicine. Red sandalwood is used for treating digestive tract problems, fluid retention, and coughs; and for “blood purification.” In manufacturing, red sandalwood is used as a flavoring in alcoholic beverages. The primary bioactive compound responsible for the red color of the wood is santalin. Santalin is a naturally occurring red dye and has been used as a coloring agent. Red Sandalwood contains various phenolic compounds, which are known for their antioxidant properties. These compounds help neutralize free radicals and reduce oxidative stress. Alkaloids are naturally occurring compounds with various potential pharmacological effects. Red Sandalwood has been traditionally used in Ayurvedic medicine and skincare for its potential benefits in promoting healthy skin. It may help reduce skin inflammation and provide relief for conditions such as acne, eczema, and sunburn. It is often used in the form of a paste or face mask.',
                                              'Rose': 'Roses are rich in various phenolic compounds, including flavonoids, tannins, and phenolic acids. These compounds contribute to the plants antioxidant and anti-inflammatory properties. Roses contain vitamin C, which is an important antioxidant that can help protect cells from damage caused by free radicals. It also supports the health of the skin and immune system. Rose petals and hips contain essential oils, such as rose oil (otto or attar of roses). These oils are highly fragrant and are used in perfumery, cosmetics, and aromatherapy. Some rose species produce rose hips, which are rich in carotenoids, particularly beta-carotene. Carotenoids have antioxidant properties and can be converted into vitamin A in the body. The phenolic compounds in roses, particularly flavonoids and phenolic acids, have anti-inflammatory properties. They can help reduce inflammation and potentially provide relief from inflammatory conditions.  The antioxidants in roses, including vitamin C, help combat oxidative stress and protect cells from damage. This can support overall health and well-being.',
                                              'Woodsorel': 'Wood sorrel is named after its high oxalic acid content. This compound is found in many plants and can be toxic in high concentrations. While it gives wood sorrel its tart flavor, it can be problematic for individuals who are sensitive to oxalic acid. Some species of wood sorrel contain flavonoids, which are known for their antioxidant properties. These compounds may contribute to the plants potential health benefits. Phenolic compounds are common in many plants and are known for their antioxidant and anti-inflammatory properties. Wood sorrel may contain various phenolic compounds. Tannins are a class of compounds that have astringent properties and can interact with proteins. Tannins can have various effects on the body, including antioxidant and anti-inflammatory actions.  Due to the presence of flavonoids and phenolic compounds, wood sorrel may possess antioxidant properties. Antioxidants help neutralize free radicals and reduce oxidative stress, which is associated with various health conditions. ',
                                            });
                                          },
                                        )
                                            : Container(),
                                        const Divider(
                                          height: 25,
                                          thickness: 1,
                                        )
                                      ],
                                    ),
                                  )),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: pickedImageCamera,
                              child: Container(
                                width: MediaQuery.of(context).size.width-150,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: const Text("Take a Photo",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),),
                              ),
                            ),
                            const SizedBox(height: 30,),
                            GestureDetector(
                              onTap: pickedImageGallery,
                              child: Container(
                                width: MediaQuery.of(context).size.width-150,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: const Text("Pick from Gallery",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
