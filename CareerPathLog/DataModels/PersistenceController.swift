import CoreData
import Foundation

// Container can reads data model
class PersistenceController {
  static let shared = PersistenceController()

  let container: NSPersistentContainer

  init(forPreview: Bool = false) {
    container = NSPersistentContainer(name: "JobOfferDataModel")

    if forPreview {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        print("Error load persistent stores: \(error.localizedDescription)")
      }
    }

    // If forPreview is true then we want to load up some mock data. Do this AFTER you call loadPersistentStores.
    if forPreview {
      addMockData(context: container.viewContext)
    }
   }
}

// Newly created entities are first added to context (memory) and then saved and persisted on the disk.
extension PersistenceController {
  func addMockData(context: NSManagedObjectContext) {
    let firstOffer = JobOfferEntity(context: context)
    firstOffer.companyName = "AV Studio"
    firstOffer.jobTitle = "UX Designér/ka"
    firstOffer.offerUrl = "https://www.startupjobs.cz/nabidka/69109/ux-designer-ka"
    firstOffer.salary = "40 000kč"
    firstOffer.notes = "Toto je poznámka"
    firstOffer.dateOfSentCv = DateComponents(year: 2023, month: 11, day: 14).date ?? Date()
    firstOffer.response = false
    // firstOffer.dateOfResponse: nil,
    firstOffer.firstRoundOfInterview = false
    // firstOffer.dateOfFirstRoundOfInterview = nil
    firstOffer.secondRoundOfInterview = false
    // firstOffer.dateOfSecondRoundOfInterview = nil
    firstOffer.thirdRoundOfInterview = false
    // firstOffer.dateOfThirdRoundOfInterview = nil
    firstOffer.fullTextOffer = """
      Ahoj,
      aktuálně hledáme nového kolegu nebo kolegyni na pozici UX Designér. Bavilo by tě spolupracovat s klienty jako například Angry Beards, Venira, BrainMarket nebo třeba Havlíkova Apotéka? Chceš pracovat v pohodovém týmu, chodit do práce i z práce s úsměvem a koukat na ostatní z 5. patra našich kanclů? Pojďme se seznámit! 🤝

                      Kdo jsme?
                      FV STUDIO, mladá firma z Brna, která se specializuje na UX webů i e-shopů, webový design a vývoj na míru. Pracujeme převážně na větších projektech pro Shoptet i Shoptet Premium, kde se staráme o klienty se stamilionovými obraty a ty jim díky spolupráci s námi jen a jen rostou. 👌

                      Jak to u nás funguje?
                      Nejsme jen kolegové, ale taky kámoši a funguje nám to skvěle! Chceš dovolenou? Už kupuj letenky! Chceš nové vybavení? Pošli odkazy a zítra máš! Nehrajeme na hierarchii, ale procesy a porady máme - jsou přece potřeba. O práci se bavíme vždy otevřeně, v kanceláři si rádi oddechneme u Xboxu a po práci zajdeme na pivko a drink. Prostě tým snů. A ty toho můžeš být součástí! 🙏

                      Koho hledáme?
                      Šikovného UX Designéra/ku, který už má za sebou pár zkušeností a pomůže nám přetvářet weby a e-shopy pro zákazníka tak, aby dávaly smysl a byly nejen pěkné, ale hlavně funkční, užívatelsky přívětivé a výkonné.

                      Co tě u nás čeká?
                      Potrpíme si na tvrdá data z vlastního výzkumu - designový proces včetně hloubkového výzkumu pro nás není jen teorie na papíře, ale každodenní chleba.
                      Ve výzkumné fázi projektu tě čeká desk research, interní rozhovory, uživatelské rozhovory včetně uživatelského testování a dotazníková řešení - vše si budeš navrhovat a řídit sám/a. Pro naše projekty využíváme výzkumnický repozitář Condens.
                      Analýza dat s cílem odhalení příležitostí pro další rozvoj webu i produktu.
                      Kreslení skic, tvorba wireframe a vizuální návrhy pro agilní vývoj designu.
                      Těsná koordinace s týmy zaměřenými na vývoj a produkt.
                      Vedení workshopů s klienty.
                      Zlepšování rychlosti a efektivity načítání webových stránek s možností hodnocení výsledků.
                      Kontinuální práce s dlouhodobými klienty.
                      Ovládání nástrojů určených pro návrh a vytváření prototypů, jako například Figma.


                      Co od tebe očekáváme?

                      Praktické znalosti v oblasti řízení UX projektů a organizace práce, včetně nastavování priorit.
                      Skvělé komunikativní a prezentační schopnosti.
                      Efektivní týmovou interakci.
                      Zkušenosti z pozice v oblasti e-commerce, kde bylo třeba rychle koncipovat a upravovat návrhy s orientací na finální výsledek.
                      Umění plánovat, řídit a analyzovat testy zaměřené na uživatele. Data od zákazníků považujeme za klíčový zdroj informací.
                      Umění transformovat složité výzvy na snadno použitelné uživatelské interfaces.


                      Co všechno získáš, když se k nám přidáš?

                      Super kolektiv absolutně přátelského týmu, o který se budeš moct opřít. 🧑‍🤝‍🧑
                      Freelance spolupráci na full-time a fér odměnu.
                      Kancly v Brně s chill zónou (Xbox - jedeme FIFU, máš se co učit, protože Milan a Jirka neradi prohrávají), občerstvením, kavárnou/bistrem přímo v budově a samozřejmě s možností parkování. 🏢
                      Pet-friendly office 🐶 a možnost jezdit do práce na kole. 🚴‍♂️
                      Možnost pracovat z domova 🏡 - home office je u nás normální, stejně jako flexibilní pracovní doba, ale minimálně 1x týdně tě budeme chtít vidět v kancelářích.⌛
                      Super mimopracovní akce a teambuildingy. 🍻
                      A v neposlední řadě možnost zvolit si pracovní stroj (Macbook nebo Asus) a příslušenství podle svých preferencí. 💻")
      """

    let secondOffer = JobOfferEntity(context: context)
    secondOffer.companyName = "Futured"
    secondOffer.jobTitle = "Full-stack vývojář (JavaScript, TypeScript)"
    secondOffer.offerUrl = "https://www.startupjobs.cz/nabidka/69531/full-stack-vyvojar-javascript-typescript"
    secondOffer.salary = ""
    secondOffer.notes = "Notes"
    secondOffer.dateOfSentCv = Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 1))
    secondOffer.response = true
    // secondOffer.status = .rejected
    secondOffer.dateOfResponse = Date.now
    secondOffer.firstRoundOfInterview = false
    secondOffer.secondRoundOfInterview = false
    secondOffer.thirdRoundOfInterview = false
    secondOffer.fullTextOffer = """
Chodíš rád*a nevyšlapanými cestami? Těší tě diskutovat s kolegy o nových technologiích a postupech? Výborně. Chceme tě poznat.

Je naprosto nezbytné...

JavaScript a TypeScript. Pravděpodobně tě nepřekvapí, že potřebujeme, abys znal JavaScript jako vlastní boty a TypeScript alespoň na běžné vývojářské úrovni.
Dobrá znalost VueJs nebo React. Máš za sebou už pár projektů nebo alespoň jeden větší? Víš co znamenají zkratky SPA, PWA, SSR a SSG? Co jsou to hooky nebo state management?
Mít CSS v malíčku. css-knowledge: great !important;
Zkušenost s psaním aplikací v NodeJs. Máš zkušenost s frameworky jako je NestJs nebo ExpressJs.
SQL či NoSQL, to je otázka. Je důležité mít zkušenost s alespoň jednou relační a/nebo dokumentovou databází.
Pracovat samostatně. Dostaneš se u nás k větším projektům, na kterých pracujeme ve více lidech, ale i menším, kde je za každou platformu jeden člověk. Proto potřebujeme, aby sis uměl poradit sám s dokumentací, Googlem či Stack Overflow. Samozřejmě to ale neznamená, že ti kolegové nebudou k dispozici na konzultace. Jsme tým.
Kvalitní čitelný kód. Nehledáme bouchače kódu, ale někoho, kdo nad kódem přemýšlí.
Je příjemný bonus...

Nejen REST, ale i GraphQL. GraphQL je super věc jak na frontendu, tak na backendu, a zkušenost s ním rozhodně oceníme.
Chceš se věnovat frontendu i backendu. V týmu uvažujeme full-stackově a rádi řešíme problémy komplexně.
Znáš se se stejnými technologiemi. Quasar framework, Pinia, TypeORM, Google Cloud Platform, Digital Ocean, MongoDB, Sentry nebo Firebase.
Docker. Lokální vývoj řešíme přes Docker Compose a aplikace balíme do kontejnerů.
Máš přesah do DevOps? Zvládáš konfigurovat cloudové služby, Kubernetes nebo sypeš linuxové příkazy z rukávu? Taková znalost se u nás neztratí.
Fascinuje tě AI. Nás také. Máš zájem prošlapávat nové cesty, které umožňuje aktuální boom AI technologií a služeb? Paráda, dáme ti k tomu prostor a nástroje.
Nebojíš se komunikace. Nemáš strach sdílet svůj názor. Není nic horšího než být s něčím nespokojený a mlčet. Konstruktivní kritika je pro nás důležitá.
Co za to?

Různorodé projekty. Ve Futured vyvíjíme oceňované aplikace, které používají lidé po celém světě. Jednou budeš pracovat v oblasti kreativity transportu, jindy se podíváš do gastro segmentu nebo poznáš trendy v oblasti zabezpečení.
Spolupráce s experty v oboru. Obklopíš se inspirativními lidmi, kteří neustále sledují nejnovější trendy ve světě webových i mobilních aplikací, zdokonalují vývojový proces a proaktivně předávají nabyté zkušenosti svým kolegům.
Neomezený rozpočet na vzdělávání. Technologie letí dopředu a vzdělávání je nezbytnost. Nechceme ho omezovat výší budgetu.
Příspěvek na hardware i software. Potřebuješ nový notebook, telefon nebo placený software? Každý má u nás nárok na jejich pořízení z firemních peněz. Stůl, židli, monitor, klávesnici a myš od nás dostaneš automaticky.
Odpočinek je důležitý. Ze začátku dostaneš 20 dní dovolené a volno o Vánocích. Pokud s námi zůstaneš tři roky, dostaneš pět dní dovolené navíc. A po pěti letech ve Futured už to bude deset dní.
Terapie. Přejeme si, aby našim kolegům bylo dobře, proto jsme navázali spolupráci s Terap.io, platformou, která poskytuje terapie online. Jednou měsíčně ji máš od nás jako dárek. Aby ti bylo líp.
Naše designové kanceláře. Navrhli jsme si je tak, abychom si je užívali. Že do nich kolegové chodí rádi (a dobrovolně), to je pro nás ta nejlepší zpětná vazba. Pokud ale potřebuješ pracovat z domu, home-office nám problém nedělá.
Co teď?

Dej dohromady ukázku kódu a pošli ji naší HR Míši. A pokud nemáš nic, co bys mohl sdílet, napiš a společně něco vymyslíme.

A co čekat potom? Do 2 dnů ti odpovíme. Potkáš se s HR Míšou a Full-stack Leadem Tomem. Seznámíme tě s našimi vývojáři a pobavíte se o technických záležitostech. Řekneme si ano, nebo ne :)
"""

    try? context.save()
  }
}
