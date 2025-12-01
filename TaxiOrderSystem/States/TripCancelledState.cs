using System;
namespace TaxiOrderSystem.States
{
    public class TripCancelledState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Заказ отменен.");
        public override void ConfirmOrder() => Console.WriteLine("Заказ отменен.");
        public override void CarArrived() => Console.WriteLine("Заказ отменен.");
        public override void StartTrip() => Console.WriteLine("Заказ отменен.");
        public override void CompleteTrip() => Console.WriteLine("Заказ отменен.");
        public override void CancelOrder() => Console.WriteLine("Заказ уже отменен.");
    }
}
