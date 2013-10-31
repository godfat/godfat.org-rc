abstract class Human
case class Warrior() extends Human
case class Mage()    extends Human

val mages : List[Mage]  = List(Mage(), Mage())
val humans: List[Human] = mages

println(humans.contains(Mage()))

