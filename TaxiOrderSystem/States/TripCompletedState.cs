using System;
namespace TaxiOrderSystem.States
{
    public class TripCompletedState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Поездка завершена.");
        public override void ConfirmOrder() => Console.WriteLine("Поездка завершена.");
        public override void CarArrived() => Console.WriteLine("Поездка завершена.");
        public override void StartTrip() => Console.WriteLine("Поездка завершена.");
        public override void CompleteTrip() => Console.WriteLine("Поездка уже завершена.");
        public override void CancelOrder() => Console.WriteLine("Поездка завершена, отмена невозможна.");
    }
}
