// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../../Contracts/BLS.sol";
import "../../lib/forge-std/src/Test.sol";

contract BLSTest is Test {
    BLS public bls;

    function setUp() public virtual {
        bls = new BLS();
    }

    function testVerify100PKs() public {
        uint256[2][100] memory points_g1 = [
            [
                4732500246076266494184282090774606989935310339956125703553588050065105269449,
                17680088654892913246817622267030318133161076660043605649300612920347752169327
            ],
            [
                1655578660422496991839058780452835616766416333598975400769190111973908174329,
                16334665185251989719101735311683947808779079810183866863232955457422711503726
            ],
            [
                2158316458707131911275071143380994217088898089732797680826870887849729267568,
                6971679878213161407063319038605172967137805123573869578911796847049132490312
            ],
            [
                8576261527351857515426555337599102506220793565224054175246633932523471367165,
                771009138047006070038011277566814502400921301438466400405133292350688559367
            ],
            [
                19480461969932257876878170265959836028049445961789963553890279675190509712626,
                11888220534482210570021111341257508711127644460450041892325658710707756835077
            ],
            [
                15157792931822468715094226666150663065316571166516160849990695985782451132193,
                527261034662352576545430544408527165102337107588214065373830983874184341175
            ],
            [
                6654476606668993450271055449945578815324329417318104919536703006721936451218,
                13568610608038734436660778940013554987931832007103535596738908262792119519277
            ],
            [
                7591877449432589743153072595352046617055776296402105938797664332999081799327,
                18493139576992345592449172660704544383514708573665732109499249603715415063145
            ],
            [
                20252578751960044017284052975970004917342888996427572151929888793019407809745,
                18397342444689555164407355526808014623765154350107725760039599657897545617700
            ],
            [
                7815397794321575944425982445632341358887131056395926461952922242366773101507,
                21767987809147848622511852934861113740473204430981284584519784751420994431817
            ],
            [
                20750762836037882299526202160226774858738692649347512813478997914447294854271,
                15700857248776483150335988184741896983751009354319887195897929654813592320595
            ],
            [
                1687841288835611004120382324232188473040646514797460244406939592106127314692,
                6714067025757661699211590666240604106745086688962901164688613772001015461498
            ],
            [
                10834619255068134361635657506806085496825202548576938342116806692848525875833,
                16758929475354275232821813860854522531427433801698827806153049374846860526548
            ],
            [
                19005235643523735406359240822486267370086050936296489351205773856032907935475,
                18464492146632747846912859294590836668300465358719915126134172797304761068363
            ],
            [
                14548480351423329022160079028983853259136837991042612251043292477956816774692,
                10231562669736327483568293543725096696145775181045207288616597235554727645197
            ],
            [
                7041824746028845098157918120663199510595164029091988096666656081312330917793,
                17596606822097361560255446000266036765099859337893850742697554951162265794419
            ],
            [
                19932771412876707981251114916537494916261791295518002823137490769399148362353,
                17557634205419591925691681838571725637729342935172368563115295147751795532838
            ],
            [
                21757447498039355073818671814187903010683611930842951499839674183256458060466,
                9571292698332122451584928862927345798632392811136841889212067424854908215340
            ],
            [
                14312867299591514006249631018847580370380004411722305762808890506173077964670,
                3307137269071372703093329194911557864620850062081687027476412032967277266339
            ],
            [
                2492411084788609142448614668623925212971313639356051145141466833502820610145,
                15049622571948792990017065211891227134044307083168740571928432116704073900513
            ],
            [
                8293277953996195530392361439217636405742810391053610164617342787298084335450,
                1711785935177314995863009446442292875846018980753953323339482207493043536978
            ],
            [
                9160015728376943113026205089745922993026389678732186962563803224026088358001,
                6063563155460899751589684075685622753033724976162371432261279907722282050566
            ],
            [
                4806107970846631633111188880351816255994874178570193347681305862573481225209,
                10633601855225421723299662025522153267348261032096798774136168899300284712005
            ],
            [
                20628245024961406691268174136998465597628874848390978807523795754813106843882,
                8815902020364931597072641832542372601805900946659614132699082943928390123026
            ],
            [
                13378249774592277988572238831692636425832531890200629398263527417895659008749,
                14936756780788357039078558796493803514236782227029165662450245324690017321726
            ],
            [
                7428936140945029919350867660417738673574045114103068014440299477590770226834,
                6029544808275001436860939719537665280534073954579932209052357543717431623560
            ],
            [
                1412474190056102422155783574163719460102800268077564266420103527667986985040,
                15253133566753341305093796352004141682085254043286277939172464740595038756633
            ],
            [
                17885846361510815055569411469662511257088170959228464015821712759384399932261,
                8899842345999420359815770176618483505091150468127653380340391559073350421104
            ],
            [
                18513685267542039954481679092828671840965609279213821051779969433845099935016,
                9635829505442973103877085652703906701453762683981529648066969105137592367786
            ],
            [
                7666858007980772010896111535553759988856341899666964180692665142898449291289,
                21529259724198999883515029655920416743061205333828227073510788737997909027715
            ],
            [
                17778085175986721111531476846679502440107805967670854286742594482241449236382,
                19584225482484923027450992744202139439611931657748893986903741923404160737134
            ],
            [
                8947799594569994401840983272020081328058363639198271968649755815620246683296,
                11160211822537943172369527816758507057737254008354085187101879794304785757941
            ],
            [
                2007952387353317852848350895529291791590308875447798288241364931359384513491,
                21013318028496267029592552915977480054681996484250984523125206264441666325805
            ],
            [
                21727657227112390454162749689958185971555422781334151235277709566780682564084,
                4135107619095034659206854170867806751410779173628418958546007152691077226904
            ],
            [
                8113597074220188228871880196908846708929337348608435402445336504499251290407,
                4291444812310903135856181992624778505105311263817582417321159912542277496226
            ],
            [
                16934084738891877041051109574710715691826516481917935394690855756951551589090,
                12182426991489708801005476351235480614506134589467455062061554948399049544945
            ],
            [
                9423536149518631111182204871362589269965936908070819863558108899852715810232,
                2457154815586420176410150092884679458807408945558187479852615303680322638478
            ],
            [
                8569969932653304237681536917253582408375044765615260031808642337399249575915,
                6646452386245577071450744915066475287716139037967270112539124304955508192702
            ],
            [
                17764505356210688131611062133239032055875675030602517240934706145247074625202,
                16411840982431925668766088790649738977379290318097864515537078028340043886637
            ],
            [
                19467590936698124364321170622234819420352192605915383060612362007106948727489,
                485059944979231260891088786796231684249281004845984993030899607213637888315
            ],
            [
                16264260107264034643489055039853251718249646303893236479073169073091670478032,
                9323957974963961361644893740509410568243647616882781246287652161485923763812
            ],
            [
                9759805357042645323011618722274644261354079954037481925845136076824449838022,
                10821071082638914838519514340104108801620180679967366291321274678914528887650
            ],
            [
                21774375906802007831397009799188168682417635310023370162849341833692505200663,
                13509297619671149049741097146210477888430746157454907549016579783564177633326
            ],
            [
                5595165568387772979240559652976394146941871785319281164528728646755737957375,
                8437659455991824817811680602581107567944320160504136583267712970458469957164
            ],
            [
                4102832908218184484767113804406454525320654928922226081850630232225743455573,
                16584581812720449812055201579082370151729249632043729477664225010233158404450
            ],
            [
                21147445653561444207942009593296936198195526508204341062795793175913274547587,
                4062204126274813851032564166628867127003877677873474481857949814151566384746
            ],
            [
                15630216561025903272636626200140149523149985431688907898761894473398017819358,
                21563952700387861537803290634960767748468100665542783919421536655277517956168
            ],
            [
                7228153371476996585969772273467200377636328474626105613339331837675809304430,
                12581965446739115423448964883489700935254967078094777795890099521554726017138
            ],
            [
                253022262855774689726007444131157745164712922616259291331612026597715927121,
                1303075262731370788541376760774153621923281962597924378417529024653413187524
            ],
            [
                12137880387801573907989292124073150695421877320042160233270601648198364050115,
                11406194410998403613556154204751600746284506230253294323654760265647405568440
            ],
            [
                1588457964889589768434346228286402209388690225280747406773461477850021665712,
                11907988604828383481983164081524595660210107799731235244552655261448033370115
            ],
            [
                17919787640016665437928966858085497299140950898726079155127020387616531433305,
                5555040233818660099575012643042587100442839893775526834705372920626576099110
            ],
            [
                887839498020111304417080574153884981631450440272805948605285868090603766811,
                17702585558661816337400414559275463475892484758027628972257286084780931915571
            ],
            [
                21714237695081001324717695172535647229480837609326333396388280401412109047879,
                4752704430353945281596662150224093851343538028669033077497966262709647977551
            ],
            [
                1542414991424357484767665305987999859941826292242851442038362965030879040734,
                13480593596422048938708072712399739080767225407883056511914181923223490764195
            ],
            [
                4575420196913554609087155294551848895753507062700780077139739670188927531522,
                11335528743950007623562556212573212859105008402932010945249032944856712057972
            ],
            [
                6599405791390327681505915335571835775428972976035804707172451020929379409560,
                1413419812240632642447364684312946992789205755843328589599277180721368504109
            ],
            [
                6900351586686337984867380524260527565011725835414062760345713795585907285576,
                10507113726369758452175565334640116358984057217021953619718860807891328331194
            ],
            [
                3269094024749840271075788799836199012902514517571012431361643795418065265154,
                13108128984058202078216809207744403128014950523956774995169962092069115573840
            ],
            [
                8742547060944871472669350471158842633692328622506859609576511726991851926399,
                7459740223415619563257164862894077892826591164467290962895400214747943725717
            ],
            [
                20639699739878753020463795517363869544871495301905091081186466013177402166824,
                8540458552228760357611000092980665531035552670851204250824049874614156678694
            ],
            [
                8503850294531255697662028786143410840584136377917592122281669330488935865094,
                1990983160017924753624923577598937245564858455185163186690190133562936821755
            ],
            [
                19462235938012688674814071346909435550696422810752743524484941911142659080602,
                3228793801610641304024360695191165093685451418586880920653866326149710617758
            ],
            [
                13548968880122982026274804515297174846656888323544519708455246118807504100426,
                15905633902184802582883462980437576147071542089981963959427300772891207037344
            ],
            [
                9380643037992403280821733510783738483660365626123287305914174595335200841000,
                5879029052377072013854942904546994531874670808290288211462037499552243568653
            ],
            [
                4934578947493330161290218460857268688525738332739948029962451851854451714526,
                20430186671672797289496027072179915066211415779287291913235101078861306714071
            ],
            [
                19610252222610124430182376414782108602020858871305974906599433063988386269912,
                6177249321383118192127692431689573818338851271652441540337277164616788619079
            ],
            [
                1293900819009308442672973051602039293946726823914107114638567606273684635365,
                15056072294962815815779600941234056336419607003828531395136008243724095868376
            ],
            [
                18349490185438033844489209111261823590202417581396393324698395813325143190180,
                1950785080523799920744691075014380251977728952779474767363360262903957672515
            ],
            [
                10023262877273225569951710267448638241689759904275503776676443587900234810654,
                6908508034817703824620380303845198256901065968798066878605446077901189550466
            ],
            [
                5229288785996437604050619955074120570344032676444823288645917796288165300140,
                18094619150469202646710053342911707288670349427778044999772784760413518799301
            ],
            [
                13505051619843355102799366072066944687639216657131321742077750192838970102314,
                15394351120313635991230882508336859141077602807389750381975986470272201271293
            ],
            [
                5145185170592998243744543172640521163355606501202928731505779667536037189901,
                8657276424655941409571826317133425979759341680708289453257359190888622058815
            ],
            [
                7392574363843814988516359031421447437519533339147703860837325380407780445788,
                19857259399510303351313135914414329295866011580937193490191157987654726964884
            ],
            [
                21563997107463723273768458855844649720879052763742072703420618729362867105277,
                9985836743599983735421683682596357628032892630652769432206439198506343137838
            ],
            [
                4217908510419847670326121517001704007453013633627181587125742801470962924144,
                12706969017196678782693031431257851194003525034384273090688948257635747482046
            ],
            [
                12176778056711591803779799260387162838861656856209789606669390256557702416385,
                5505504226616279797700454449644106798818709357066272518395788340877231517352
            ],
            [
                21248758360558680224784931234704178468219448005164546492015373904577698417217,
                13883711212427251615635928365567880229972572117078278690022665349537777076613
            ],
            [
                6851922115858507886769847617326148722607542719966355195223995291130676703930,
                278348072032780563141090312137097129133520426224740668200402022401998164457
            ],
            [
                6878574612134259624087939263601690910379978243514648871837284446889149934566,
                8602735461115642068902458267489712250323549098129149562280308675711928252752
            ],
            [
                1923276911722384365993181691767172089132274832021495317319120577432805080677,
                20209143560644433830325469842742256666230656718929565160966521588511198144504
            ],
            [
                20534280094003146386125228808691755975296568188998824072392105432095704841707,
                11449270161556811265046171911039752651999290521876411093330539470395875968249
            ],
            [
                15491947165799556337332480033048464674097932702868441291716639285149507844843,
                5302253554559492858874035284086395579020893005329945235511275083062082475062
            ],
            [
                12928505436464694913654250188807910586812251946073384668254401540840909551434,
                18437889284274861520517239369633774575240460587835999714387559409824100532363
            ],
            [
                5829425339749046991232184255570701209419537210952257737883634855564077589666,
                19077483549597684605843052389215736440581585032665805340370534347495856576831
            ],
            [
                12840814931313017765586378811495304515071085063667755637800047733656870981898,
                2816275241530298528835273799498499283285458821420521413211068638657123760843
            ],
            [
                13072113359321550748294940922695701853607834659630107429348928720022933255069,
                12117609029994516931241988777752036742464396228979725177447199560750456957002
            ],
            [
                18573258478139573855918102822195523040034819793027048511545401164048189265134,
                220837665673184439403903904319631519603771406680999620329385047577535153860
            ],
            [
                18642423006775249337311786917087786912956482455228553814281641722959549986714,
                16012725089454877253354415062255027710312260752008451249170357261619044510195
            ],
            [
                10743926949189536961113210836492224104359682710652249568363266192777748621737,
                7763830309800169370958285969419125168441362297222010147470578656063709276626
            ],
            [
                7664785181949386841779479226400801412698428963320591446417889738253443827679,
                18482859679211930523243198619575724990723994793043130966148051454843851195770
            ],
            [
                12641394692417065113396517270672594768159078704709209739180563816579058739135,
                15922493673873837413023852366587846096342617329179461268763011210578820900420
            ],
            [
                19503261242393851558004454887187566584667893700559055203938918936758799925067,
                19770608861569265376646789709619669293046404215494256337286090706458836398780
            ],
            [
                17798867482881207364025317071235383537035214752677822762371746577603549507770,
                12068829506929361050182403442730524904022048552345807740453063064220039669635
            ],
            [
                7140552299640520195643033129141880840252632995055606445652030270709108332161,
                19991732322496350223714030641712612217537996969846609293953988157487876308095
            ],
            [
                2375120848638559772117401732622686210129485920950647345471905314562207341421,
                5987392125189925539361111422930471589811607737466298300241471227314413956714
            ],
            [
                4275246582286729172374913109584702419571770211423154156196634803859613157958,
                13146561232336686177776858014013423016854082410055217859737157261111873807116
            ],
            [
                3300673416434544377511576301173250268504711985561136429224982510466947188768,
                4258595289439956975989382033729739994186624095498570665814597223446540193623
            ],
            [
                6641625398901437292054984544205547282596383426149861164565829420541759944109,
                7910827195567152982545178662756839447533827926911148417732667606160730936936
            ],
            [
                9897044155543393390322421273828630401972957114707938132257698317823592005839,
                20730687827472951372058563590679146554103372700471550620645008509349198026505
            ]
        ];
        uint256[4] memory aggregated_g2 = [
            7223896473547705775590507488495746293448504648118536649254036907585986216184,
            16159672006230659357815081968412115956220455649530155770799053791064438169912,
            14685268285139796342447777018151240655193854877871692841189973067327938525446,
            11721220486566235401685638921319636617765944004331529356187183569554218358594
        ];
        bytes memory data = hex"abcd";
        uint256[2] memory signature = [
            15031697115448342509463525609229783673078266338552253584310608380111166107848,
            16183659198502361688016353168168384405012248440592012927583047057789403103181
        ];
        bls.verifyHelpedAggregated(points_g1, aggregated_g2, data, signature);
    }
}
