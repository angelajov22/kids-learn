'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "5bf420feb4d0d5c09a25b75d0983c749",
"assets/AssetManifest.bin.json": "9eba3f66c25368dbb73275c79a44cbef",
"assets/AssetManifest.json": "9e04ccc6001b7846612d8d9d6c6f4488",
"assets/assets/audio/animals/ajkula.mp3": "ba899dd25ddabccef094a010c499fd16",
"assets/assets/audio/animals/buf.mp3": "7095520471ff414fb3faea597fade4d5",
"assets/assets/audio/animals/cat_sound.mp3": "40c3ba8f70faeb0ecab04d842a20eb93",
"assets/assets/audio/animals/cow_sound.mp3": "c1b24441e0ac326ab965932d0ef27a44",
"assets/assets/audio/animals/delfin.mp3": "4be30e439b343b0d674fbd3c550113c2",
"assets/assets/audio/animals/dog_sound.mp3": "4fd71374864356e90f1fcf8dfde4ff89",
"assets/assets/audio/animals/dolphin_sound.mp3": "fff3a39dd2db5bee44e7dc92b370ff71",
"assets/assets/audio/animals/donkey_sound.mp3": "3e427f9912fe7c75232b7012cb176e1b",
"assets/assets/audio/animals/eagle_sound.mp3": "e1fdeee95f05de32d0c6ba5cb452909e",
"assets/assets/audio/animals/elephant_sound.mp3": "55b3565ad2c599583f8a40a7568379db",
"assets/assets/audio/animals/foka.mp3": "e07935f702c0b2567b35b2f37ba336fe",
"assets/assets/audio/animals/frog_sound.mp3": "1cd0644b18babaf820c8860e046f3965",
"assets/assets/audio/animals/goat_sound.mp3": "0691d78e18776d16c34dd19bd0d05964",
"assets/assets/audio/animals/hippo_sound.mp3": "af0017c42d863c8a52092effcf548ebb",
"assets/assets/audio/animals/horse_sound.mp3": "6a4e5cac1f4e348a96dd0b855a82495f",
"assets/assets/audio/animals/kit.mp3": "433c2950f5d38e4067d91a615476129f",
"assets/assets/audio/animals/konj.mp3": "287866041a159a1ab257b623277dfdeb",
"assets/assets/audio/animals/koza.mp3": "55a17b143b874eeed953849851600ba4",
"assets/assets/audio/animals/krava.mp3": "acc5f4ab2e7aa369236511699cccb6ad",
"assets/assets/audio/animals/krokodil.mp3": "ce08b8ebec1c3b202dfb350d7f578e7a",
"assets/assets/audio/animals/kuce.mp3": "a19e832c554e2b110cce2aecb900cba6",
"assets/assets/audio/animals/lav.mp3": "4a0c857222df6d2aee355b7522f67e7e",
"assets/assets/audio/animals/lion_sound.mp3": "493241915f129ca204c9bb4d54743b63",
"assets/assets/audio/animals/macka.mp3": "4a7ebdedf3e3b3305231fb1d8f06162e",
"assets/assets/audio/animals/magare.mp3": "c8adab35aeb6d634e09f0a9663e08614",
"assets/assets/audio/animals/monkey_sound.mp3": "b929bacf9f52f22dea981723e1029802",
"assets/assets/audio/animals/nilski_konj.mp3": "0b428bb5a094be19841cd9fd22cb4f9a",
"assets/assets/audio/animals/noj.mp3": "7c5d98ed408ef737b622a0b8e8063fcc",
"assets/assets/audio/animals/oktopod.mp3": "b2f09607ea3f4cd1dfef5f97de06a2e7",
"assets/assets/audio/animals/orel.mp3": "240d98472a55ff45fef79c3e36a9f3fc",
"assets/assets/audio/animals/ostrich_sound.mp3": "9673cac533dd06886bee5885eb97804c",
"assets/assets/audio/animals/ovca.mp3": "bd3c5fae46ea7c91e8c539895f5130ca",
"assets/assets/audio/animals/owl_sound.mp3": "216ac70d0b0b96497d6c3eb94de23239",
"assets/assets/audio/animals/papagal.mp3": "7c87abb6ae848f9351e315801bad4bde",
"assets/assets/audio/animals/parrot_sound.mp3": "259bebe4665532871f18c08baf321448",
"assets/assets/audio/animals/pig_sound.mp3": "8c0b0dfbbd93b0f7347ecef9c8b835c4",
"assets/assets/audio/animals/prase.mp3": "dc402751c89e88b66f695dac8c6d13e3",
"assets/assets/audio/animals/rabbit_sound.mp3": "929d4307be2434b238ded9d5a09dc5f2",
"assets/assets/audio/animals/riba.mp3": "1f060c0ee7f5646a19fd066252613639",
"assets/assets/audio/animals/seal_sound.mp3": "378c327a1f6192f3c083f0ea320ca052",
"assets/assets/audio/animals/sheep_sound.mp3": "f0a93ad92ebad6e236ba2a45000e3ca0",
"assets/assets/audio/animals/slon.mp3": "0801f1a1b43a48aff50ef668affdecca",
"assets/assets/audio/animals/tigar.mp3": "461be4bf4d5d1d894a5ba2ff29f94aaf",
"assets/assets/audio/animals/tiger_sound.mp3": "74fce72a27452548d610d682123c7fca",
"assets/assets/audio/animals/whale_sound.mp3": "fec99f252d03cddb6de6e1e1be63fd8a",
"assets/assets/audio/animals/zaba.mp3": "dda67a3a0839d753eb058a1ada09cfbe",
"assets/assets/audio/animals/zajak.mp3": "d4c21b52105f24920e7ed0168f66960a",
"assets/assets/audio/animals/zebra.mp3": "56d359d36ea9e63110253c3cb78064b0",
"assets/assets/audio/animals/zebra_sound.mp3": "cb48ae7d161070449ba6db6093f66301",
"assets/assets/audio/animals/zirafa.mp3": "c8a8d3e4cff4bdad623fd06c42938475",
"assets/assets/audio/animals/zmija.mp3": "f1d90adb36d6f7958e13bcfff449321e",
"assets/assets/audio/colors/bela.mp3": "37e6e3e128bf24c48bcfcd9e84aa8f9a",
"assets/assets/audio/colors/crna.mp3": "7f0643576f72bf39359eda68dd337fe1",
"assets/assets/audio/colors/crvena.mp3": "be9729943ad4bc449871ae7315e0bd93",
"assets/assets/audio/colors/kafena.mp3": "b3d63edf158ff2a454adea05c8066d3a",
"assets/assets/audio/colors/portokalova.mp3": "76d96213985b4a9b8771012cafff5790",
"assets/assets/audio/colors/rozeva.mp3": "3f839286ec65339c9c32d6625fab58ef",
"assets/assets/audio/colors/sina.mp3": "52fd869a9a83cef146a5b802b8cc6cdd",
"assets/assets/audio/colors/violetova.mp3": "f239f25304046d550a9a941255eee60d",
"assets/assets/audio/colors/zelena.mp3": "c0e77e6bb961b44dcc67017cb0277068",
"assets/assets/audio/colors/zolta.mp3": "1417decd89b02476418676c2b74b80ed",
"assets/assets/audio/correct.mp3": "5afa9cea4cc20eb0a772f9748db6d540",
"assets/assets/audio/letters/a.mp3": "7db9900a2ca56245d5a75e2f667accc1",
"assets/assets/audio/letters/b.mp3": "3e6668057e4e093aa42d591efa43ab0c",
"assets/assets/audio/letters/c.mp3": "6e4d348459e86ae3ab9e9a5f940e2acb",
"assets/assets/audio/letters/ch.mp3": "8a34ff2c4b368783277f23bbb464c74e",
"assets/assets/audio/letters/d.mp3": "177b887b153573167ed4672231a605eb",
"assets/assets/audio/letters/dz.mp3": "8ccbe57061adc2ff43786428bd6322ab",
"assets/assets/audio/letters/dzh.mp3": "02fefb55586d9b42cc9ebd3c7608c7dd",
"assets/assets/audio/letters/e.mp3": "cc99aec035136e3e82ae1bc8e18c88e5",
"assets/assets/audio/letters/f.mp3": "41e6c113ee0599de98264336c1a6962e",
"assets/assets/audio/letters/g.mp3": "fc37b79b9a861e43882f81776d0ea922",
"assets/assets/audio/letters/gj.mp3": "10adf12171fd7b4be0477e77f047ba33",
"assets/assets/audio/letters/h.mp3": "05acc77b9362e6cd94d57e9193853fb4",
"assets/assets/audio/letters/i.mp3": "e3ef2e43d8e09b818710246c43018858",
"assets/assets/audio/letters/j.mp3": "7b5e2403fd7bd0a9a6756c961f57567f",
"assets/assets/audio/letters/k.mp3": "31ebd21a2b698b7a3be69933168a254d",
"assets/assets/audio/letters/kj.mp3": "5235f3ea71bf3ecba4ad196c9104ca90",
"assets/assets/audio/letters/l.mp3": "6f782471638f119340c4ac6bc4f9f100",
"assets/assets/audio/letters/lj.mp3": "ff38513a3aa5d8364124314bb23eee4a",
"assets/assets/audio/letters/m.mp3": "516668cb41988519244f228b3a78f7cf",
"assets/assets/audio/letters/n.mp3": "e7597225e92d20a5f08dd906a204506a",
"assets/assets/audio/letters/nj.mp3": "43e6e2c7f484747658385670a4aba096",
"assets/assets/audio/letters/o.mp3": "8e360282bc6708dfa435ccb41c404ca3",
"assets/assets/audio/letters/p.mp3": "1c3f2ec9f53cb8b069132bccf9ff77bf",
"assets/assets/audio/letters/r.mp3": "6909253f4b2ca1d9c714f6426d85c245",
"assets/assets/audio/letters/s.mp3": "1fb86055149d2edab596eed11c2c08f1",
"assets/assets/audio/letters/sh.mp3": "c23477e307d68264be8c86fc8e806de8",
"assets/assets/audio/letters/t.mp3": "3f90e1e472d56af04923d1756220780a",
"assets/assets/audio/letters/u.mp3": "3e1be67126973486e5a2a721d256c0a8",
"assets/assets/audio/letters/v.mp3": "5c458f5d09c96d0f197eebac8541cd43",
"assets/assets/audio/letters/z.mp3": "385aff005f45d832e4c543e2306d10a0",
"assets/assets/audio/letters/zh.mp3": "7f562ba55af579e0a1cd6b2c16695652",
"assets/assets/audio/plants/apple.mp3": "1b851d32c869232784e6ed7ed1d544e6",
"assets/assets/audio/plants/apricot.mp3": "091dc99e0a3055066f82a7a33d61ffd8",
"assets/assets/audio/plants/banana.mp3": "df60a57db27a4f64c16e5f7908b1403c",
"assets/assets/audio/plants/beetroot.mp3": "872adf7a0de33a75562496e73a35d5cb",
"assets/assets/audio/plants/cabbage.mp3": "65f8b06f88e9a13a8d22c8b7d9995f65",
"assets/assets/audio/plants/carrot.mp3": "822f7e224ba0a544bfd707c93e8fb66a",
"assets/assets/audio/plants/cauliflower.mp3": "458ad12b07104fbd46a413ec3f61c73c",
"assets/assets/audio/plants/cherry.mp3": "aa591f5fa70d5501fe80d33dcef2dea9",
"assets/assets/audio/plants/corn.mp3": "7d3bd09f37a99f66a6f902d7de082210",
"assets/assets/audio/plants/cucumber.mp3": "3a64cf480ccfb0cc9b2e7a2759064ade",
"assets/assets/audio/plants/grape.mp3": "a3694074183a101b6cc1da5f7e694923",
"assets/assets/audio/plants/lemon.mp3": "89eb374c85c341086a8e3d9098d85041",
"assets/assets/audio/plants/lettuce.mp3": "631be5fc9fe7a6d3ba6d3a553f1cb578",
"assets/assets/audio/plants/onion.mp3": "694adfbd06e9c4730cda5707024e28ec",
"assets/assets/audio/plants/orange.mp3": "74c67235932e01493911bed3abf98734",
"assets/assets/audio/plants/peach.mp3": "6dc0ee36dce5a39ea38f6a92c087d4d3",
"assets/assets/audio/plants/pear.mp3": "ae9fb8f68e3ef6eb2185902aec5ad701",
"assets/assets/audio/plants/peas.mp3": "556fdf63da881e5cd378cd9f421f41a2",
"assets/assets/audio/plants/sour_cherry.mp3": "f375ede23404d6130ae766dee475eb69",
"assets/assets/audio/plants/spinach.mp3": "cf402d79fb89e95ee5202444d21c3da4",
"assets/assets/audio/plants/strawberry.mp3": "235bc6c1877e0c3adab5b927545564fe",
"assets/assets/audio/plants/tangerine.mp3": "8dd3a7fdb02a5c7daea62c696f0245c7",
"assets/assets/audio/plants/watermelon.mp3": "24264580339f424787f6d2010f909785",
"assets/assets/audio/shapes/circle.mp3": "5c909d631b5f9761bf2c940fb18d12b1",
"assets/assets/audio/shapes/diamond.mp3": "8664923aec1a80973f47fa18228c0b46",
"assets/assets/audio/shapes/hexagon.mp3": "84a24efc004f9f1fcff062cbe1e943b7",
"assets/assets/audio/shapes/pentagon.mp3": "8c8039952f9a5eaf7815b920b795e11e",
"assets/assets/audio/shapes/rectangle.mp3": "b13f475286bbdfd2085583e45996bfbd",
"assets/assets/audio/shapes/square.mp3": "ca6354b51146e84037f8db0bab5d61ba",
"assets/assets/audio/shapes/star.mp3": "4f069507cdafe36049277ede9191eb50",
"assets/assets/audio/shapes/triangle.mp3": "c4b6fd740c9166b23c878347a7bf1c17",
"assets/assets/audio/wrong.mp3": "8a1b4019034dff1cb614a8b01e33a034",
"assets/assets/images/alphabet/a.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/b.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/c.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/ch.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/d.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/dz.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/dzh.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/e.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/f.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/g.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/gj.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/h.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/i.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/j.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/k.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/kj.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/l.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/lj.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/m.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/n.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/nj.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/o.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/p.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/r.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/s.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/sh.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/t.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/u.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/v.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/z.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/alphabet/zh.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/animals/cat.png": "7dd6c46e6737238ba531ad273ea672a5",
"assets/assets/images/animals/cow.png": "a772448aad467d51b393074dd2054e88",
"assets/assets/images/animals/crocodile.png": "5a94e120ec8c44c7062306eb246b029f",
"assets/assets/images/animals/dog.png": "41aa651d54d0a80c96af05c0e46d1c65",
"assets/assets/images/animals/dolphin.png": "0a5da2a878a4e7ac910301f45f72d47d",
"assets/assets/images/animals/donkey.png": "425c9174cdc53dc7badb8c6962c92c4a",
"assets/assets/images/animals/eagle.png": "0df826a35886047573983b295b35f875",
"assets/assets/images/animals/elephant.png": "c5d29670844bba20f8ef1120d130dab9",
"assets/assets/images/animals/fish.png": "ea4b567bb25b14e1ccc914d6d34a7559",
"assets/assets/images/animals/frog.png": "527d2c28a75f4111ba26d4d7bd561961",
"assets/assets/images/animals/giraffe.png": "9ce8835e34887663faaf64092abeeffd",
"assets/assets/images/animals/goat.png": "dd2900975f671e4c9563efe9e566312d",
"assets/assets/images/animals/hippo.png": "2e6d6c8e1dee0ac792ef2067cd4e74f9",
"assets/assets/images/animals/horse.png": "a7991be21124aca38d36e5e7cc24b515",
"assets/assets/images/animals/lion.png": "a1db24e7409133460f5a94e32002311a",
"assets/assets/images/animals/octopus.png": "e0c751c6ff33f0d07c30d03021e28632",
"assets/assets/images/animals/ostrich.png": "d7a207ef43aba5dd96cc486d1abd2b8c",
"assets/assets/images/animals/owl.png": "e6106e638ed6f7b5a14884e17d26f9d8",
"assets/assets/images/animals/parrot.png": "05fbbb3e5d98d3e60afda8ce61f852e8",
"assets/assets/images/animals/pig.png": "1228f049a5e9d65f0336178fdc85b285",
"assets/assets/images/animals/rabbit.png": "d6214b80b01002db5e34064d0c019022",
"assets/assets/images/animals/seal.png": "2699a4e5bfa5227f89f89e2b85299a47",
"assets/assets/images/animals/shark.png": "2464c2ed849a553c1801a45e9200adb2",
"assets/assets/images/animals/sheep.png": "a96e6ce8c41658579d34f2c27a69b13d",
"assets/assets/images/animals/snake.png": "64f7d6da9e23281434144c01391bc757",
"assets/assets/images/animals/tiger.png": "0b02862e210d275031e1365b342670f8",
"assets/assets/images/animals/whale.png": "0b6e25dbd1495c893c0a6bec1fdc2eb6",
"assets/assets/images/animals/zebra.png": "60003cb2fec872da3663c57ab851a878",
"assets/assets/images/logo_finki.png": "114adc50128b340d3930906e533bc004",
"assets/assets/images/plants/apple.png": "455e4142355a5d4e9cab512aa9181bea",
"assets/assets/images/plants/apricot.png": "ddae1492433634449ed295c68b48ec19",
"assets/assets/images/plants/banana.png": "0a81f384d14c6a87590d132b671179b4",
"assets/assets/images/plants/beetroot.png": "ed004d78cbeb37a12538920e78b0a37d",
"assets/assets/images/plants/cabbage.png": "e0804af4d79249c1a2939a28e4a151be",
"assets/assets/images/plants/carrot.png": "9f315a82d78a09c3dc1a4cfb894e0d6d",
"assets/assets/images/plants/cauliflower.png": "f2284d4cd425283a662e7e50150677ba",
"assets/assets/images/plants/cherry.png": "e1997762a6ef05a24233a1bf06f92517",
"assets/assets/images/plants/corn.png": "0bfdf89cc2ccec0a6a661b364efe5e93",
"assets/assets/images/plants/cucumber.png": "5e236c35f2a297e679d08d9aa5af84b1",
"assets/assets/images/plants/fruitsvegetables.png": "2d004b155b7df189234aa19de78c1c6e",
"assets/assets/images/plants/grape.png": "e433b9f9c7553850d9524a35cc224483",
"assets/assets/images/plants/lemon.png": "9f21f87b03bcbcab4282ef60c230051c",
"assets/assets/images/plants/lettuce.png": "2ef53e21ec8394455f8a2fd62ba32478",
"assets/assets/images/plants/onion.png": "be862b8b36aae45289e3c942ecc4674c",
"assets/assets/images/plants/orange.png": "5f640a6de00c682499712ad8b90f0524",
"assets/assets/images/plants/peach.png": "3159b744e89166912b5c4004dfb175b0",
"assets/assets/images/plants/pear.png": "6e635dd76e5eafd409b05c60daba0607",
"assets/assets/images/plants/peas.png": "f2c21279e49ff9e0238b7e28bfdff572",
"assets/assets/images/plants/sour_cherry.png": "459a945d39171b147648428d4edd5167",
"assets/assets/images/plants/spinach.png": "6b0107b8f43ffff1184bb87fc9b32549",
"assets/assets/images/plants/strawberry.png": "10d0a4652704183d99e7537077c3fa3c",
"assets/assets/images/plants/tangerine.png": "22c7db113a6e7dae7c2f9c1eb8602621",
"assets/assets/images/plants/watermelon.png": "0c8daae4c43a5e001af04f8eab34e1dc",
"assets/assets/images/shapes/circle.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/shapes/diamond.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/shapes/heart.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/shapes/hexagon.png": "1c1fc76ecbef9a78dcdbed22523fe28f",
"assets/assets/images/shapes/oval.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/shapes/pentagon.png": "7f4b74956682c713faf21e68d042dbb7",
"assets/assets/images/shapes/rectangle.png": "3f471aa2f89023cc1d4e80924e5d41f6",
"assets/assets/images/shapes/square.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/shapes/star.png": "a1cf09b59e5060f3beccdcf7a37189f0",
"assets/assets/images/shapes/triangle.png": "8efbf332944f7089ab62ed6595ff72f3",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "d65fb98ff1c960406f4258fadf9d4516",
"assets/NOTICES": "b5ee2fa2700b4e363203f970f0a93547",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "47078c7db6e401bbe9249031821134ac",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2eb587dd35d6384bfbf99db6025f4795",
"/": "2eb587dd35d6384bfbf99db6025f4795",
"main.dart.js": "99e20185de8ffaf0614d34509a85c45a",
"manifest.json": "b20815bc743b96c9a9615063097415ab",
"version.json": "bdb1d9515a11375f7267569b03749619"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
