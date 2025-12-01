using System;
using TaxiOrderSystem;
using TaxiOrderSystem.States;
class Program
{
    static void Main(string[] args)
    {
        TaxiOrderContext order = new TaxiOrderContext(new IdleState());
        order.SelectCar();
        order.ConfirmOrder();
        order.CarArrived();
        order.StartTrip();
        order.CompleteTrip();
        order.CancelOrder();
    }
}
